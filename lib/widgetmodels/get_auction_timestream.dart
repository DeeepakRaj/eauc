import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntp/ntp.dart';
import 'package:intl/intl.dart';

class GetAuctionTimeStream {
  late DateTime currentTime, startDateTime, endDateTime;
  String auctionId;

  GetAuctionTimeStream(this.auctionId) {
    _getCurrentServerTime(auctionId);
  }

  String getProperDate(String retrievedDate) {
    DateTime date = DateTime.parse(retrievedDate);
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(date);
  }

  Future<void> _getCurrentServerTime(String auctionId) async {
    var ref = FirebaseFirestore.instance.collection(auctionId).doc('timings');
    ref.get().then((snapshot) {
      //TODO: change startAt to startDate later on
      startDateTime =
          DateTime.fromMillisecondsSinceEpoch(snapshot['start_Date']);
      endDateTime = DateTime.fromMillisecondsSinceEpoch(snapshot['end_Date']);
    });
    currentTime = await NTP.now();
    currentTime = currentTime.add(Duration(seconds: 1));
  }

  Stream<String> getAuctionTimeStream() {
    return Stream.periodic(Duration(seconds: 1), (count) {
      if (currentTime.isBefore(startDateTime))
        return 'Scheduled Date.' + getProperDate(startDateTime.toString());
      //TODO: Set status Upcoming, Live in firestore
      else
        return 'Time Remaining.' +
            endDateTime
                .difference(currentTime.add(Duration(seconds: count)))
                .toString();
    });
  }
}
