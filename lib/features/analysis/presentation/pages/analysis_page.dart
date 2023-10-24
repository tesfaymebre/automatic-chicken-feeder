import 'package:chicken_feeder/core/shared/constants.dart';
import 'package:chicken_feeder/features/analysis/domain/entities/daily_report_entity.dart';
import 'package:chicken_feeder/features/analysis/domain/entities/monthlys_report_entity.dart';
import 'package:chicken_feeder/features/analysis/presentation/bloc/analysis_bloc.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shimmer/shimmer.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../domain/entities/weekly_report_entity.dart';
import '../widgets/BulletTextShimmer.dart';

class ReportPage extends StatefulWidget {
  ReportPage();

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late DailyReportEntity dailyReport;
  late WeeklyReportEntity weeklyReport;
  late MonthlyReportEntity monthlyReport;
  String selectedReportType = 'Weekly Report'; // Default selected report type
  late DateTime selectedEndDate;

  String elevatedButtonText = 'Choose the last date';
  String elevatedButtonDailyText = 'Choose the date';
  String elevatedButtonWeeklyText = 'Choose the last date';
  String elevatedButtonMonthlyText = 'Choose year and Month';

  bool isInitialLoad = true; // Track initial load

  Future<void> getDailyReportData(
      BuildContext context, DateTime startDate) async {
    BlocProvider.of<AnalysisBloc>(context)
        .add(GetDailyReportEvent(startDate: startDate));
  }

  Future<void> getWeeklyReportData(
      BuildContext context, DateTime endDate) async {
    BlocProvider.of<AnalysisBloc>(context)
        .add(GetWeeklyReportEvent(endDate: endDate));
  }

  Future<void> getMonthlyReportData(
      BuildContext context, int year, int month) async {
    BlocProvider.of<AnalysisBloc>(context)
        .add(GetMonthlyReportEvent(year: year, month: month));
  }

  @override
  void initState() {
    super.initState();
    selectedEndDate = DateTime.now().subtract(Duration(days: 1));
    getWeeklyReportData(context, selectedEndDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                style: TextStyle(color: Colors.white),
                value: selectedReportType,
                dropdownColor: Color(0xFF3B4CA6),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedReportType = newValue;

                      if (selectedReportType == 'Daily Report') {
                        elevatedButtonText = elevatedButtonDailyText;
                      } else if (selectedReportType == 'Weekly Report') {
                        elevatedButtonText = elevatedButtonWeeklyText;
                      } else {
                        elevatedButtonText = elevatedButtonMonthlyText;
                      }
                    });

                    if (selectedReportType == 'Daily Report') {
                      getDailyReportData(context, selectedEndDate);
                    } else if (selectedReportType == 'Weekly Report') {
                      getWeeklyReportData(context, selectedEndDate);
                    } else if (selectedReportType == 'Monthly Report') {
                      getMonthlyReportData(context, selectedEndDate.year,
                          selectedEndDate.month - 1);
                    }
                  }
                },
                items: <String>[
                  'Daily Report',
                  'Weekly Report',
                  'Monthly Report',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (selectedReportType == 'Monthly Report') {
                  _yearMonthPicker(context);
                } else {
                  _selectEndDate(context);
                }
              },
              child: Text('${elevatedButtonText}'),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AnalysisBloc, AnalysisState>(
        builder: (context, state) {
          print(state);
          if (state is WeeklyReportSuccess) {
            weeklyReport = state.weeklyReport;
            print(weeklyReport);

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Bar Chart',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: charts.BarChart(
                      createBarChartSeries(),
                      animate: true,
                      behaviors: [
                        charts.SelectNearest(
                          eventTrigger: charts.SelectionTrigger.tapAndDrag,
                        ),
                      ],
                      selectionModels: [
                        charts.SelectionModelConfig<String>(
                          type: charts.SelectionModelType.info,
                          changedListener: _onBarTapped,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        BulletText(' X-axis: days of the week.'),
                        BulletText(' Y-axis: total feeding amount in grams.'),
                        BulletText(' Green color: represents success.'),
                        BulletText(' Red color: represents failure.'),
                        BulletText(
                            ' Each bar represents the total feeding amount for a specific day.'),
                        BulletText(
                            ' Tap on a bar to view detailed information.'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Pie Chart',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: PieChart(
                      PieChartData(
                        sections: createPieChartSections(),
                        borderData: FlBorderData(show: false),
                        centerSpaceRadius: 40,
                        sectionsSpace: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        BulletText(' Green color: represents success rate.'),
                        BulletText(' Red color: represents failure rate.'),
                      ],
                    ),
                  ),
                  buildSummary(),
                ],
              ),
            );
          } else if (state is DailyReportSuccess) {
            dailyReport = state.dailyReport;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Bar Chart',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: charts.BarChart(
                      createBarChartSeriesDaily(),
                      animate: true,
                      behaviors: [
                        charts.SelectNearest(
                          eventTrigger: charts.SelectionTrigger.tapAndDrag,
                        ),
                      ],
                      selectionModels: [
                        charts.SelectionModelConfig<String>(
                          type: charts.SelectionModelType.info,
                          changedListener: _onBarTappedDaily,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        BulletText(' X-axis: specific time of the day.'),
                        BulletText(' Y-axis: total feeding amount in grams.'),
                        BulletText(' Green color: represents success.'),
                        BulletText(' Red color: represents failure.'),
                        BulletText(
                            ' Each bar represents the total feeding amount for a specific time.'),
                        BulletText(
                            ' Tap on a bar to view detailed information.'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Pie Chart',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: PieChart(
                      PieChartData(
                        sections: createPieChartSectionsDaily(),
                        borderData: FlBorderData(show: false),
                        centerSpaceRadius: 40,
                        sectionsSpace: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        BulletText(' Green color: represents success rate.'),
                        BulletText(' Red color: represents failure rate.'),
                      ],
                    ),
                  ),
                  buildSummaryDaily(),
                ],
              ),
            );
          } else if (state is MonthlyReportSuccess) {
            monthlyReport = state.monthlyReport;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Bar Chart',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    // height: 300,
                    // width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      height: 300,
                      width: fullScreenWidth(context),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return charts.BarChart(
                            createBarChartSeriesMonthly(),
                            animate: true,
                            domainAxis: charts.OrdinalAxisSpec(
                              renderSpec: charts.NoneRenderSpec(),
                            ),
                            behaviors: [
                              charts.SelectNearest(
                                eventTrigger:
                                    charts.SelectionTrigger.tapAndDrag,
                              ),
                            ],
                            selectionModels: [
                              charts.SelectionModelConfig<String>(
                                type: charts.SelectionModelType.info,
                                changedListener: _onBarTapped,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        BulletText(' X-axis: days of the month.'),
                        BulletText(' Y-axis: total feeding amount in grams.'),
                        BulletText(' Green color: represents success.'),
                        BulletText(' Red color: represents failure.'),
                        BulletText(
                            ' Each bar represents the total feeding amount for a specific day.'),
                        BulletText(
                            ' Tap on a bar to view detailed information.'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Pie Chart',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: PieChart(
                      PieChartData(
                        sections: createPieChartSectionsMonthly(),
                        borderData: FlBorderData(show: false),
                        centerSpaceRadius: 40,
                        sectionsSpace: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        BulletText(' Green color: represents success rate.'),
                        BulletText(' Red color: represents failure rate.'),
                      ],
                    ),
                  ),
                  buildSummaryMonthly(),
                ],
              ),
            );
          } else if (state is DailyReportFailure) {
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
          } else if (state is WeeklyReportFailure) {
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
          } else if (state is MonthlyReportFailure) {
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
            return Padding(
              padding: EdgeInsets.all(16),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ShimmerBarChart(),
                    BulletTextShimmer(),
                    BulletTextShimmer(),
                    BulletTextShimmer(),
                    BulletTextShimmer(),
                    BulletTextShimmer(),
                    BulletTextShimmer(),
                    BulletTextShimmer(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildSummaryDaily() {
    final start = dailyReport.report!.start!;
    final end = dailyReport.report!.end!;
    final totalFoodConsumption = dailyReport.report!.totalFoodConsumption!;
    final averageFoodConsumptionPerFeeding =
        dailyReport.report!.averageFoodConsumptionPerFeeding!;
    final numFeedings = dailyReport.report!.numFeedings!;
    final successRate = dailyReport.report!.successRate!;
    final failureRate = dailyReport.report!.failureRate!;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          BulletText('Start Date: $start'),
          BulletText('End Date: $end'),
          BulletText('Total Food Consumption: $totalFoodConsumption grams'),
          BulletText(
              'Average Food Consumption per Feeding: $averageFoodConsumptionPerFeeding grams'),
          BulletText('Number of Feedings: $numFeedings'),
          BulletText('Success Rate: ${successRate.toStringAsFixed(1)}%'),
          BulletText('Failure Rate: ${failureRate.toStringAsFixed(1)}%'),
        ],
      ),
    );
  }

  Widget buildSummary() {
    final startDate = weeklyReport.report!.startDate!;
    final endDate = weeklyReport.report!.endDate!;
    final totalFoodConsumption = weeklyReport.report!.totalFoodConsumption!;
    final averageFoodConsumptionPerFeeding =
        weeklyReport.report!.averageFoodConsumptionPerFeeding!;
    final numFeedings = weeklyReport.report!.numFeedings!;
    final successRate = weeklyReport.report!.successRate!;
    final failureRate = weeklyReport.report!.failureRate!;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          BulletText('Start Date: $startDate'),
          BulletText('End Date: $endDate'),
          BulletText('Total Food Consumption: $totalFoodConsumption grams'),
          BulletText(
              'Average Food Consumption per Feeding: $averageFoodConsumptionPerFeeding grams'),
          BulletText('Number of Feedings: $numFeedings'),
          BulletText('Success Rate: ${successRate.toStringAsFixed(1)}%'),
          BulletText('Failure Rate: ${failureRate.toStringAsFixed(1)}%'),
        ],
      ),
    );
  }

  Widget buildSummaryMonthly() {
    final year = monthlyReport.report!.year;
    final month = monthlyReport.report!.month;
    final startDate = monthlyReport.report!.startDate!;
    final endDate = monthlyReport.report!.endDate!;
    final totalFoodConsumption = monthlyReport.report!.totalFoodConsumption!;
    final averageFoodConsumptionPerFeeding =
        monthlyReport.report!.averageFoodConsumptionPerFeeding!;
    final numFeedings = monthlyReport.report!.numFeedings!;
    final successRate = monthlyReport.report!.successRate!;
    final failureRate = monthlyReport.report!.failureRate!;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          BulletText('Year: $year'),
          BulletText('Month: $month'),
          BulletText('Start Date: $startDate'),
          BulletText('End Date: $endDate'),
          BulletText('Total Food Consumption: $totalFoodConsumption grams'),
          BulletText(
              'Average Food Consumption per Feeding: $averageFoodConsumptionPerFeeding grams'),
          BulletText('Number of Feedings: $numFeedings'),
          BulletText('Success Rate: ${successRate.toStringAsFixed(1)}%'),
          BulletText('Failure Rate: ${failureRate.toStringAsFixed(1)}%'),
        ],
      ),
    );
  }

  void _yearMonthPicker(BuildContext context) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 30)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(Duration(days: 30)),
    );
    getMonthlyReportData(context, selected!.year, selected.month);
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(Duration(days: 1)),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });

      if (selectedReportType == 'Daily Report') {
        getDailyReportData(context, selectedEndDate);
      } else if (selectedReportType == 'Weekly Report') {
        getWeeklyReportData(context, selectedEndDate);
      } else if (selectedReportType == 'Monthly Report') {
        getMonthlyReportData(
            context, selectedEndDate.year, selectedEndDate.month);
      }
    }
  }

  List<charts.Series<DailyChartData, String>> createBarChartSeriesDaily() {
    final successDataPoints = dailyReport.report!.successDataPoints!;
    final failureDataPoints = dailyReport.report!.failureDataPoints!;

    final successSeries = charts.Series<DailyChartData, String>(
      id: 'Success',
      domainFn: (DailyChartData data, _) => getFormattedTimeOfDay(data.day),
      measureFn: (DailyChartData data, _) => data.amount,
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      data: successDataPoints
          .map((dataPoint) => DailyChartData(
                day: dataPoint.date!,
                amount: dataPoint.amount!,
                chickens: dataPoint.chickens!,
              ))
          .toList(),
    );

    final failureSeries = charts.Series<DailyChartData, String>(
      id: 'Failure',
      domainFn: (DailyChartData data, _) => getFormattedTimeOfDay(data.day),
      measureFn: (DailyChartData data, _) => data.amount,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      data: failureDataPoints
          .map((dataPoint) => DailyChartData(
                day: dataPoint.date!,
                amount: dataPoint.amount!,
                chickens: dataPoint.chickens!,
              ))
          .toList(),
    );

    return [successSeries, failureSeries];
  }

  List<charts.Series<ChartData, String>> createBarChartSeries() {
    final successDataPoints = weeklyReport.report!.successDataPoints!;
    final failureDataPoints = weeklyReport.report!.failureDataPoints!;

    final successSeries = charts.Series<ChartData, String>(
      id: 'Success',
      domainFn: (ChartData data, _) => getAbbreviatedDayOfWeek(data.day),
      measureFn: (ChartData data, _) => data.amount,
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      data: successDataPoints
          .map((dataPoint) => ChartData(
                day: dataPoint.date!,
                amount: dataPoint.amount!,
                averageFoodConsumptionPerFeeding:
                    dataPoint.averageFoodConsumptionPerFeeding!.toString(),
                numFeedings: dataPoint.numFeedings!,
                chickens: dataPoint.chickens!,
              ))
          .toList(),
    );

    final failureSeries = charts.Series<ChartData, String>(
      id: 'Failure',
      domainFn: (ChartData data, _) => getAbbreviatedDayOfWeek(data.day),
      measureFn: (ChartData data, _) => data.amount,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      data: failureDataPoints
          .map((dataPoint) => ChartData(
                day: dataPoint.date!,
                amount: dataPoint.amount!,
                averageFoodConsumptionPerFeeding:
                    dataPoint.averageFoodConsumptionPerFeeding!.toString(),
                numFeedings: dataPoint.numFeedings!,
                chickens: dataPoint.chickens!,
              ))
          .toList(),
    );

    return [successSeries, failureSeries];
  }

  List<charts.Series<ChartData, String>> createBarChartSeriesMonthly() {
    final successDataPoints = monthlyReport.report!.successDataPoints!;
    final failureDataPoints = monthlyReport.report!.failureDataPoints!;

    final successSeries = charts.Series<ChartData, String>(
      id: 'Success',
      domainFn: (ChartData data, _) => getFormattedDayOfMonth(data.day),
      measureFn: (ChartData data, _) => data.amount,
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      data: successDataPoints
          .map((dataPoint) => ChartData(
                day: dataPoint.date!,
                amount: dataPoint.amount!,
                averageFoodConsumptionPerFeeding:
                    dataPoint.averageFoodConsumptionPerFeeding!.toString(),
                numFeedings: dataPoint.numFeedings!,
                chickens: dataPoint.chickens!,
              ))
          .toList(),
    );

    final failureSeries = charts.Series<ChartData, String>(
      id: 'Failure',
      domainFn: (ChartData data, _) => getFormattedDayOfMonth(data.day),
      measureFn: (ChartData data, _) => data.amount,
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      data: failureDataPoints
          .map((dataPoint) => ChartData(
                day: dataPoint.date!,
                amount: dataPoint.amount!,
                averageFoodConsumptionPerFeeding:
                    dataPoint.averageFoodConsumptionPerFeeding!.toString(),
                numFeedings: dataPoint.numFeedings!,
                chickens: dataPoint.chickens!,
              ))
          .toList(),
    );

    return [successSeries, failureSeries];
  }

  String getFormattedTimeOfDay(String date) {
    final dateTime = DateTime.parse(date);
    final formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }

  String getAbbreviatedDayOfWeek(String date) {
    final dateTime = DateTime.parse(date);
    final abbreviatedWeekday = DateFormat('E').format(dateTime);
    return abbreviatedWeekday;
  }

  String getFormattedDayOfMonth(String date) {
    final dateTime = DateTime.parse(date);
    final formattedDay = DateFormat.d().format(dateTime);
    return formattedDay;
  }

  void _onBarTappedDaily(charts.SelectionModel<String> model) {
    if (model.hasDatumSelection) {
      final selectedDatum = model.selectedDatum.first;
      final DailyChartData dailyChartData = selectedDatum.datum;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bar Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Date: ${DateFormat.yMMMd().format(DateTime.parse(dailyChartData.day))}'),
                Text(
                    'Specific Time: ${DateFormat('h:mm a').format(DateTime.parse(dailyChartData.day))}'),
                Text('Amount: ${dailyChartData.amount}'),
                Text('Number of Chickens: ${dailyChartData.chickens}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  void _onBarTapped(charts.SelectionModel<String> model) {
    if (model.hasDatumSelection) {
      final selectedDatum = model.selectedDatum.first;
      final ChartData chartData = selectedDatum.datum;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bar Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Date: ${chartData.day}'),
                Text('Amount: ${chartData.amount}'),
                Text(
                    'Avg. Food Consumption: ${chartData.averageFoodConsumptionPerFeeding}'),
                Text('Number of Feedings: ${chartData.numFeedings}'),
                Text('Number of Chickens: ${chartData.chickens}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  List<PieChartSectionData> createPieChartSectionsDaily() {
    final successRate = dailyReport.report!.successRate!;
    final failureRate = dailyReport.report!.failureRate!;

    return [
      PieChartSectionData(
        value: successRate,
        title: '${successRate.toStringAsFixed(1)}%',
        color: Colors.green,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: failureRate,
        title: '${failureRate.toStringAsFixed(1)}%',
        color: Colors.red,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ];
  }

  List<PieChartSectionData> createPieChartSections() {
    final successRate = weeklyReport.report!.successRate!;
    final failureRate = weeklyReport.report!.failureRate!;

    return [
      PieChartSectionData(
        value: successRate,
        title: '${successRate.toStringAsFixed(1)}%',
        color: Colors.green,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: failureRate,
        title: '${failureRate.toStringAsFixed(1)}%',
        color: Colors.red,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ];
  }

  List<PieChartSectionData> createPieChartSectionsMonthly() {
    final successRate = monthlyReport.report!.successRate!;
    final failureRate = monthlyReport.report!.failureRate!;

    return [
      PieChartSectionData(
        value: successRate,
        title: '${successRate.toStringAsFixed(1)}%',
        color: Colors.green,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: failureRate,
        title: '${failureRate.toStringAsFixed(1)}%',
        color: Colors.red,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ];
  }
}

class DailyChartData {
  final String day;
  final int amount;
  final int chickens;

  DailyChartData({
    required this.day,
    required this.amount,
    required this.chickens,
  });
}

class ChartData {
  final String day;
  final int amount;
  final String averageFoodConsumptionPerFeeding;
  final int numFeedings;
  final int chickens;

  ChartData({
    required this.day,
    required this.amount,
    required this.averageFoodConsumptionPerFeeding,
    required this.numFeedings,
    required this.chickens,
  });
}

class BulletText extends StatelessWidget {
  final String text;

  const BulletText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 8,
          height: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
