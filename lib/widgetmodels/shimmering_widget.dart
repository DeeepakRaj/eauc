import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringWidget extends StatelessWidget {
  final double width, height;

  ShimmeringWidget({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          height: height,
          width: width,
          color: Colors.grey.shade400,
        ),
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade200);
  }
}
