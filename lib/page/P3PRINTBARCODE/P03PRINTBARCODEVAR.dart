import 'dart:convert';

import 'package:intl/intl.dart';

import '../../bloc/BlocEvent/03-01-P03PRINTBARCODEGETDATA.dart';

class P03PRINTBARCODEVAR {
  static bool iscontrol = false;
  static String SEARCH = '';
  static bool isHoveredClear = false;
  static Map<String, List<P03PRINTBARCODEGETDATAclass>> groupedData = {};
  static String jsonData = '';
}
