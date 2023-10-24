import 'package:flutter/material.dart';

class ShimmerBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height / 2, // Half of the screen height
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[100]!,
                  Colors.grey[300]!,
                ],
                begin: Alignment(-1.0, -0.5),
                end: Alignment(1.0, -0.5),
                stops: [0.0, 0.5, 1.0],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey[300]!,
                    Colors.grey[100]!,
                    Colors.grey[300]!,
                  ],
                  begin: Alignment(-1.0, -0.5),
                  end: Alignment(1.0, -0.5),
                  stops: [0.0, 0.5, 1.0],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BulletTextShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 16,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[100]!,
                  Colors.grey[300]!,
                ],
                begin: Alignment(-1.0, -0.5),
                end: Alignment(1.0, -0.5),
                stops: [0.0, 0.5, 1.0],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey[300]!,
                    Colors.grey[100]!,
                    Colors.grey[300]!,
                  ],
                  begin: Alignment(-1.0, -0.5),
                  end: Alignment(1.0, -0.5),
                  stops: [0.0, 0.5, 1.0],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
