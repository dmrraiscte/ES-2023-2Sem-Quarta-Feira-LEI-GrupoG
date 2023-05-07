import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  int getLastDayOfMonth() {
    return DateTime(year, month + 1, 0).day;
  }

  int getFirstDayOfTheWeek() {
    return subtract(Duration(days: weekday - 1)).day;
  }

  String format({String pattern = "dd/MM/yyyy", int substring = -1}) {
    try {
      return DateFormat(pattern)
          .format(this)
          .substring(0, substring == -1 ? null : substring);
    } catch (e) {
      return "";
    }
  }

  bool isSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool isWeekend() {
    return weekday == 6 || weekday == 7;
  }

  ///Receives two dates: [date1] and [date2]
  ///Returns if this date is in between or at the same time of those two dates received above
  /// ´´´dart
  /// date1.isAtSameMomentAs(this) || date2.isAtSameMomentAs(this) || isInBetween(date1, date2)
  /// ´´´
  bool isInBetweenInclusive(DateTime date1, DateTime date2) {
    return date1.isAtSameMomentAs(this) ||
        date2.isAtSameMomentAs(this) ||
        isInBetween(date1, date2);
  }

  ///Receives two dates: [date1] and [date2]
  ///Returns if this date is in between the two dates received above
  /// ´´´dart:
  /// date1.isBefore(this) && date2.isAfter(this) || date2.isBefore(this) && date1.isAfter(this)
  /// ´´´
  bool isInBetween(DateTime date1, DateTime date2) {
    return date1.isBefore(this) && date2.isAfter(this) ||
        date2.isBefore(this) && date1.isAfter(this);
  }
}
