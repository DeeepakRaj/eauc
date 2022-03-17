import 'package:flutter/material.dart';

class BlinkingLiveIndicatorLarge extends StatefulWidget {
  const BlinkingLiveIndicatorLarge({Key? key}) : super(key: key);

  @override
  _BlinkingLiveIndicatorLargeState createState() =>
      _BlinkingLiveIndicatorLargeState();
}

class _BlinkingLiveIndicatorLargeState extends State<BlinkingLiveIndicatorLarge>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 1.0,
      upperBound: 2.0,
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
              scale: _animationController,
              child: Text(
                '•',
                style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            width: 3,
          ),
          Text(
            'LIVE',
            style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
