import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntp/ntp.dart';
import 'package:intl/intl.dart';

class GetAuctionTimeStream {
  late DateTime currentTime, startDateTime, endDateTime;
  String auctionId;

  GetAuctionTimeStream(this.auctionId) {
    //Default constructor
    _getCurrentServerTime(auctionId);
  }

  String _printDuration(Duration duration) {
    //This function returns the time in format of hh:mm:ss
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String getProperDate(String retrievedDate) {
    //Return datetime in format of dd-MM-yyyy HH:mm:ss
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
    //Getting current time from server
    currentTime = await NTP.now();
    //Adding duration of 1 second due to latency
    currentTime = currentTime.add(Duration(seconds: 1));
  }

  Stream<String> getAuctionTimeStream() {
    return Stream.periodic(Duration(seconds: 1), (count) {
      if (currentTime.add(Duration(seconds: count)).isBefore(startDateTime))
        return 'Scheduled Date.' + getProperDate(startDateTime.toString());
      //TODO: Set status Upcoming, Live in firestore
      else if (currentTime.add(Duration(seconds: count)).isAfter(endDateTime))
        return 'Auction Ended.End of Auction';
      else
        //Returning the duration between current time and auction end time
        return 'Time Remaining.' +
            _printDuration(endDateTime
                .difference(currentTime.add(Duration(seconds: count))));
    });
  }
}
