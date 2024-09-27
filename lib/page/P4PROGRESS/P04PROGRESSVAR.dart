import 'package:intl/intl.dart';

class P04PROGRESSVAR {
  static String DropDownType = '';
  static String DropDownYear = '';
  static String DropDownMonth = '';
  static String GroupA = 'Long sample preparation time';
  static String GroupB = 'No long sample preparation time';
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
  static final currentMonth = DateFormat('MMM').format(DateTime.now());
}
