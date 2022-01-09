import 'package:flutter/material.dart';

class SkeletonContainer extends StatefulWidget {
  final bool? loading;
  final Widget child;
  const SkeletonContainer(
      {Key? key, this.loading, this.child = const SizedBox()})
      : super(key: key);

  @override
  _SkeletonContainerState createState() => _SkeletonContainerState();
}

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class _SkeletonContainerState extends State<SkeletonContainer> {
  @override
  Widget build(BuildContext context) {
    if (widget.loading == null || widget.loading == false) return widget.child;
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return _shimmerGradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}
