import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class BounceCard extends StatelessWidget {
  BounceCard({
    super.key,
    this.child,
    this.color,
    this.padding,
    this.alignment,
    double? width,
    double? height,
    this.onPressed,
  }) : constraints = (width != null || height != null)
            ? BoxConstraints.tightFor(width: width, height: height)
            : const BoxConstraints();

  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Widget? child;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      duration: const Duration(milliseconds: 100),
      child: Card(
        //elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          constraints: constraints,
          padding: padding ?? const EdgeInsets.all(8.0),
          alignment: alignment ?? Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
