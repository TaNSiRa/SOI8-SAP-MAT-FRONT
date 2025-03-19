// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../page/page0.dart';

String token = '';
String selectpage = '';
Widget CuPage = const Page0();
int CuPageLV = 0;

class USERDATA {
  static int UserLV = 0;
  static String NAME = '';
  static String ID = '';
  static String Section = '';
  static String Branch = '';
  static String INSMASTER = '';
  static String ACTION = '';
  static String BRANCHNUMBER = '';
  static String PLANT = '';
  static String PLANTNUMBER = '';
  static String PLANTNAME = '';
  static String TANK = '';
  static String ORDER = '';
  static String CONTEXT = '';
}

class logindata {
  static bool isControl = false;
  static String userID = '';
  static String userPASS = '';
}

String PageName = '';
String serverG = 'http://172.23.10.51:15152/';
// String APIArsa = 'http://172.23.10.51:14014';
// String APIArsa = 'http://172.20.43.221:14000';
String APIArsa = 'http://172.18.40.201:14014';
String PrintGenTag = 'http://127.0.0.1:14014';

var now = DateTime.now();
String formattedDate = DateFormat('dd-MMM-yy').format(now);

late BuildContext contextBG;
