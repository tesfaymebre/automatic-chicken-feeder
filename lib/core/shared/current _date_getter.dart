import 'package:intl/intl.dart';

getCurrDate() {
  String currDate = DateFormat('E, d MMM yyyy').format(DateTime.now());
  return currDate;
}
