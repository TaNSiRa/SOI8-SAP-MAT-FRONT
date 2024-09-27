// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/06-01-P06TABLEREPORTOVERDUEGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputTextTan.dart';
import 'P06TABLEREPORTOVERDUEVAR.dart';

late BuildContext P05TABLEREPORTOVERDUEMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P05TABLEREPORTOVERDUEMAIN extends StatefulWidget {
  P05TABLEREPORTOVERDUEMAIN({
    super.key,
    this.data,
  });
  List<P05TABLEREPORTOVERDUEGETDATAclass>? data;

  @override
  State<P05TABLEREPORTOVERDUEMAIN> createState() =>
      _P05TABLEREPORTOVERDUEMAINState();
}

class _P05TABLEREPORTOVERDUEMAINState extends State<P05TABLEREPORTOVERDUEMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P05TABLEREPORTOVERDUEGETDATA_Bloc>()
        .add(P05TABLEREPORTOVERDUEGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P05TABLEREPORTOVERDUEMAINcontext = context;
    List<P05TABLEREPORTOVERDUEGETDATAclass> _datain = widget.data ?? [];

// ตัวแปรสําหรับใช้กับ Dropdown
    final selectedGroup = (P05TABLEREPORTOVERDUEVAR.DropDownGroup.isNotEmpty)
        ? P05TABLEREPORTOVERDUEVAR.DropDownGroup
        : '1';
    final selectedYear = (P05TABLEREPORTOVERDUEVAR.DropDownYear.isNotEmpty)
        ? P05TABLEREPORTOVERDUEVAR.DropDownYear
        : P05TABLEREPORTOVERDUEVAR.currentYear;
    final selectedMonth = (P05TABLEREPORTOVERDUEVAR.DropDownMonth.isNotEmpty)
        ? P05TABLEREPORTOVERDUEVAR.DropDownMonth
        : P05TABLEREPORTOVERDUEVAR.currentMonth;

// กรองข้อมูลด้วยปีและเดือน
    List<P05TABLEREPORTOVERDUEGETDATAclass> filteredData =
        _datain.where((data) {
      return data.MKTGROUP == selectedGroup &&
          data.YEAR == selectedYear &&
          data.MONTH == selectedMonth;
    }).toList();

// กรองข้อมูลในตารางด้วยการค้นหา
    List<P05TABLEREPORTOVERDUEGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      filteredData.where(
        (data) =>
            data.TYPE.toLowerCase().contains(P05TABLEREPORTOVERDUEVAR.SEARCH) ||
            data.GROUP
                .toLowerCase()
                .contains(P05TABLEREPORTOVERDUEVAR.SEARCH) ||
            data.CUSTOMER
                .toLowerCase()
                .contains(P05TABLEREPORTOVERDUEVAR.SEARCH) ||
            data.INCHARGE
                .toLowerCase()
                .contains(P05TABLEREPORTOVERDUEVAR.SEARCH),
      ),
    );

// เรียงชุดข้อมูลตาม TYPE,GROUP,CUSTOMER
    _datasearch.sort((a, b) {
      int typeComparison = a.TYPE.compareTo(b.TYPE);
      if (typeComparison != 0) {
        return typeComparison;
      }

      int groupComparison = a.GROUP.compareTo(b.GROUP);
      if (groupComparison != 0) {
        return groupComparison;
      }

      return a.CUSTOMER.compareTo(b.CUSTOMER);
    });

//แยกข้อมูล week 1-4
    List<Map<String, String>> newData = [];
    for (var data in _datasearch) {
      if (data.REPDAYS1.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS1)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ1,
          'plan sam': data.PLANSAM1,
          'act sam': data.ACTSAM1,
          'rep due': data.REPDUE1,
          'sent rep': data.SENTREP1,
          'rep days': data.REPDAYS1,
          'request': data.REQUEST1,
          'ttcresult': data.TTCRESULT1,
          'issuedate': data.ISSUEDATE1,
          'revise': data.REVISE1,
          'sublead': data.SUBLEAD1,
          'gl': data.GL1,
          'mgr': data.MGR1,
          'jp': data.JP1,
          'bdprepare': data.BDPREPARE1,
          'bdttc': data.BDTTC1,
          'bdissue': data.BDISSUE1,
          'bdrevise': data.BDREVISE1,
          'bdsublead': data.BDSUBLEAD1,
          'bdgl': data.BDGL1,
          'bdmgr': data.BDMGR1,
          'bdjp': data.BDJP1,
          'bdsent': data.BDSENT1,
          'reason': data.REASON1,
          'action': data.ACTION1,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS2.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS2)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ2,
          'plan sam': data.PLANSAM2,
          'act sam': data.ACTSAM2,
          'rep due': data.REPDUE2,
          'sent rep': data.SENTREP2,
          'rep days': data.REPDAYS2,
          'request': data.REQUEST2,
          'ttcresult': data.TTCRESULT2,
          'issuedate': data.ISSUEDATE2,
          'revise': data.REVISE2,
          'sublead': data.SUBLEAD2,
          'gl': data.GL2,
          'mgr': data.MGR2,
          'jp': data.JP2,
          'bdprepare': data.BDPREPARE2,
          'bdttc': data.BDTTC2,
          'bdissue': data.BDISSUE2,
          'bdrevise': data.BDREVISE2,
          'bdsublead': data.BDSUBLEAD2,
          'bdgl': data.BDGL2,
          'bdmgr': data.BDMGR2,
          'bdjp': data.BDJP2,
          'bdsent': data.BDSENT2,
          'reason': data.REASON2,
          'action': data.ACTION2,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS3.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS3)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ3,
          'plan sam': data.PLANSAM3,
          'act sam': data.ACTSAM3,
          'rep due': data.REPDUE3,
          'sent rep': data.SENTREP3,
          'rep days': data.REPDAYS3,
          'request': data.REQUEST3,
          'ttcresult': data.TTCRESULT3,
          'issuedate': data.ISSUEDATE3,
          'revise': data.REVISE3,
          'sublead': data.SUBLEAD3,
          'gl': data.GL3,
          'mgr': data.MGR3,
          'jp': data.JP3,
          'bdprepare': data.BDPREPARE3,
          'bdttc': data.BDTTC3,
          'bdissue': data.BDISSUE3,
          'bdrevise': data.BDREVISE3,
          'bdsublead': data.BDSUBLEAD3,
          'bdgl': data.BDGL3,
          'bdmgr': data.BDMGR3,
          'bdjp': data.BDJP3,
          'bdsent': data.BDSENT3,
          'reason': data.REASON3,
          'action': data.ACTION3,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS4.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS4)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ4,
          'plan sam': data.PLANSAM4,
          'act sam': data.ACTSAM4,
          'rep due': data.REPDUE4,
          'sent rep': data.SENTREP4,
          'rep days': data.REPDAYS4,
          'request': data.REQUEST4,
          'ttcresult': data.TTCRESULT4,
          'issuedate': data.ISSUEDATE4,
          'revise': data.REVISE4,
          'sublead': data.SUBLEAD4,
          'gl': data.GL4,
          'mgr': data.MGR4,
          'jp': data.JP4,
          'bdprepare': data.BDPREPARE4,
          'bdttc': data.BDTTC4,
          'bdissue': data.BDISSUE4,
          'bdrevise': data.BDREVISE4,
          'bdsublead': data.BDSUBLEAD4,
          'bdgl': data.BDGL4,
          'bdmgr': data.BDMGR4,
          'bdjp': data.BDJP4,
          'bdsent': data.BDSENT4,
          'reason': data.REASON4,
          'action': data.ACTION4,
        };
        newData.add(transformedData1);
      }
    }

// นับจำนวนข้อมูล
    int groupADataCount =
        newData.where((item) => item['type'] == 'Group A').length;
    int groupBDataCount =
        newData.where((item) => item['type'] == 'Group B').length;

    return Scrollbar(
      controller: _controllerIN01,
      thumbVisibility: true,
      interactive: true,
      thickness: 10,
      radius: Radius.circular(20),
      child: SingleChildScrollView(
        controller: _controllerIN01,
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: const [Colors.blueAccent, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'SAR : Report over due Group $selectedGroup ($selectedMonth $selectedYear)',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ComInputTextTan(
                    sPlaceholder: "Search... (Type, Group, Customer ,Incharge)",
                    isSideIcon: false,
                    height: 30,
                    width: 400,
                    isContr: P05TABLEREPORTOVERDUEVAR.iscontrol,
                    fnContr: (input) {
                      P05TABLEREPORTOVERDUEVAR.iscontrol = input;
                    },
                    sValue: P05TABLEREPORTOVERDUEVAR.SEARCH,
                    returnfunc: (String s) {
                      setState(() {
                        P05TABLEREPORTOVERDUEVAR.SEARCH = s;
                      });
                    },
                  ),
                  MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        P05TABLEREPORTOVERDUEVAR.isHoveredClear = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        P05TABLEREPORTOVERDUEVAR.isHoveredClear = false;
                      });
                    },
                    child: InkWell(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      onTap: () {
                        setState(() {
                          P05TABLEREPORTOVERDUEVAR.isHoveredClear = false;
                          P05TABLEREPORTOVERDUEVAR.iscontrol = true;
                          P05TABLEREPORTOVERDUEVAR.SEARCH = '';
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: P05TABLEREPORTOVERDUEVAR.isHoveredClear
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
                              shaderCallback: (bounds) => LinearGradient(
                                colors: const [
                                  Colors.white,
                                  Colors.red,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: P05TABLEREPORTOVERDUEVAR.isHoveredClear
                                      ? 8
                                      : 8,
                                  end: P05TABLEREPORTOVERDUEVAR.isHoveredClear
                                      ? 8
                                      : 8,
                                ),
                                duration: Duration(milliseconds: 200),
                                builder: (context, size, child) {
                                  return TweenAnimationBuilder<Color?>(
                                    tween: ColorTween(
                                      begin: P05TABLEREPORTOVERDUEVAR
                                              .isHoveredClear
                                          ? Colors.redAccent.shade700
                                          : Colors.yellowAccent.shade700,
                                      end: P05TABLEREPORTOVERDUEVAR
                                              .isHoveredClear
                                          ? Colors.yellowAccent.shade700
                                          : Colors.redAccent.shade700,
                                    ),
                                    duration: Duration(milliseconds: 200),
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
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<P05TABLEREPORTOVERDUEGETDATA_Bloc>()
                          .add(P05TABLEREPORTOVERDUEGETDATA_GET());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                  Column(
                    children: [
                      if (P05TABLEREPORTOVERDUEVAR.DropDownGroup.isNotEmpty ||
                          P05TABLEREPORTOVERDUEVAR.DropDownYear.isNotEmpty ||
                          P05TABLEREPORTOVERDUEVAR.DropDownMonth.isNotEmpty)
                        SizedBox(
                          width: 100,
                          child: Text(
                            'GROUP',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      AdvanceDropDown(
                        hint: "GROUP",
                        listdropdown: const [
                          MapEntry("GROUP", ""),
                          MapEntry("1", "1"),
                          MapEntry("2", "2"),
                          MapEntry("5", "5"),
                          MapEntry("6", "6"),
                        ],
                        onChangeinside: (d, k) {
                          setState(() {
                            P05TABLEREPORTOVERDUEVAR.DropDownGroup = d;
                          });
                        },
                        value: P05TABLEREPORTOVERDUEVAR.DropDownGroup,
                        height: 30,
                        width: 100,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      if (P05TABLEREPORTOVERDUEVAR.DropDownGroup.isNotEmpty ||
                          P05TABLEREPORTOVERDUEVAR.DropDownYear.isNotEmpty ||
                          P05TABLEREPORTOVERDUEVAR.DropDownMonth.isNotEmpty)
                        SizedBox(
                          width: 100,
                          child: Text(
                            'YEAR',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      AdvanceDropDown(
                        hint: "YEAR",
                        listdropdown: const [
                          MapEntry("YEAR", ""),
                          MapEntry("2024", "2024"),
                          MapEntry("2025", "2025"),
                          MapEntry("2026", "2026"),
                          MapEntry("2027", "2027"),
                          MapEntry("2028", "2028"),
                          MapEntry("2029", "2029"),
                          MapEntry("2030", "2030"),
                          MapEntry("2031", "2031"),
                          MapEntry("2032", "2032"),
                          MapEntry("2033", "2033"),
                          MapEntry("2034", "2034"),
                          MapEntry("2035", "2035"),
                          MapEntry("2036", "2036"),
                          MapEntry("2037", "2037"),
                          MapEntry("2038", "2038"),
                          MapEntry("2039", "2039"),
                          MapEntry("2040", "2040"),
                        ],
                        onChangeinside: (d, k) {
                          setState(() {
                            P05TABLEREPORTOVERDUEVAR.DropDownYear = d;
                          });
                        },
                        value: P05TABLEREPORTOVERDUEVAR.DropDownYear,
                        height: 30,
                        width: 100,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      if (P05TABLEREPORTOVERDUEVAR.DropDownGroup.isNotEmpty ||
                          P05TABLEREPORTOVERDUEVAR.DropDownYear.isNotEmpty ||
                          P05TABLEREPORTOVERDUEVAR.DropDownMonth.isNotEmpty)
                        SizedBox(
                          width: 100,
                          child: Text(
                            'MONTH',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      AdvanceDropDown(
                        hint: "MONTH",
                        listdropdown: const [
                          MapEntry("MONTH", ""),
                          MapEntry("Jan", "Jan"),
                          MapEntry("Feb", "Feb"),
                          MapEntry("Mar", "Mar"),
                          MapEntry("Apr", "Apr"),
                          MapEntry("May", "May"),
                          MapEntry("Jun", "Jun"),
                          MapEntry("Jul", "Jul"),
                          MapEntry("Aug", "Aug"),
                          MapEntry("Sep", "Sep"),
                          MapEntry("Oct", "Oct"),
                          MapEntry("Nov", "Nov"),
                          MapEntry("Dec", "Dec"),
                        ],
                        onChangeinside: (d, k) {
                          setState(() {
                            P05TABLEREPORTOVERDUEVAR.DropDownMonth = d;
                          });
                        },
                        value: P05TABLEREPORTOVERDUEVAR.DropDownMonth,
                        height: 30,
                        width: 100,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FixedColumnWidth(25),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 80,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    'NO.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...newData.map((item) {
                        int dataCount = newData.indexOf(item) + 1;
                        return TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                height: 20,
                                child: Center(
                                  child: Text(
                                    dataCount.toString(),
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  Column(
                    children: [
                      Table(
                        border: TableBorder(
                          top: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        columnWidths: const {
                          0: FixedColumnWidth(100),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 80,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Type',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (groupADataCount > 0)
                        Container(
                          height: max(groupADataCount * 20, 0.5) - 0.5,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Group A: Long\nsample preparation\ntime',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      if (groupBDataCount > 0)
                        Container(
                          height: groupBDataCount * 20 + 0.5,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Group B: Other\n(Not long sample\npreparation time)',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FixedColumnWidth(50),
                      1: FixedColumnWidth(100),
                      2: FixedColumnWidth(50),
                      3: FixedColumnWidth(70),
                      4: FixedColumnWidth(70),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 80,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    'Group',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 80,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    'Customer and line',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...newData.map((item) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                height: 20,
                                child: Center(
                                    child: Text(
                                  item['group'] ?? '',
                                  style: TextStyle(fontSize: 10),
                                )),
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                height: 20,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    ' ${item['customer'] ?? ''}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  Column(
                    children: [
                      Table(
                        border: TableBorder(
                          top: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        columnWidths: const {
                          0: FixedColumnWidth(60),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 80,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'KPI\nreport\nperiod\n(Days)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (groupADataCount > 0)
                        Container(
                          height: max(groupADataCount * 20, 0.5) - 0.5,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Within 12 WD\n100%',
                              style: TextStyle(fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      if (groupBDataCount > 0)
                        Container(
                          height: groupBDataCount * 20 + 0.5,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Within 10 WD\n100%',
                              style: TextStyle(fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      0: FixedColumnWidth(70),
                      1: FixedColumnWidth(70),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 80,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    'Frequency\n(Time/Month)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 80,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    'Incharge',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...newData.map((item) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                height: 20,
                                child: Center(
                                  child: Text(
                                    item['frequency'] ?? '',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                height: 20,
                                child: Center(
                                  child: Text(
                                    item['incharge'] ?? '',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 550,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Operation (Date-Month-Year)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Table(
                            border: TableBorder(
                              horizontalInside: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              verticalInside: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            columnWidths: const {
                              0: FixedColumnWidth(50),
                              1: FixedColumnWidth(50),
                              2: FixedColumnWidth(50),
                              3: FixedColumnWidth(50),
                              4: FixedColumnWidth(50),
                              5: FixedColumnWidth(50),
                              6: FixedColumnWidth(50),
                              7: FixedColumnWidth(50),
                              8: FixedColumnWidth(50),
                              9: FixedColumnWidth(50),
                              10: FixedColumnWidth(50),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Sampling',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Request\nsample',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'TTC\nresult',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Due date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Issue date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Revise\nreport',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Sub lead\nsign',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'GL. sign',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Mgr.\nsign',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'JP. sign',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Send to\ncustomer',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ...newData.map((item) {
                                return TableRow(
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                            child: Text(
                                          item['act sam'] ?? '',
                                          style: TextStyle(fontSize: 10),
                                        )),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['request'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['ttcresult'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['rep due'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                            child: Text(
                                          item['issuedate'] ?? '',
                                          style: TextStyle(fontSize: 10),
                                        )),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['revise'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['sublead'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['gl'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                            child: Text(
                                          item['mgr'] ?? '',
                                          style: TextStyle(fontSize: 10),
                                        )),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['jp'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['sent rep'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 550,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Break down working Day (Day)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Table(
                            border: TableBorder(
                              horizontalInside: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              verticalInside: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            columnWidths: const {
                              0: FixedColumnWidth(50),
                              1: FixedColumnWidth(50),
                              2: FixedColumnWidth(50),
                              3: FixedColumnWidth(50),
                              4: FixedColumnWidth(50),
                              5: FixedColumnWidth(50),
                              6: FixedColumnWidth(50),
                              7: FixedColumnWidth(50),
                              8: FixedColumnWidth(50),
                              9: FixedColumnWidth(50),
                              10: FixedColumnWidth(50),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Prepare\n+Request\nsample',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'TTC\nanalysis',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Issue\nreport\nafter\nTTC\nanalysis',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Revise\nreport',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Sub lead\nsign',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'GL\nsign',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Mgr\nsign',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Jp. sign',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Sent to\ncustomer',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Total Day\n(amount)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Over due\n(Days)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ...newData.map((item) {
                                final int bdprepare = int.tryParse(
                                        item['bdprepare']?.toString() ?? '0') ??
                                    0;
                                final int bdttc = int.tryParse(
                                        item['bdttc']?.toString() ?? '0') ??
                                    0;
                                final int bdissue = int.tryParse(
                                        item['bdissue']?.toString() ?? '0') ??
                                    0;
                                final int bdrevise = int.tryParse(
                                        item['bdrevise']?.toString() ?? '0') ??
                                    0;
                                final int bdsublead = int.tryParse(
                                        item['bdsublead']?.toString() ?? '0') ??
                                    0;
                                final int bdgl = int.tryParse(
                                        item['bdgl']?.toString() ?? '0') ??
                                    0;
                                final int bdmgr = int.tryParse(
                                        item['bdmgr']?.toString() ?? '0') ??
                                    0;
                                final int bdjp = int.tryParse(
                                        item['bdjp']?.toString() ?? '0') ??
                                    0;
                                final int bdsent = int.tryParse(
                                        item['bdsent']?.toString() ?? '0') ??
                                    0;
                                final int kpiperiod = int.tryParse(
                                        item['kpi period']?.toString() ??
                                            '0') ??
                                    0;
                                final int SumTotalDay = bdprepare +
                                    bdttc +
                                    bdissue +
                                    bdrevise +
                                    bdsublead +
                                    bdgl +
                                    bdmgr +
                                    bdjp +
                                    bdsent;
                                return TableRow(
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                            child: Text(
                                          item['bdprepare'] ?? '',
                                          style: TextStyle(fontSize: 10),
                                        )),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['bdttc'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['bdissue'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['bdrevise'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                            child: Text(
                                          item['bdsublead'] ?? '',
                                          style: TextStyle(fontSize: 10),
                                        )),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['bdgl'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['bdmgr'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item['bdjp'] ?? '',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                            child: Text(
                                          item['bdsent'] ?? '',
                                          style: TextStyle(fontSize: 10),
                                        )),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            SumTotalDay.toString(),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            '${SumTotalDay - kpiperiod}',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      verticalInside: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    columnWidths: const {
                      0: FixedColumnWidth(250),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 80,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    'Reason',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...newData.map((item) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                height: 20,
                                child: Center(
                                  child: Text(
                                    item['reason'] ?? '',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      verticalInside: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    columnWidths: const {
                      0: FixedColumnWidth(250),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 80,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    'Action',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...newData.map((item) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                height: 20,
                                child: Center(
                                  child: Text(
                                    item['action'] ?? '',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 460,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Break down working Day (Day)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Table(
                            border: TableBorder(
                              horizontalInside: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              verticalInside: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              top: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            columnWidths: const {
                              0: FixedColumnWidth(50),
                              1: FixedColumnWidth(50),
                              2: FixedColumnWidth(50),
                              3: FixedColumnWidth(70),
                              4: FixedColumnWidth(50),
                              5: FixedColumnWidth(50),
                              6: FixedColumnWidth(90),
                              7: FixedColumnWidth(50),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Follow up\nOther\nProject',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'TTC Result\nLate',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Revise\nReport',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Approved\nfrom Leader\n,JP and MGR',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Re-check\nResult from\nTTC',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Prepare\nSample long\ntime',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Forgot Request Sample,Make Report,Send report',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'Other\n(Covid)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // ..._datain.map((item) {
                              //   return TableRow(
                              //     children: [
                              //       TableCell(
                              //         child: SizedBox(
                              //           height: 20,
                              //           child: Center(
                              //               child: Text(
                              //             item.GROUP,
                              //             style: TextStyle(fontSize: 10),
                              //           )),
                              //         ),
                              //       ),
                              //       TableCell(
                              //         child: SizedBox(
                              //           height: 20,
                              //           child: Align(
                              //             alignment: Alignment.centerLeft,
                              //             child: Text(
                              //               ' ${item.CUSTOMER}',
                              //               style: TextStyle(fontSize: 10),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       TableCell(
                              //         child: SizedBox(
                              //           height: 20,
                              //           child: Center(
                              //             child: Text(
                              //               item.FREQUENCY,
                              //               style: TextStyle(fontSize: 10),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       TableCell(
                              //         child: SizedBox(
                              //           height: 20,
                              //           child: Center(
                              //             child: Text(
                              //               item.INCHARGE,
                              //               style: TextStyle(fontSize: 10),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   );
                              // }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
