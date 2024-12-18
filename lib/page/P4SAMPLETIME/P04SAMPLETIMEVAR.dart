import 'package:intl/intl.dart';

class P04SAMPLETIMEVAR {
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
  static final currentMonth2 = DateFormat('MM').format(DateTime.now());
  static String DropDownType = 'A';
  static String DropDownYear = currentYear;
  static String DropDownMonth = currentMonth2;
  static String GroupA = 'Long sample preparation time';
  static String GroupB = 'No long sample preparation time';
  static String convertMonthToMMM(String monthNumber) {
    int month = int.parse(monthNumber);
    DateTime dateTime = DateTime(2024, month, 1);
    String monthMMM = DateFormat('MMM').format(dateTime);
    return monthMMM;
  }
}
