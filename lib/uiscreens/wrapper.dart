import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';
import 'auctions/auctions.dart';
import 'home/home.dart';
import 'hosted/hosted.dart';
import 'products/products.dart';

class Wrapper extends StatefulWidget {
  static const routename = '/wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int currentTabIndex = 0;
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
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: screens.elementAt(currentTabIndex),
      extendBody: true,
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 8),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomNavigationBar(
                iconSize: 30,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentTabIndex,
                onTap: _onItemTapped,
                selectedItemColor: Colors.white,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
                unselectedItemColor: Colors.white,
                backgroundColor: kprimarycolor,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard_outlined,
                      color: Colors.white,
                    ),
                    activeIcon: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    label: 'Auctions',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    activeIcon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: 'ADD',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shop_outlined, color: Colors.white),
                    activeIcon: Icon(
                      Icons.shop,
                      color: Colors.white,
                    ),
                    label: 'Products',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    activeIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: 'Hosted',
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 90,
            width: 90,
            child: FittedBox(
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: kprimarycolor,
                shape: CircleBorder(
                    side: BorderSide(color: Colors.white, width: 3)),
                onPressed: () {
                  print('Hi');
                },
                child: Icon(
                  Icons.add,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Material(
          //     type: MaterialType.transparency,
          //     //Makes it usable on any background color, thanks @IanSmith
          //     child: Ink(
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.white, width: 4.0),
          //         color: kprimarycolor,
          //         shape: BoxShape.circle,
          //       ),
          //       child: InkWell(
          //         //This keeps the splash effect within the circle
          //         borderRadius: BorderRadius.circular(
          //             1000.0), //Something large to ensure a circle
          //         onTap: () {
          //           print('Hi');
          //         },
          //         child: Padding(
          //           padding: EdgeInsets.all(25.0),
          //           child: Icon(
          //             Icons.add,
          //             size: 30.0,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     )),
        ],
      ),
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
