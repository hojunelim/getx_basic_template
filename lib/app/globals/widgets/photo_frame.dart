import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoFrame extends GetView {
  const PhotoFrame({Key? key, required this.url, this.width}) : super(key: key);

  final String url;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const RadialGradient(
          colors: [
            Colors.black,
            Colors.black,
            Colors.transparent,
          ],
          stops: [0.1, 0.5, 0.95],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstIn,
      child: Image.network(
        url,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
