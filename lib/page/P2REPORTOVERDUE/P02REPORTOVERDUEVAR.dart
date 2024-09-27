import 'package:intl/intl.dart';

class P02REPORTOVERDUEVAR {
  static List<int> sumList = [];
  static Map<String, double> AvgAllBreakdown = {};
  static List<double> avgAllBreakdown = [];
  static String DropDownType = '';
  static String DropDownYear = '';
  static String DropDownMonth = '';
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
  static final currentMonth = DateFormat('MMM').format(DateTime.now());
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
}
