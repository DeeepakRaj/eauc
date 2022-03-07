import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class Hosted extends StatefulWidget {
  static const routename = '/hostedpage';

  @override
  _HostedState createState() => _HostedState();
}

class _HostedState extends State<Hosted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOSTED'),
      ),
      drawer: CustomNavigationDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/images/hostedpagemainimg.jpg',
                  width: double.infinity,
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
