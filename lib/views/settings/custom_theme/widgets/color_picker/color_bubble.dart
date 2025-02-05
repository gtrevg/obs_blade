import 'package:flutter/material.dart';
import 'package:obs_blade/utils/styling_helper.dart';

class ColorBubble extends StatelessWidget {
  final Color color;
  final double size;

  const ColorBubble({Key? key, required this.color, this.size = 24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.size,
      width: this.size,
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(this.size / 2),
        border: Border.all(
          color: StylingHelper.surroundingAwareAccent(context: context),
          width: 0.0,
        ),
      ),
    );
  }
}
