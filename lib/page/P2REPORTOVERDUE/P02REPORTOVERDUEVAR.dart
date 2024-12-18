import 'package:intl/intl.dart';

class P02REPORTOVERDUEVAR {
  static List<int> sumList = [];
  static Map<String, double> AvgAllBreakdown = {};
  static List<double> avgAllBreakdown = [];
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
  static final currentMonth2 = DateFormat('MM').format(DateTime.now());
  static String DropDownType = 'A';
  static String DropDownYear = currentYear;
  static String DropDownMonth = currentMonth2;
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
  static String GroupAsampleTime = 'A) Long sample preparation time';
  static String GroupBsampleTime = 'B) No long sample preparation time';
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
  static String convertMonthToMMM(String monthNumber) {
    int month = int.parse(monthNumber);
    DateTime dateTime = DateTime(2024, month, 1);
    String monthMMM = DateFormat('MMM').format(dateTime);
    return monthMMM;
  }
}
