import 'package:intl/intl.dart';

class P06TABLEREPORTOVERDUEVAR {
  static bool iscontrol = false;
  static String SEARCH = '';
  static bool isHoveredClear = false;
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
  static final currentMonth = DateFormat('MMM').format(DateTime.now());
  static final currentMonth2 = DateFormat('MM').format(DateTime.now());
  static String DropDownGroup = 'All';
  static String DropDownYear = currentYear;
  static String DropDownMonth = currentMonth2;
}
