import 'package:intl/intl.dart';

class P01PROGRESSVAR {
  static String DropDownYear = '';
  static final currentYear = DateFormat('yyyy').format(DateTime.now());
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
