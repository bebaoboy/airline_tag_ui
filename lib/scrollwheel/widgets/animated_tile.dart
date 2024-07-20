import 'package:flutter/material.dart';

// Wraps the child in a Transform with the given slide and
// an AnimatedBuilder with the given animation.
class AnimatedTile extends StatelessWidget {
  const AnimatedTile({
    super.key,
    required this.animation,
    required this.slide,
    required this.child,
    required this.chainCurve,
  });

  final Animation<double> animation;
  final int slide;
  final Widget child;
  final Curve chainCurve;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: child, //<--this is important!
        builder: (context, child) {
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: chainCurve,
              ),
            ),
            child: Transform(
              transform: Matrix4.translationValues(
                  0, (1.0 - animation.value) * slide, 0),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: child), //<--Otherwise this doesn't work
            ),
          );
        });
  }
}
