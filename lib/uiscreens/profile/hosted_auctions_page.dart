import 'package:flutter/material.dart';

class HostedAuctionsPage extends StatefulWidget {
  const HostedAuctionsPage({Key? key}) : super(key: key);

  @override
  _HostedAuctionsPageState createState() => _HostedAuctionsPageState();
}

class _HostedAuctionsPageState extends State<HostedAuctionsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text('Tabs Demo'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                isScrollable: false,
                tabs: [
                  Tab(child: Text('Live')),
                  Tab(child: Text('Upcoming')),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
            Icon(Icons.directions_bike, size: 350),
            Icon(Icons.directions_boat, size: 350),
          ],
        ),
      )),
    );
  }
}
