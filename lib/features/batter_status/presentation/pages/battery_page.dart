import 'package:flutter/material.dart';

class BatteryLevelIndicator extends StatelessWidget {
  final int batteryLevelValue;

  BatteryLevelIndicator({required this.batteryLevelValue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${batteryLevelValue}%',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 160,
              height: 240,
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: batteryLevelValue / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: batteryLevelValue > 30
                        ? Colors.green
                        : (batteryLevelValue > 10 ? Colors.orange : Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
