import 'package:intl/intl.dart';

String mapDurations(DateTime curr, DateTime posted) {
  int Duration = curr.difference(posted).inSeconds;
  var time = DateFormat('yy-MM-dd').format(posted);
  if (Duration <= 0) {
    time = Duration > 0 ? '${Duration.toString()} sec' : "1sec";
  } else if (Duration >= 60 && Duration < 3600) {
    time = '${curr.difference(posted).inMinutes.toString()} min';
  } else if (Duration >= 3600 && Duration < 86400) {
    time = '${curr.difference(posted).inHours.toString()} hr';
  } else if (Duration >= 86400 && Duration < 604800) {
    time = '${curr.difference(posted).inDays.toString()} day';
  } else {
    final diff = curr.difference(posted).inDays;
    if (Duration >= 604800 && Duration < 2764800) {
      time = '${(diff / 7).floor().toString()} weeks';
    } else if (Duration >= 2764800 && Duration < 31536000) {
      time = '${(diff / 31).floor().toString()} month';
    }
    time = '${(diff / 365).floor().toString()} year';
  }

  return time.toString();
}
