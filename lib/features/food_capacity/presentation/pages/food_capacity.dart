import 'package:chicken_feeder/features/food_capacity/domain/entities/food_container_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/food_capacity_bloc.dart';
import '../widgets/mass_gauge_shimmer.dart';

class MassGauge extends StatelessWidget {
  final double value;
  final double maxCapacity;

  const MassGauge({
    Key? key,
    required this.value,
    required this.maxCapacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = (value / maxCapacity) * 100;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Food Container Mass'),
      // ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double scaleFactor = constraints.maxWidth > 600 ? 1.5 : 1.0;
            double fontSize = 20 * scaleFactor;

            return SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 0,
                  maximum: maxCapacity,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 0,
                      endValue: maxCapacity * 0.15,
                      color: Colors.red,
                      sizeUnit: GaugeSizeUnit.factor,
                      startWidth: 0.1 * scaleFactor,
                      endWidth: 0.11 * scaleFactor,
                    ),
                    GaugeRange(
                      startValue: maxCapacity * 0.15,
                      endValue: maxCapacity * 0.20,
                      color: Colors.orange,
                      sizeUnit: GaugeSizeUnit.factor,
                      startWidth: 0.11 * scaleFactor,
                      endWidth: 0.12 * scaleFactor,
                    ),
                    GaugeRange(
                      startValue: maxCapacity * 0.20,
                      endValue: maxCapacity * 0.60,
                      color: Colors.yellow,
                      sizeUnit: GaugeSizeUnit.factor,
                      startWidth: 0.12 * scaleFactor,
                      endWidth: 0.13 * scaleFactor,
                    ),
                    GaugeRange(
                      startValue: maxCapacity * 0.60,
                      endValue: maxCapacity,
                      color: Colors.green,
                      sizeUnit: GaugeSizeUnit.factor,
                      startWidth: 0.13 * scaleFactor,
                      endWidth: 0.14 * scaleFactor,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: value,
                      needleColor: Colors.black,
                      needleStartWidth: 1 * scaleFactor,
                      needleEndWidth: 8 * scaleFactor,
                      enableAnimation: true,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Container(
                        child: Text(
                          '${value.toStringAsFixed(2)} g',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.6,
                    ),
                    GaugeAnnotation(
                      widget: Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: fontSize * 0.8,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.8,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FoodCapacityPage extends StatefulWidget {
  final double level;

  const FoodCapacityPage({Key? key, required this.level}) : super(key: key);

  @override
  State<FoodCapacityPage> createState() => _FoodCapacityPageState();
}

class _FoodCapacityPageState extends State<FoodCapacityPage> {
  late FoodContainerEntity foodContainerEntity;
  bool isInitialLoad = true; // Track initial load
  Future<void> getFoodContainerData(context) async {
    BlocProvider.of<FoodCapacityBloc>(context).add(GetFoodContainerDataEvent());
  }

  Future<void> _refreshHomePage() async {
    await getFoodContainerData(context);
  }

  @override
  void initState() {
    super.initState();
    getFoodContainerData(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCapacityBloc, FoodCapacityState>(
      builder: (context, state) {
        if (state is FoodCapacityDataSuccess) {
          foodContainerEntity = state.foodContainerEntity;
          return RefreshIndicator(
            onRefresh: _refreshHomePage,
            child: MassGauge(
              value: foodContainerEntity.currentCapacity,
              maxCapacity: foodContainerEntity.feedingCapacity,
            ),
          );
        } else if (state is FoodCapacityDataFailure) {
          if (isInitialLoad) {
            // Set isInitialLoad to false to prevent initial failure snack bar
            isInitialLoad = false;
          } else {
            // Display error message using a SnackBar
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  duration: Duration(seconds: 2),
                ),
              );
            });
          }
          return Center(child: CircularProgressIndicator());
        } else {
          // Show shimmer effect while loading
          return Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: MassGaugeShimmer(),
            ),
          );
        }
      },
    );
  }
}
