// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/widget/common/ComInputTextTan.dart';
import '../../bloc/BlocEvent/04-01-P4ORDERHISTORYGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ErrorPopup.dart';
import 'P4ORDERHISTORYVAR.dart';
import 'SUB_PAGE/P04ORDERDETAILMAIN.dart';
import 'SUB_PAGE/P04ORDEREDIT.dart';

late BuildContext P4ORDERHISTORYMAINcontext;

class P4ORDERHISTORYMAIN extends StatefulWidget {
  P4ORDERHISTORYMAIN({
    super.key,
    this.data,
  });
  List<P4ORDERHISTORYGETDATAclass>? data;

  @override
  State<P4ORDERHISTORYMAIN> createState() => _P4ORDERHISTORYMAINState();
}

class _P4ORDERHISTORYMAINState extends State<P4ORDERHISTORYMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P4ORDERHISTORYGETDATA_Bloc>().add(P4ORDERHISTORYGETDATA_GET());
    P4ORDERHISTORYVAR.iscontrol = true;
    P4ORDERHISTORYVAR.SEARCH = '';
    P4ORDERHISTORYVAR.DropDownPlant = 'ALL';
    DateTime now = DateTime.now();
    P4ORDERHISTORYVAR.searchDateSTA = formatDate(now.toString());
    P4ORDERHISTORYVAR.searchDateEND = formatDate(now.toString());
    P4ORDERHISTORYVAR.OrderNo = '';
  }

  bool isLoading = false;
  String? responseMessage;

  @override
  Widget build(BuildContext context) {
    P4ORDERHISTORYMAINcontext = context;
    List<P4ORDERHISTORYGETDATAclass> _datain = widget.data ?? [];

    List<P4ORDERHISTORYGETDATAclass> filteredData = _datain
        .where((data) => (P4ORDERHISTORYVAR.DropDownPlant == data.ST_Sep ||
            P4ORDERHISTORYVAR.DropDownPlant == 'ALL'))
        .toList();

    List<P4ORDERHISTORYGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      filteredData.where(
        (data) =>
            data.OrderNo.toLowerCase().contains(P4ORDERHISTORYVAR.SEARCH) ||
            P4ORDERHISTORYVAR.SEARCH == '' ||
            data.ProductName.toLowerCase().contains(P4ORDERHISTORYVAR.SEARCH) ||
            data.Quantity.toLowerCase().contains(P4ORDERHISTORYVAR.SEARCH) ||
            data.Tank.toLowerCase().contains(P4ORDERHISTORYVAR.SEARCH) ||
            data.Lot.toLowerCase().contains(P4ORDERHISTORYVAR.SEARCH) ||
            data.Order_Start_DT.toLowerCase()
                .contains(P4ORDERHISTORYVAR.SEARCH) ||
            data.Order_Status.toLowerCase().contains(P4ORDERHISTORYVAR.SEARCH),
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
                  'SAP-SCADA (ORDER HISTORY)',
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
                            sPlaceholder: "ORDER NO...",
                            isSideIcon: true,
                            height: 40,
                            width: 200,
                            isContr: P4ORDERHISTORYVAR.iscontrol,
                            fnContr: (input) {
                              P4ORDERHISTORYVAR.iscontrol = input;
                            },
                            sValue: P4ORDERHISTORYVAR.OrderNo,
                            returnfunc: (String s) {
                              P4ORDERHISTORYVAR.OrderNo = s;
                            },
                            onSubmitted: (String s) {
                              print(s);

                              setState(() {
                                context
                                    .read<P4ORDERHISTORYGETDATA_Bloc>()
                                    .add(P4ORDERHISTORYGETDATA_GET());
                              });
                            },
                          ),
                          SizedBox(width: 5),
                          ComInputTextTan(
                            sPlaceholder: "Search...",
                            isSideIcon: true,
                            height: 40,
                            width: 200,
                            isContr: P4ORDERHISTORYVAR.iscontrol,
                            fnContr: (input) {
                              P4ORDERHISTORYVAR.iscontrol = input;
                            },
                            sValue: P4ORDERHISTORYVAR.SEARCH,
                            returnfunc: (String s) {
                              setState(() {
                                P4ORDERHISTORYVAR.SEARCH = s;
                              });
                            },
                          ),
                          SizedBox(width: 5),
                          Container(
                            height: 40,
                            width: 170,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    /* initialDate: DateTime.now(), */
                                    firstDate: DateTime(2024),
                                    lastDate: DateTime(2200),
                                  );
                                  if (pickedDate != null) {
                                    P4ORDERHISTORYVAR.searchDateSTA =
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
                                            'START DATE',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        P4ORDERHISTORYVAR.searchDateSTA
                                            .toString(),
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
                          Container(
                            height: 40,
                            width: 170,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    /* initialDate: DateTime.now(), */
                                    firstDate: DateTime(2024),
                                    lastDate: DateTime(2200),
                                  );
                                  if (pickedDate != null) {
                                    P4ORDERHISTORYVAR.searchDateEND =
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
                                            'END DATE',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        P4ORDERHISTORYVAR.searchDateEND
                                            .toString(),
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
                                P4ORDERHISTORYVAR.DropDownPlant = d;
                              });
                            },
                            value: P4ORDERHISTORYVAR.DropDownPlant,
                            height: 50,
                            width: 100,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                P4ORDERHISTORYVAR.isHoveredClear = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                P4ORDERHISTORYVAR.isHoveredClear = false;
                              });
                            },
                            child: InkWell(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              onTap: () {
                                setState(() {
                                  P4ORDERHISTORYVAR.isHoveredClear = false;
                                  P4ORDERHISTORYVAR.iscontrol = true;
                                  P4ORDERHISTORYVAR.SEARCH = '';
                                  P4ORDERHISTORYVAR.DropDownPlant = 'ALL';
                                  P4ORDERHISTORYVAR.searchDate = '';
                                  DateTime now = DateTime.now();
                                  P4ORDERHISTORYVAR.searchDateSTA =
                                      formatDate(now.toString());
                                  P4ORDERHISTORYVAR.searchDateEND =
                                      formatDate(now.toString());
                                  P4ORDERHISTORYVAR.OrderNo = '';
                                  context
                                      .read<P4ORDERHISTORYGETDATA_Bloc>()
                                      .add(P4ORDERHISTORYGETDATA_GET());
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: P4ORDERHISTORYVAR.isHoveredClear
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
                                              P4ORDERHISTORYVAR.isHoveredClear
                                                  ? 15
                                                  : 17,
                                          end: P4ORDERHISTORYVAR.isHoveredClear
                                              ? 17
                                              : 15,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        builder: (context, size, child) {
                                          return TweenAnimationBuilder<Color?>(
                                            tween: ColorTween(
                                              begin: P4ORDERHISTORYVAR
                                                      .isHoveredClear
                                                  ? Colors.redAccent.shade700
                                                  : Colors
                                                      .yellowAccent.shade700,
                                              end: P4ORDERHISTORYVAR
                                                      .isHoveredClear
                                                  ? Colors.yellowAccent.shade700
                                                  : Colors.redAccent.shade700,
                                            ),
                                            duration:
                                                Duration(milliseconds: 200),
                                            builder: (context, color, child) {
                                              return Text(
                                                'RESET',
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
                          SizedBox(width: 5),
                          SizedBox(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<P4ORDERHISTORYGETDATA_Bloc>()
                                        .add(P4ORDERHISTORYGETDATA_GET());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'SEARCH',
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
                        child: P4ORDERHISTORYVAR.DropCheck
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
                                                P4ORDERHISTORYVAR.isChecked1 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isChecked2 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isChecked3 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isChecked4 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isChecked5 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isChecked6 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isChecked7 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isChecked8 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isChecked9 =
                                                    !P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
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
                                                P4ORDERHISTORYVAR.isCheckedALL =
                                                    !P4ORDERHISTORYVAR
                                                        .isCheckedALL;

                                                P4ORDERHISTORYVAR.isChecked1 =
                                                    P4ORDERHISTORYVAR
                                                        .isCheckedALL;
                                                P4ORDERHISTORYVAR.isChecked2 =
                                                    P4ORDERHISTORYVAR
                                                        .isCheckedALL;
                                                P4ORDERHISTORYVAR.isChecked3 =
                                                    P4ORDERHISTORYVAR
                                                        .isCheckedALL;
                                                P4ORDERHISTORYVAR.isChecked4 =
                                                    P4ORDERHISTORYVAR
                                                        .isCheckedALL;
                                                P4ORDERHISTORYVAR.isChecked5 =
                                                    P4ORDERHISTORYVAR
                                                        .isCheckedALL;
                                                P4ORDERHISTORYVAR.isChecked6 =
                                                    P4ORDERHISTORYVAR
                                                        .isCheckedALL;
                                                P4ORDERHISTORYVAR.isChecked7 =
                                                    P4ORDERHISTORYVAR
                                                        .isCheckedALL;
                                                P4ORDERHISTORYVAR.isChecked8 =
                                                    P4ORDERHISTORYVAR
                                                        .isCheckedALL;
                                                P4ORDERHISTORYVAR.isChecked9 =
                                                    P4ORDERHISTORYVAR
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
                                                      value: P4ORDERHISTORYVAR
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
                                                          P4ORDERHISTORYVAR
                                                                  .isCheckedALL =
                                                              value ?? false;

                                                          P4ORDERHISTORYVAR
                                                                  .isChecked1 =
                                                              P4ORDERHISTORYVAR
                                                                  .isCheckedALL;
                                                          P4ORDERHISTORYVAR
                                                                  .isChecked2 =
                                                              P4ORDERHISTORYVAR
                                                                  .isCheckedALL;
                                                          P4ORDERHISTORYVAR
                                                                  .isChecked3 =
                                                              P4ORDERHISTORYVAR
                                                                  .isCheckedALL;
                                                          P4ORDERHISTORYVAR
                                                                  .isChecked4 =
                                                              P4ORDERHISTORYVAR
                                                                  .isCheckedALL;
                                                          P4ORDERHISTORYVAR
                                                                  .isChecked5 =
                                                              P4ORDERHISTORYVAR
                                                                  .isCheckedALL;
                                                          P4ORDERHISTORYVAR
                                                                  .isChecked6 =
                                                              P4ORDERHISTORYVAR
                                                                  .isCheckedALL;
                                                          P4ORDERHISTORYVAR
                                                                  .isChecked7 =
                                                              P4ORDERHISTORYVAR
                                                                  .isCheckedALL;
                                                          P4ORDERHISTORYVAR
                                                                  .isChecked8 =
                                                              P4ORDERHISTORYVAR
                                                                  .isCheckedALL;
                                                          P4ORDERHISTORYVAR
                                                                  .isChecked9 =
                                                              P4ORDERHISTORYVAR
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
                      7: FixedColumnWidth(115.0),
                      8: FixedColumnWidth(130.0),
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
                                    'Complete Date',
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
                                          'Order Detail',
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
                          7: FixedColumnWidth(115.0),
                          8: FixedColumnWidth(115),
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
                                    child:
                                        Text(formatDate(item.Order_Start_DT)),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(formatDate(item.Complete_Time)),
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
                                child: Row(
                                  mainAxisAlignment : MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        List<dynamic> data =
                                            await SearchDataOrderHistory(
                                                item.OrderNo);
                                        if (data.isNotEmpty) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.8,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    child: P04ORDERDETAILMAIN(
                                                        data: data),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          showErrorPopup(
                                              P4ORDERHISTORYMAINcontext,
                                              'DATA NOT FOUND');
                                        }
                                      },
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                    ),
                                    if (USERDATA.UserLV > 5)
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          List<dynamic> data =
                                              await SearchDataOrderEdit(
                                                  item.OrderNo);
                                          if (data.isNotEmpty) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.8,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      child: P04ORDEREDITMAIN(
                                                          data: data),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            showErrorPopup(
                                                P4ORDERHISTORYMAINcontext,
                                                'DATA NOT FOUND');
                                          }
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.yellowAccent,
                                          size: 20,
                                        ),
                                      ),
                                  ],
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
