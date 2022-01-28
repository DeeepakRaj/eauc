import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';
import 'auctions.dart';
import 'home.dart';
import 'hosted.dart';
import 'products.dart';

class Wrapper extends StatefulWidget {
  static const routename = '/wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int currentTab = 0;
  final List<Widget> screens = <Widget>[
    Home(),
    Auctions(),
    Products(),
    Hosted(),
  ];

  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  void initState() {
    super.initState();
    print('Inside wrapper');
  }

  void _onItemTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: PageStorage(
        bucket: pageStorageBucket,
        child: currentScreen,
      ),
      extendBody: true,
    );
  }
}
// class Wrapper extends StatefulWidget {
//   static const routename = '/wrapper';
//
//   @override
//   _WrapperState createState() => _WrapperState();
// }
//
// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(bottom: 0, left: 0, child: Container(
//             width: size.width,
//             height: size.height/10,
//             // color: kprimarycolor,
//             child: Stack(
//               children: [
//                 CustomPaint(
//                   size: Size(size.width,size.height/10),
//                   painter: BNBCustomPainter(),
//                 )
//               ],
//             ),
//           ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
