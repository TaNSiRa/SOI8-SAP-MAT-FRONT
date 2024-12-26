import 'package:intl/intl.dart';

class P07ASSEMBLEGRAPHVAR {
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
  static final currentMonth2 = DateFormat('MM').format(DateTime.now());
  static String DropDownType = 'A';
  static String DropDownYear = currentYear;
  static String DropDownMonth = currentMonth2;
  static String GroupA = 'Long sample preparation time';
  static String GroupB = 'No long sample preparation time';
  static String GroupAsampleTime = 'A) Long sample preparation time';
  static String GroupBsampleTime = 'B) No long sample preparation time';
  static String convertMonthToMMM(String monthNumber) {
    int month = int.parse(monthNumber);
    DateTime dateTime = DateTime(2024, month, 1);
    String monthMMM = DateFormat('MMM').format(dateTime);
    return monthMMM;
  }

  static const List<String> months = [
    'Avg',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  static const List<String> breakdown = [
    'All day for Make Report',
    'Sent customer',
    'JPN approve',
    'Mgr approve',
    'GL approve',
    'Sub lead approve',
    'Revise Report',
    'Issued Report',
    'TTC analysis',
    'Sampling - TTC',
  ];
  static const List<double> GroupATargetDays = [
    12,
    1,
    1,
    1,
    2,
    2,
    1,
    2,
    3,
    2,
  ];
  static const List<double> GroupBTargetDays = [
    10,
    1,
    1,
    1,
    2,
    2,
    1,
    1,
    3,
    1,
  ];
}
