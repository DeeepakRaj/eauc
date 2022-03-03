import 'package:flutter/material.dart';

class TagContainer extends StatelessWidget {
  final String tag;

  TagContainer(this.tag);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.blue.shade50,
              border: Border.all(color: Colors.blue.shade800)),
          child: Text(
            tag,
            maxLines: 1,
            style: TextStyle(
              color: Colors.blue.shade800,
              fontSize: 11,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 3,
        )
      ],
    );
  }
}
