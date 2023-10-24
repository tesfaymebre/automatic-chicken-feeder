import 'package:flutter/material.dart';

class MassGaugeShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth > 600 ? 300 : 200;
        double containerHeight = constraints.maxWidth > 600 ? 500 : 350;
        double smallContainerWidth = constraints.maxWidth > 600 ? 180 : 120;
        double largeContainerWidth = constraints.maxWidth > 600 ? 240 : 160;
        double spacing = constraints.maxWidth > 600 ? 24 : 16;

        return Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                width: containerWidth,
                height: containerHeight,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: smallContainerWidth,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: spacing),
                  Container(
                    width: largeContainerWidth,
                    height: containerHeight - 30 - spacing,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
