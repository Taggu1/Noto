import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toDateTimeString() {
    print(this);
    return DateFormat("MMM d, h:mm a").format(this);
  }

  String toDateString() {
    return DateFormat("EEEE, MMM d").format(this);
  }

  bool isAfterDate(DateTime date) {
    return year >= date.year && month >= date.month && day > date.day;
  }
}

DateTime dateTimeFromString({required String dateTimeString}) {
  final date = DateFormat("MMM d, h:mm a").parse(dateTimeString);
  print(date.year);

  return DateTime(
    DateTime.now().year,
    date.month,
    date.day,
    date.hour,
    date.minute,
  );
}

Time timeFromSting({required String string}) {
  final date = dateTimeFromString(dateTimeString: string);

  final hour = date.hour;
  final minute = date.minute;

  return Time(hour: hour, minute: minute);
}

DateTime dateTimeFromTime({required Time time}) {
  final now = DateTime.now();

  return DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
    time.second,
  );
}
