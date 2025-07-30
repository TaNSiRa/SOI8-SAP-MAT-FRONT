// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print, deprecated_member_use
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/page/page5_1_PickingListDetail.dart';
import 'package:newmaster/page/page5_2_PickingListDetailSum.dart';
import '../../bloc/BlocEvent/05-01-P05PICKINGLISTGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import 'P05PICKINGLISTVAR.dart';

late BuildContext P05PICKINGLISTMAINcontext;

class P05PICKINGLISTMAIN extends StatefulWidget {
  P05PICKINGLISTMAIN({
    super.key,
    this.data,
  });
  List<P05PICKINGLISTGETDATAclass>? data;

  @override
  State<P05PICKINGLISTMAIN> createState() => _P05PICKINGLISTMAINState();
}

class _P05PICKINGLISTMAINState extends State<P05PICKINGLISTMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P05PICKINGLISTGETDATA_Bloc>().add(P05PICKINGLISTGETDATA_GET());
    P05PICKINGLISTVAR.iscontrol = true;
    P05PICKINGLISTVAR.SEARCH = '';
    P05PICKINGLISTVAR.DropDownPlant = 'SEP';
    P05PICKINGLISTVAR.searchDate = '';
  }

  bool isLoading = false;
  String? responseMessage;

  @override
  Widget build(BuildContext context) {
    P05PICKINGLISTMAINcontext = context;
    List<P05PICKINGLISTGETDATAclass> _datain = widget.data ?? [];

    List<P05PICKINGLISTGETDATAclass> filteredData = _datain.where((data) => 
    ( P05PICKINGLISTVAR.searchDate == data.Order_Picking_DT || P05PICKINGLISTVAR.searchDate == '' ) &&
    ( P05PICKINGLISTVAR.DropDownPlant == data.ST_Sep || P05PICKINGLISTVAR.DropDownPlant == 'SEP' )
    ).toList();


    List<P05PICKINGLISTGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      filteredData.where(
        (data) =>
            data.OrderNo.toLowerCase().contains(P05PICKINGLISTVAR.SEARCH) ||
            data.ProductName.toLowerCase().contains(P05PICKINGLISTVAR.SEARCH) ||
            data.Quantity.toLowerCase().contains(P05PICKINGLISTVAR.SEARCH) ||
            data.Tank.toLowerCase().contains(P05PICKINGLISTVAR.SEARCH) ||
            data.Lot.toLowerCase().contains(P05PICKINGLISTVAR.SEARCH) ||
            data.Order_Start_DT.toLowerCase()
                .contains(P05PICKINGLISTVAR.SEARCH) ||
            data.Order_Status.toLowerCase().contains(P05PICKINGLISTVAR.SEARCH),
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
                  'SAP-SCADA (PICKING LIST)',
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
                          Container(
                            height: 40,
                            width: 200,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context:
                                        context, // ใช้ context นี้แทน global
                                    /* initialDate: P05PICKINGLISTVAR.searchDate, */
                                    firstDate: DateTime(2024),
                                    lastDate: DateTime(2200),
                                  );
                                  if (pickedDate != null) {
                                    P05PICKINGLISTVAR.searchDate =
                                        formatDate(pickedDate.toString());
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        children: const [
                                          Icon(
                                            Icons.edit_calendar,
                                            color: Colors.blue,
                                            size: 25,
                                          ),
                                          Text(
                                            'Picking Date',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        P05PICKINGLISTVAR.searchDate.toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                P05PICKINGLISTVAR.isHoveredClear = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                P05PICKINGLISTVAR.isHoveredClear = false;
                              });
                            },
                            child: InkWell(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              onTap: () {
                                setState(() {
                                  P05PICKINGLISTVAR.isHoveredClear = false;
                                  P05PICKINGLISTVAR.iscontrol = true;
                                  P05PICKINGLISTVAR.SEARCH = '';
                                  P05PICKINGLISTVAR.DropDownPlant = 'SEP';
                                  P05PICKINGLISTVAR.searchDate = '';
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: P05PICKINGLISTVAR.isHoveredClear
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
                                          begin:
                                              P05PICKINGLISTVAR.isHoveredClear
                                                  ? 15
                                                  : 17,
                                          end: P05PICKINGLISTVAR.isHoveredClear
                                              ? 17
                                              : 15,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        builder: (context, size, child) {
                                          return TweenAnimationBuilder<Color?>(
                                            tween: ColorTween(
                                              begin: P05PICKINGLISTVAR
                                                      .isHoveredClear
                                                  ? Colors.redAccent.shade700
                                                  : Colors
                                                      .yellowAccent.shade700,
                                              end: P05PICKINGLISTVAR
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
                                        .read<P05PICKINGLISTGETDATA_Bloc>()
                                        .add(P05PICKINGLISTGETDATA_GET());
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
                                P05PICKINGLISTVAR.DropDownPlant = d;
                              });
                            },
                            value: P05PICKINGLISTVAR.DropDownPlant,
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
                                              child: Page5_2(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
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
                                  'PICKING LIST',
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
                                      P05PICKINGLISTVAR.DropCheck =
                                          !P05PICKINGLISTVAR.DropCheck;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: Icon(
                                    P05PICKINGLISTVAR.DropCheck
                                        ? Icons.filter_alt_off_rounded
                                        : Icons.filter_alt_rounded,
                                    color: P05PICKINGLISTVAR.DropCheck
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
                        child: P05PICKINGLISTVAR.DropCheck
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
                                                P05PICKINGLISTVAR.isChecked1 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked1;
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isChecked2 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked2;
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isChecked3 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked3;
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isChecked4 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked4;
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isChecked5 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked5;
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isChecked6 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked6;
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isChecked7 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked7;
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isChecked8 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked8;
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isChecked9 =
                                                    !P05PICKINGLISTVAR
                                                        .isChecked9;
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
                                                      value: P05PICKINGLISTVAR
                                                          .isChecked9,
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
                                                          P05PICKINGLISTVAR
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
                                                P05PICKINGLISTVAR.isCheckedALL =
                                                    !P05PICKINGLISTVAR
                                                        .isCheckedALL;

                                                P05PICKINGLISTVAR.isChecked1 =
                                                    P05PICKINGLISTVAR
                                                        .isCheckedALL;
                                                P05PICKINGLISTVAR.isChecked2 =
                                                    P05PICKINGLISTVAR
                                                        .isCheckedALL;
                                                P05PICKINGLISTVAR.isChecked3 =
                                                    P05PICKINGLISTVAR
                                                        .isCheckedALL;
                                                P05PICKINGLISTVAR.isChecked4 =
                                                    P05PICKINGLISTVAR
                                                        .isCheckedALL;
                                                P05PICKINGLISTVAR.isChecked5 =
                                                    P05PICKINGLISTVAR
                                                        .isCheckedALL;
                                                P05PICKINGLISTVAR.isChecked6 =
                                                    P05PICKINGLISTVAR
                                                        .isCheckedALL;
                                                P05PICKINGLISTVAR.isChecked7 =
                                                    P05PICKINGLISTVAR
                                                        .isCheckedALL;
                                                P05PICKINGLISTVAR.isChecked8 =
                                                    P05PICKINGLISTVAR
                                                        .isCheckedALL;
                                                P05PICKINGLISTVAR.isChecked9 =
                                                    P05PICKINGLISTVAR
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
                                                      value: P05PICKINGLISTVAR
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
                                                          P05PICKINGLISTVAR
                                                                  .isCheckedALL =
                                                              value ?? false;

                                                          P05PICKINGLISTVAR
                                                                  .isChecked1 =
                                                              P05PICKINGLISTVAR
                                                                  .isCheckedALL;
                                                          P05PICKINGLISTVAR
                                                                  .isChecked2 =
                                                              P05PICKINGLISTVAR
                                                                  .isCheckedALL;
                                                          P05PICKINGLISTVAR
                                                                  .isChecked3 =
                                                              P05PICKINGLISTVAR
                                                                  .isCheckedALL;
                                                          P05PICKINGLISTVAR
                                                                  .isChecked4 =
                                                              P05PICKINGLISTVAR
                                                                  .isCheckedALL;
                                                          P05PICKINGLISTVAR
                                                                  .isChecked5 =
                                                              P05PICKINGLISTVAR
                                                                  .isCheckedALL;
                                                          P05PICKINGLISTVAR
                                                                  .isChecked6 =
                                                              P05PICKINGLISTVAR
                                                                  .isCheckedALL;
                                                          P05PICKINGLISTVAR
                                                                  .isChecked7 =
                                                              P05PICKINGLISTVAR
                                                                  .isCheckedALL;
                                                          P05PICKINGLISTVAR
                                                                  .isChecked8 =
                                                              P05PICKINGLISTVAR
                                                                  .isCheckedALL;
                                                          P05PICKINGLISTVAR
                                                                  .isChecked9 =
                                                              P05PICKINGLISTVAR
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
                      5: FixedColumnWidth(130.0),
                      6: FixedColumnWidth(100.0),
                      7: FixedColumnWidth(90.0),
                      8: FixedColumnWidth(80.0),
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
                              child: Container(
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    'Picking Date',
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
                                          'Picking Data',
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
                          5: FixedColumnWidth(130.0),
                          6: FixedColumnWidth(100.0),
                          7: FixedColumnWidth(90.0),
                          8: FixedColumnWidth(80.0),
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
                                    child: Text(item.Order_Picking_DT),
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
                                    P05PICKINGLISTVAR.OrderStatusForSwitchAPI =
                                        item.Order_Status;
                                    P05PICKINGLISTVAR.OrderNo =item.OrderNo;
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
                                              child: Page5_1(),
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
