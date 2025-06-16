// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print, deprecated_member_use
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/01-01-P01DASHBOARDGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputTextTan.dart';
import '../../widget/common/ErrorPopup.dart';
import '../page2.dart';
import 'P01DASHBOARDVAR.dart';

late BuildContext P01DASHBOARDMAINcontext;

class P01DASHBOARDMAIN extends StatefulWidget {
  P01DASHBOARDMAIN({
    super.key,
    this.data,
  });
  List<P01DASHBOARDGETDATAclass>? data;

  @override
  State<P01DASHBOARDMAIN> createState() => _P01DASHBOARDMAINState();
}

class _P01DASHBOARDMAINState extends State<P01DASHBOARDMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET());
    P01DASHBOARDVAR.iscontrol = true;
    P01DASHBOARDVAR.SEARCH = '';
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    P01DASHBOARDMAINcontext = context;
    List<P01DASHBOARDGETDATAclass> _datain = widget.data ?? [];

    List<P01DASHBOARDGETDATAclass> filteredData = _datain.where((data) {
      // เช็คว่า isCheckedX ตัวไหนเป็น true แล้วกรองข้อมูลตามนั้น
      bool matchesCondition = false;

      // เช็คตามเงื่อนไขของ isChecked
      if (P01DASHBOARDVAR.isChecked1) {
        matchesCondition = matchesCondition || data.Order_Status == 'SAP';
      }
      if (P01DASHBOARDVAR.isChecked2) {
        matchesCondition = matchesCondition || data.Order_Status == 'GEN SEP';
      }
      if (P01DASHBOARDVAR.isChecked3) {
        matchesCondition = matchesCondition || data.Order_Status == 'SEP';
      }
      if (P01DASHBOARDVAR.isChecked4) {
        matchesCondition = matchesCondition || data.Order_Status == 'FULL';
      }
      if (P01DASHBOARDVAR.isChecked5) {
        matchesCondition = matchesCondition || data.Order_Status == 'SEP/FULL';
      }
      if (P01DASHBOARDVAR.isChecked6) {
        matchesCondition = matchesCondition || data.Order_Status == 'RECHECK';
      }
      if (P01DASHBOARDVAR.isChecked7) {
        matchesCondition = matchesCondition || data.Order_Status == 'TITRATING';
      }
      if (P01DASHBOARDVAR.isChecked8) {
        matchesCondition = matchesCondition || data.Order_Status == 'COMPLETE';
      }
      if (P01DASHBOARDVAR.isChecked9) {
        matchesCondition = matchesCondition || data.Order_Status == 'UNSUGGEST';
      }
      // print(matchesCondition);
      return matchesCondition;
    }).toList();

    List<P01DASHBOARDGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      filteredData.where(
        (data) =>
            data.OrderNo.toLowerCase().contains(P01DASHBOARDVAR.SEARCH) ||
            data.ProductName.toLowerCase().contains(P01DASHBOARDVAR.SEARCH) ||
            data.Quantity.toLowerCase().contains(P01DASHBOARDVAR.SEARCH) ||
            data.Tank.toLowerCase().contains(P01DASHBOARDVAR.SEARCH) ||
            data.Lot.toLowerCase().contains(P01DASHBOARDVAR.SEARCH) ||
            data.Order_Start_DT.toLowerCase()
                .contains(P01DASHBOARDVAR.SEARCH) ||
            data.Order_Status.toLowerCase().contains(P01DASHBOARDVAR.SEARCH),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: const [Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  'SAP-SCADA',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ComInputTextTan(
                            sPlaceholder: "Search...",
                            isSideIcon: true,
                            height: 40,
                            width: 400,
                            isContr: P01DASHBOARDVAR.iscontrol,
                            fnContr: (input) {
                              P01DASHBOARDVAR.iscontrol = input;
                            },
                            sValue: P01DASHBOARDVAR.SEARCH,
                            returnfunc: (String s) {
                              setState(() {
                                P01DASHBOARDVAR.SEARCH = s;
                              });
                            },
                          ),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                P01DASHBOARDVAR.isHoveredClear = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                P01DASHBOARDVAR.isHoveredClear = false;
                              });
                            },
                            child: InkWell(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              onTap: () {
                                setState(() {
                                  P01DASHBOARDVAR.isHoveredClear = false;
                                  P01DASHBOARDVAR.iscontrol = true;
                                  P01DASHBOARDVAR.SEARCH = '';
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: P01DASHBOARDVAR.isHoveredClear
                                        ? Colors.yellowAccent.shade700
                                        : Colors.redAccent.shade700,
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
                                        colors: const [
                                          Colors.white,
                                          Colors.red,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ).createShader(bounds),
                                      child: TweenAnimationBuilder<double>(
                                        tween: Tween<double>(
                                          begin: P01DASHBOARDVAR.isHoveredClear
                                              ? 15
                                              : 17,
                                          end: P01DASHBOARDVAR.isHoveredClear
                                              ? 17
                                              : 15,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        builder: (context, size, child) {
                                          return TweenAnimationBuilder<Color?>(
                                            tween: ColorTween(
                                              begin: P01DASHBOARDVAR
                                                      .isHoveredClear
                                                  ? Colors.redAccent.shade700
                                                  : Colors
                                                      .yellowAccent.shade700,
                                              end: P01DASHBOARDVAR
                                                      .isHoveredClear
                                                  ? Colors.yellowAccent.shade700
                                                  : Colors.redAccent.shade700,
                                            ),
                                            duration:
                                                Duration(milliseconds: 200),
                                            builder: (context, color, child) {
                                              return Text(
                                                'CLEAR',
                                                style: TextStyle(
                                                  fontSize: size,
                                                  color: color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<P01DASHBOARDGETDATA_Bloc>()
                                        .add(P01DASHBOARDGETDATA_GET());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: const Icon(
                                    Icons.refresh_rounded,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Refresh',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          AdvanceDropDown(
                            hint: "PLANT",
                            listdropdown: const [
                              MapEntry("ALL", "ALL"),
                              MapEntry("Titrating", "TT"),
                              MapEntry("Powder", "PD"),
                              MapEntry("Liquid", "LQ"),
                              MapEntry("Nox rust", "NR"),
                              MapEntry("SEP", "SEP")
                            ],
                            onChangeinside: (d, k) {
                              setState(() {
                                P01DASHBOARDVAR.DropDownPlant = d;
                              });
                            },
                            value: P01DASHBOARDVAR.DropDownPlant,
                            height: 50,
                            width: 100,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<P01DASHBOARDGETDATA_Bloc>()
                                        .add(P01DASHBOARDGETDATA_GET2());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: const Icon(
                                    Icons.print,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Print GEN SEP',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      P01DASHBOARDVAR.DropCheck =
                                          !P01DASHBOARDVAR.DropCheck;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: Icon(
                                    P01DASHBOARDVAR.DropCheck
                                        ? Icons.filter_alt_off_rounded
                                        : Icons.filter_alt_rounded,
                                    color: P01DASHBOARDVAR.DropCheck
                                        ? Colors.red
                                        : Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Filter Status',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: P01DASHBOARDVAR.DropCheck
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    //physics: ,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked1 =
                                                    !P01DASHBOARDVAR.isChecked1;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        Colors.yellow.shade700,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked1,
                                                      activeColor: Colors
                                                          .yellow.shade700,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked1 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "SAP",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .yellow.shade700,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked2 =
                                                    !P01DASHBOARDVAR.isChecked2;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.blueAccent,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked2,
                                                      activeColor:
                                                          Colors.blueAccent,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked2 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "GEN SEP",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked3 =
                                                    !P01DASHBOARDVAR.isChecked3;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.blueAccent,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked3,
                                                      activeColor:
                                                          Colors.blueAccent,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked3 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "SEP",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked4 =
                                                    !P01DASHBOARDVAR.isChecked4;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.blueAccent,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked4,
                                                      activeColor:
                                                          Colors.blueAccent,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked4 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "FULL",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked5 =
                                                    !P01DASHBOARDVAR.isChecked5;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.blueAccent,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked5,
                                                      activeColor:
                                                          Colors.blueAccent,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked5 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "SEP/FULL",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked6 =
                                                    !P01DASHBOARDVAR.isChecked6;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked6,
                                                      activeColor:
                                                          Colors.orange,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked6 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "RECHECK",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked7 =
                                                    !P01DASHBOARDVAR.isChecked7;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked7,
                                                      activeColor:
                                                          Colors.orange,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked7 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "TITRATING",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked8 =
                                                    !P01DASHBOARDVAR.isChecked8;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked8,
                                                      activeColor: Colors.green,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked8 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "COMPLETE",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isChecked9 =
                                                    !P01DASHBOARDVAR.isChecked9;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.orange,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isChecked9,
                                                      activeColor: Colors.orange,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isChecked9 =
                                                              value ?? false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "UNSUGGESTED",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                P01DASHBOARDVAR.isCheckedALL =
                                                    !P01DASHBOARDVAR
                                                        .isCheckedALL;

                                                P01DASHBOARDVAR.isChecked1 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                                P01DASHBOARDVAR.isChecked2 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                                P01DASHBOARDVAR.isChecked3 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                                P01DASHBOARDVAR.isChecked4 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                                P01DASHBOARDVAR.isChecked5 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                                P01DASHBOARDVAR.isChecked6 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                                P01DASHBOARDVAR.isChecked7 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                                P01DASHBOARDVAR.isChecked8 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                                P01DASHBOARDVAR.isChecked9 =
                                                    P01DASHBOARDVAR
                                                        .isCheckedALL;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 2),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      value: P01DASHBOARDVAR
                                                          .isCheckedALL,
                                                      activeColor: Colors.red,
                                                      checkColor: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          P01DASHBOARDVAR
                                                                  .isCheckedALL =
                                                              value ?? false;

                                                          P01DASHBOARDVAR
                                                                  .isChecked1 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                          P01DASHBOARDVAR
                                                                  .isChecked2 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                          P01DASHBOARDVAR
                                                                  .isChecked3 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                          P01DASHBOARDVAR
                                                                  .isChecked4 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                          P01DASHBOARDVAR
                                                                  .isChecked5 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                          P01DASHBOARDVAR
                                                                  .isChecked6 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                          P01DASHBOARDVAR
                                                                  .isChecked7 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                          P01DASHBOARDVAR
                                                                  .isChecked8 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                          P01DASHBOARDVAR
                                                                  .isChecked9 =
                                                              P01DASHBOARDVAR
                                                                  .isCheckedALL;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "ALL",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                      letterSpacing: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(
                                key: ValueKey(false),
                              ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FixedColumnWidth(100.0),
                      1: FixedColumnWidth(200.0),
                      2: FixedColumnWidth(100.0),
                      3: FixedColumnWidth(100.0),
                      4: FixedColumnWidth(100.0),
                      5: FixedColumnWidth(100.0),
                      6: FixedColumnWidth(100.0),
                      7: FixedColumnWidth(100.0),
                      8: FixedColumnWidth(100.0),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 50,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          'Order No',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 50,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          'Product Name',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 50,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          'Quantity',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 50,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          'Tank',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Container(
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    'Lot',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 50,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          'Start Date',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 50,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          'Status',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 50,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          'Inspection',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    height: 50,
                                    child: Container(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FixedColumnWidth(100.0),
                          1: FixedColumnWidth(200.0),
                          2: FixedColumnWidth(100.0),
                          3: FixedColumnWidth(100.0),
                          4: FixedColumnWidth(100.0),
                          5: FixedColumnWidth(100.0),
                          6: FixedColumnWidth(100.0),
                          7: FixedColumnWidth(100.0),
                          8: FixedColumnWidth(100.0),
                        },
                        children: _datasearch.map((item) {
                          // int dataCount = _datasearch.indexOf(item) + 1;
                          return TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(item.OrderNo),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(item.ProductName),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text('${item.Quantity} ${item.UOM}'),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(item.Tank),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(item.Lot),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(item.Order_Start_DT),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                      item.Order_Status,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            _getStatusColor(item.Order_Status),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    P01DASHBOARDVAR.OrderStatusForSwitchAPI =
                                        item.Order_Status;
                                    P01DASHBOARDVAR.SendAllDataToAPI =
                                        jsonEncode(item.toJson());
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Page2(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: P01DASHBOARDMAINcontext,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          title: Row(
                                            children: const [
                                              Icon(Icons.delete_forever_rounded,
                                                  color: Colors.red),
                                              SizedBox(width: 8),
                                              Text('Delete'),
                                            ],
                                          ),
                                          content: Text(
                                            'Are you sure you want to confirm delete?',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                P01DASHBOARDVAR
                                                        .SendAllDataToAPI =
                                                    jsonEncode(item.toJson());
                                                var response = await Dio().post(
                                                  "$APIArsa/soi8/DeleteOrder",
                                                  data: {
                                                    'dataOrder': P01DASHBOARDVAR
                                                        .SendAllDataToAPI
                                                  },
                                                );
                                                if (response.statusCode ==
                                                    200) {
                                                  Navigator.of(context).pop();
                                                  P01DASHBOARDMAINcontext.read<
                                                          P01DASHBOARDGETDATA_Bloc>()
                                                      .add(
                                                          P01DASHBOARDGETDATA_GET());
                                                } else {
                                                  print('Delete Fail');
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              child: Text('Confirm',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'SAP':
    case 'UNSUGGEST':
      return Colors.yellow.shade700;
    case 'GEN SEP':
    case 'SEP':
    case 'FULL':
    case 'SEP/FULL':
      return Colors.blue;
    case 'RECHECK':
    case 'TITRATING':
      return Colors.orange;
    case 'COMPLETE':
      return Colors.green;
    default:
      return Colors.red;
  }
}

// void PATTERNSET(BuildContext contextin) {
//   showDialog(
//     context: contextin,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: _Page1blockget(),
//       );
//     },
//   );
// }

// class _Page1blockget extends StatelessWidget {
//   const _Page1blockget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => P01DASHBOARDGETDATA_Bloc(),
//         child: BlocBuilder<P01DASHBOARDGETDATA_Bloc,
//             List<P01DASHBOARDGETDATAclass>>(
//           builder: (context, data) {
//             return testtest(
//               datasearch: data,
//             );
//           },
//         ));
//   }
// }

// class testtest extends StatefulWidget {
//   testtest({super.key, this.datasearch});
//   List<P01DASHBOARDGETDATAclass>? datasearch;
//   @override
//   State<testtest> createState() => _testtestState();
// }

// class _testtestState extends State<testtest> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context.read<P01DASHBOARDGETDATA_Bloc>().add(P01DASHBOARDGETDATA_GET2());
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<P01DASHBOARDGETDATAclass> _datasearch = widget.datasearch ?? [];
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: Center(
//                 child: ShaderMask(
//                   shaderCallback: (bounds) => LinearGradient(
//                     colors: const [Colors.blueAccent, Colors.lightBlueAccent],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ).createShader(bounds),
//                   child: Text(
//                     'Compare Data between SAP & SCADA',
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Table(
//                 border: TableBorder.all(),
//                 columnWidths: const {
//                   0: FixedColumnWidth(100.0),
//                   1: FixedColumnWidth(100.0),
//                   2: FixedColumnWidth(100.0),
//                   3: FixedColumnWidth(100.0),
//                   4: FixedColumnWidth(100.0),
//                   5: FixedColumnWidth(100.0),
//                   6: FixedColumnWidth(100.0),
//                   7: FixedColumnWidth(100.0),
//                   8: FixedColumnWidth(100.0),
//                 },
//                 children: [
//                   TableRow(
//                     children: [
//                       TableCell(
//                         child: SizedBox(
//                           height: 50,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 height: 50,
//                                 child: Container(
//                                   color: Colors.blue,
//                                   child: Center(
//                                     child: Text(
//                                       'Order No',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: SizedBox(
//                           height: 50,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 height: 50,
//                                 child: Container(
//                                   color: Colors.blue,
//                                   child: Center(
//                                     child: Text(
//                                       'Product Name',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: SizedBox(
//                           height: 50,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 height: 50,
//                                 child: Container(
//                                   color: Colors.blue,
//                                   child: Center(
//                                     child: Text(
//                                       'Quantity',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: SizedBox(
//                           height: 50,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 height: 50,
//                                 child: Container(
//                                   color: Colors.blue,
//                                   child: Center(
//                                     child: Text(
//                                       'Tank',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: SizedBox(
//                           height: 50,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 height: 50,
//                                 child: Container(
//                                   color: Colors.blue,
//                                   child: Center(
//                                     child: Text(
//                                       'Lot',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: SizedBox(
//                           height: 50,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 height: 50,
//                                 child: Container(
//                                   color: Colors.blue,
//                                   child: Center(
//                                     child: Text(
//                                       'Start Date',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: SizedBox(
//                           height: 50,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 height: 50,
//                                 child: Container(
//                                   color: Colors.blue,
//                                   child: Center(
//                                     child: Text(
//                                       'Status',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   ..._datasearch.map((item) {
//                     // int dataCount = _datasearch.indexOf(item) + 1;
//                     return TableRow(
//                       children: [
//                         // TableCell(
//                         //   child: SizedBox(
//                         //     height: 30,
//                         //     child: Center(
//                         //       child: Text(dataCount.toString()),
//                         //     ),
//                         //   ),
//                         // ),
//                         TableCell(
//                           child: SizedBox(
//                             height: 30,
//                             child: Center(
//                               child: Text(item.ORDERNO),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: SizedBox(
//                             height: 30,
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text('  ${item.PDNAME}'),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: SizedBox(
//                             height: 30,
//                             child: Center(
//                               child: Text(item.QUANTITY),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: SizedBox(
//                             height: 30,
//                             child: Center(
//                               child: Text(item.TANK),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: SizedBox(
//                             height: 30,
//                             child: Center(
//                               child: Text(item.LOT),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: SizedBox(
//                             height: 30,
//                             child: Center(
//                               child: Text(item.STDATE),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: SizedBox(
//                             height: 30,
//                             child: Center(
//                               child: Text(item.STATUS),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Confirm compare',
//                   style: const TextStyle(fontSize: 14, color: Colors.blue),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
