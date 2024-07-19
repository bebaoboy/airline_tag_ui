import 'package:flutter/material.dart';

class CloseIcon extends StatelessWidget {
  final Function() onPress;
  final Color iconColor;
  final double closeIconSize;

  const CloseIcon({
    super.key,
    required this.onPress,
    required this.iconColor,
    required this.closeIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Icon(
        Icons.arrow_back,
        color: iconColor,
        size: closeIconSize,
      ),
    );
  }
}
