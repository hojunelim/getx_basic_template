import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class BounceCard extends StatelessWidget {
  const BounceCard({
    Key? key,
    this.child,
    this.color = 'primary',
    this.onPressed,
  }) : super(key: key);

  final Widget? child;
  final String? color;
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
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
