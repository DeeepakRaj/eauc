import 'dart:async';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class DisplayAuctionCountdown extends StatefulWidget {
  final String auctionId;

  DisplayAuctionCountdown({required this.auctionId});

  @override
  _DisplayAuctionCountdownState createState() =>
      _DisplayAuctionCountdownState();
}

class _DisplayAuctionCountdownState extends State<DisplayAuctionCountdown> {
  late DateTime currentTime, startDateTime, endDateTime;

  @override
  void initState() {
    super.initState();
    _getCurrentServerTime();
  }

  Future<void> _getCurrentServerTime() async {
    var ref =
        FirebaseFirestore.instance.collection(widget.auctionId).doc('timings');
    ref.get().then((snapshot) {
      //TODO: change startAt to startDate later on
      startDateTime =
          DateTime.fromMillisecondsSinceEpoch(snapshot['start_Date']);
      endDateTime = DateTime.fromMillisecondsSinceEpoch(snapshot['end_Date']);
    });
    currentTime = await NTP.now();
    currentTime = currentTime.add(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1), (count) {
        if (currentTime.isBefore(startDateTime))
          return startDateTime.toString();
        //TODO: Set status Upcoming, Live in firestore
        else
          return endDateTime
              .difference(currentTime.add(Duration(seconds: count)))
              .toString();
      }),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return ShimmeringWidget(width: 100, height: 20);
        } else if (snapshot.data.toString() == 'null') {
          return ShimmeringWidget(width: 100, height: 20);
        } else {
          return Text(
            snapshot.data.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.red),
          );
        }
      },
    );
  }
}
