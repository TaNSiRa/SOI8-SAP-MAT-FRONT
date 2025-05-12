// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
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
  static String Def = '';
  static String LOCATION = '';

  static List<String> DefList = [];
  static List<String> LOCATIONList = [];
}

class logindata {
  static bool isControl = false;
  static String userID = '';
  static String userPASS = '';
  static String loginlink = '';
  static WebSocketChannel? channel;
  static bool isLoggedIn = false;
}

String PageName = '';
String serverG = 'http://172.23.10.51:15152/';
String APIArsa = 'http://172.23.10.168:12123';
String WebSocketAPI = 'ws://172.23.10.168:12123';

//String APIArsa = 'http://127.0.0.1:12123';
//String WebSocketAPI = 'ws://127.0.0.1:12123';

var now = DateTime.now();
String formattedDate = DateFormat('dd-MMM-yy').format(now);

late BuildContext contextBG;
