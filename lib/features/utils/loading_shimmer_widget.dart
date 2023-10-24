import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double radius;
  final Color backgroundColor;
  final Widget? child;

  LoadingWidget.rectangular({
    super.key,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.radius = 8.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.child,
    required this.height,
    // this.height = double.infinity,
  }) : shapeBorder =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));

  const LoadingWidget.circular({
    super.key,
    this.width = double.infinity,
    required this.height,
    // this.height = double.infinity,
    this.radius = 8.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.shapeBorder = const CircleBorder(),
    this.child,
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: backgroundColor,
        highlightColor: Color(0xFFEEEEEE),
        period: const Duration(seconds: 2),
        child: Container(
          margin: margin,
          padding: padding,
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: shapeBorder,
          ),
          child: child,
        ),
      );
}
