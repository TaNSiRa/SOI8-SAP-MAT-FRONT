import 'package:intl/intl.dart';

class P01CUSSERVICEVAR {
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
  static String DropDownYear = currentYear;
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
}
