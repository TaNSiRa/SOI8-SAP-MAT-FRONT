import 'package:intl/intl.dart';

class P06PROGRESSVAR {
  static bool iscontrol = false;
  static String SEARCH = '';
  static bool isHoveredClear = false;
  static String DropDownGroup = '';
  static String DropDownYear = '';
  static String DropDownMonth = '';
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
  static final currentMonth = DateFormat('MMM').format(DateTime.now());
}
