// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/05-01-P05TABLESERVICEGETDATA.dart';
import 'dart:math';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputTextTan.dart';
import 'P05TABLESERVICEVAR.dart';

late BuildContext P05TABLESERVICEMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P05TABLESERVICEMAIN extends StatefulWidget {
  P05TABLESERVICEMAIN({
    super.key,
    this.data,
  });
  List<P05TABLESERVICEGETDATAclass>? data;

  @override
  State<P05TABLESERVICEMAIN> createState() => _P05TABLESERVICEMAINState();
}

class _P05TABLESERVICEMAINState extends State<P05TABLESERVICEMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P05TABLESERVICEGETDATA_Bloc>()
        .add(P05TABLESERVICEGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P05TABLESERVICEMAINcontext = context;
    List<P05TABLESERVICEGETDATAclass> _datain = widget.data ?? [];

// ตัวแปรสําหรับใช้กับ Dropdown
    final selectedGroup = (P05TABLESERVICEVAR.DropDownGroup.isNotEmpty)
        ? P05TABLESERVICEVAR.DropDownGroup
        : '1';
    final selectedYear = (P05TABLESERVICEVAR.DropDownYear.isNotEmpty)
        ? P05TABLESERVICEVAR.DropDownYear
        : P05TABLESERVICEVAR.currentYear;
    final selectedMonth = (P05TABLESERVICEVAR.DropDownMonth.isNotEmpty)
        ? P05TABLESERVICEVAR.DropDownMonth
        : P05TABLESERVICEVAR.currentMonth;

// กรองข้อมูลด้วยปีและเดือน
    List<P05TABLESERVICEGETDATAclass> filteredData = _datain.where((data) {
      return data.MKTGROUP == selectedGroup &&
          data.YEAR == selectedYear &&
          data.MONTH == selectedMonth;
    }).toList();

// กรองข้อมูลในตารางด้วยการค้นหา
    List<P05TABLESERVICEGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      filteredData.where(
        (data) =>
            data.TYPE.toLowerCase().contains(P05TABLESERVICEVAR.SEARCH) ||
            data.GROUP.toLowerCase().contains(P05TABLESERVICEVAR.SEARCH) ||
            data.CUSTOMER.toLowerCase().contains(P05TABLESERVICEVAR.SEARCH) ||
            data.INCHARGE.toLowerCase().contains(P05TABLESERVICEVAR.SEARCH),
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

//แปลงข้อมูลจาก List<P05TABLESERVICEGETDATAclass> เป็น List<Map<String, dynamic>>
    List<Map<String, dynamic>> convertData(
        List<P05TABLESERVICEGETDATAclass> data) {
      return data.map((item) {
        return {
          'type': item.TYPE,
          'mktgroup': item.MKTGROUP,
          'group': item.GROUP,
          'customer': item.CUSTOMER,
          'frequency': item.FREQUENCY,
          'incharge': item.INCHARGE,
          'kpi serv': item.KPISERV,
          'kpi period': item.KPIPERIOD,
          'repitems': item.REPITEM,
          'month': item.MONTH,
          'year': item.YEAR,
          'freq1': item.FREQ1,
          'plan sam1': item.PLANSAM1,
          'act sam1': item.ACTSAM1,
          'rep due1': item.REPDUE1,
          'sent rep1': item.SENTREP1,
          'rep days1': item.REPDAYS1,
          'freq2': item.FREQ2,
          'plan sam2': item.PLANSAM2,
          'act sam2': item.ACTSAM2,
          'rep due2': item.REPDUE2,
          'sent rep2': item.SENTREP2,
          'rep days2': item.REPDAYS2,
          'freq3': item.FREQ3,
          'plan sam3': item.PLANSAM3,
          'act sam3': item.ACTSAM3,
          'rep due3': item.REPDUE3,
          'sent rep3': item.SENTREP3,
          'rep days3': item.REPDAYS3,
          'freq4': item.FREQ4,
          'plan sam4': item.PLANSAM4,
          'act sam4': item.ACTSAM4,
          'rep due4': item.REPDUE4,
          'sent rep4': item.SENTREP4,
          'rep days4': item.REPDAYS4,
        };
      }).toList();
    }

    List<Map<String, dynamic>> transformedData = convertData(_datasearch);

// นับจำนวนข้อมูล
    int groupADataCount =
        transformedData.where((item) => item['type'] == 'Group A').length;
    int groupBDataCount =
        transformedData.where((item) => item['type'] == 'Group B').length;
    int GroupAKACDataCount = transformedData
        .where((item) => item['type'] == 'Group A' && item['group'] == 'KAC')
        .length;
    int GroupAMEDIUMDataCount = transformedData
        .where((item) => item['type'] == 'Group A' && item['group'] == 'MEDIUM')
        .length;
    int GroupBKACDataCount = transformedData
        .where((item) => item['type'] == 'Group B' && item['group'] == 'KAC')
        .length;
    int GroupBMEDIUMDataCount = transformedData
        .where((item) => item['type'] == 'Group B' && item['group'] == 'MEDIUM')
        .length;

// สำหรับ Merge เปอร์เซ็นของคอลัมน์ KPI serv.
    int adjustedGroupADataCount = GroupAMEDIUMDataCount == 0
        ? GroupAKACDataCount + GroupBKACDataCount
        : GroupAKACDataCount;
    int adjustedGroupBDataCount = GroupBKACDataCount == 0
        ? GroupBMEDIUMDataCount + GroupAMEDIUMDataCount
        : GroupBMEDIUMDataCount;

// Group A Total report (issue) weekly
    int groupASumFreq1 = transformedData
        .where((item) => item['type'] == 'Group A')
        .map((item) => int.tryParse(item['freq1'] ?? '0') ?? 0)
        .fold(0, (sum, freq) => sum + freq);

    int groupASumFreq2 = transformedData
        .where((item) => item['type'] == 'Group A')
        .map((item) => int.tryParse(item['freq2'] ?? '0') ?? 0)
        .fold(0, (sum, freq) => sum + freq);

    int groupASumFreq3 = transformedData
        .where((item) => item['type'] == 'Group A')
        .map((item) => int.tryParse(item['freq3'] ?? '0') ?? 0)
        .fold(0, (sum, freq) => sum + freq);

    int groupASumFreq4 = transformedData
        .where((item) => item['type'] == 'Group A')
        .map((item) => int.tryParse(item['freq4'] ?? '0') ?? 0)
        .fold(0, (sum, freq) => sum + freq);

// Group A Total Report more than 12 WD (issue) weekly
    int groupACountRepDays1 = transformedData.where((item) {
      var repDays1 = item['rep days1'];
      return item['type'] == 'Group A' &&
          repDays1 != null &&
          int.tryParse(repDays1) != null &&
          int.parse(repDays1) > 12;
    }).length;
    int groupACountRepDays2 = transformedData.where((item) {
      var repDays2 = item['rep days2'];
      return item['type'] == 'Group A' &&
          repDays2 != null &&
          int.tryParse(repDays2) != null &&
          int.parse(repDays2) > 12;
    }).length;
    int groupACountRepDays3 = transformedData.where((item) {
      var repDays3 = item['rep days3'];
      return item['type'] == 'Group A' &&
          repDays3 != null &&
          int.tryParse(repDays3) != null &&
          int.parse(repDays3) > 12;
    }).length;
    int groupACountRepDays4 = transformedData.where((item) {
      var repDays4 = item['rep days4'];
      return item['type'] == 'Group A' &&
          repDays4 != null &&
          int.tryParse(repDays4) != null &&
          int.parse(repDays4) > 12;
    }).length;

// Group A %KPI achievement (Target 100%) weekly
    double groupAKPIAchievement1 =
        (groupASumFreq1 - groupACountRepDays1) / groupASumFreq1 * 100;
    double groupAKPIAchievement2 =
        (groupASumFreq2 - groupACountRepDays2) / groupASumFreq2 * 100;
    double groupAKPIAchievement3 =
        (groupASumFreq3 - groupACountRepDays3) / groupASumFreq3 * 100;
    double groupAKPIAchievement4 =
        (groupASumFreq4 - groupACountRepDays4) / groupASumFreq4 * 100;

// Group A Total report (issue) monthly
    int groupASumAllFreq =
        groupASumFreq1 + groupASumFreq2 + groupASumFreq3 + groupASumFreq4;

// Group A Total Report more than 12 WD (issue) monthly
    int groupASumAllRepDays = groupACountRepDays1 +
        groupACountRepDays2 +
        groupACountRepDays3 +
        groupACountRepDays4;

// Group A %KPI achievement (Target 100%) monthly
    double groupAKPISumAchievement =
        (groupASumAllFreq - groupASumAllRepDays) / groupASumAllFreq * 100;

// Group B Total report (issue) weekly
    int groupBSumFreq1 = transformedData
        .where((item) => item['type'] == 'Group B')
        .map((item) => int.tryParse(item['freq1'] ?? '0') ?? 0)
        .fold(0, (sum, freq) => sum + freq);

    int groupBSumFreq2 = transformedData
        .where((item) => item['type'] == 'Group B')
        .map((item) => int.tryParse(item['freq2'] ?? '0') ?? 0)
        .fold(0, (sum, freq) => sum + freq);

    int groupBSumFreq3 = transformedData
        .where((item) => item['type'] == 'Group B')
        .map((item) => int.tryParse(item['freq3'] ?? '0') ?? 0)
        .fold(0, (sum, freq) => sum + freq);

    int groupBSumFreq4 = transformedData
        .where((item) => item['type'] == 'Group B')
        .map((item) => int.tryParse(item['freq4'] ?? '0') ?? 0)
        .fold(0, (sum, freq) => sum + freq);

// Group B Total Report more than 12 WD (issue) weekly
    int groupBCountRepDays1 = transformedData.where((item) {
      var repDays1 = item['rep days1'];
      return item['type'] == 'Group B' &&
          repDays1 != null &&
          int.tryParse(repDays1) != null &&
          int.parse(repDays1) > 10;
    }).length;
    int groupBCountRepDays2 = transformedData.where((item) {
      var repDays2 = item['rep days2'];
      return item['type'] == 'Group B' &&
          repDays2 != null &&
          int.tryParse(repDays2) != null &&
          int.parse(repDays2) > 10;
    }).length;
    int groupBCountRepDays3 = transformedData.where((item) {
      var repDays3 = item['rep days3'];
      return item['type'] == 'Group B' &&
          repDays3 != null &&
          int.tryParse(repDays3) != null &&
          int.parse(repDays3) > 10;
    }).length;
    int groupBCountRepDays4 = transformedData.where((item) {
      var repDays4 = item['rep days4'];
      return item['type'] == 'Group B' &&
          repDays4 != null &&
          int.tryParse(repDays4) != null &&
          int.parse(repDays4) > 10;
    }).length;

// Group B %KPI achievement (Target 100%) weekly
    double groupBKPIAchievement1 =
        (groupBSumFreq1 - groupBCountRepDays1) / groupBSumFreq1 * 100;
    double groupBKPIAchievement2 =
        (groupBSumFreq2 - groupBCountRepDays2) / groupBSumFreq2 * 100;
    double groupBKPIAchievement3 =
        (groupBSumFreq3 - groupBCountRepDays3) / groupBSumFreq3 * 100;
    double groupBKPIAchievement4 =
        (groupBSumFreq4 - groupBCountRepDays4) / groupBSumFreq4 * 100;

// Group B Total report (issue) monthly
    int groupBSumAllFreq =
        groupBSumFreq1 + groupBSumFreq2 + groupBSumFreq3 + groupBSumFreq4;

// Group B Total Report more than 12 WD (issue) monthly
    int groupBSumAllRepDays = groupBCountRepDays1 +
        groupBCountRepDays2 +
        groupBCountRepDays3 +
        groupBCountRepDays4;

// Group B %KPI achievement (Target 100%) monthly
    double groupBKPISumAchievement =
        (groupBSumAllFreq - groupBSumAllRepDays) / groupBSumAllFreq * 100;

// KAC Sum visit plan monthly
    int KACVisitPlanSum = transformedData
        .where((item) => item['group'] == 'KAC')
        .map((item) =>
            (int.tryParse(item['freq1'] ?? '0') ?? 0) +
            (int.tryParse(item['freq2'] ?? '0') ?? 0) +
            (int.tryParse(item['freq3'] ?? '0') ?? 0) +
            (int.tryParse(item['freq4'] ?? '0') ?? 0))
        .fold(0, (sum, freq) => sum + freq);

// KAC Sum visit actual monthly
    int KACVisitActualCount =
        transformedData.where((item) => item['group'] == 'KAC').map((item) {
      int count = 0;
      if (item['act sam1']?.isNotEmpty ?? false) count++;
      if (item['act sam2']?.isNotEmpty ?? false) count++;
      if (item['act sam3']?.isNotEmpty ?? false) count++;
      if (item['act sam4']?.isNotEmpty ?? false) count++;
      return count;
    }).fold(0, (sum, count) => sum + count);

// %Visit KAC
    double KACVisitPercent = (KACVisitActualCount / KACVisitPlanSum) * 100;

// MEDIUM Sum visit plan monthly
    int MEDIUMVisitPlanSum = transformedData
        .where((item) => item['group'] == 'MEDIUM')
        .map((item) =>
            (int.tryParse(item['freq1'] ?? '0') ?? 0) +
            (int.tryParse(item['freq2'] ?? '0') ?? 0) +
            (int.tryParse(item['freq3'] ?? '0') ?? 0) +
            (int.tryParse(item['freq4'] ?? '0') ?? 0))
        .fold(0, (sum, freq) => sum + freq);

// MEDIUM Sum visit actual monthly
    int MEDIUMVisitActualCount =
        transformedData.where((item) => item['group'] == 'MEDIUM').map((item) {
      int count = 0;
      if (item['act sam1']?.isNotEmpty ?? false) count++;
      if (item['act sam2']?.isNotEmpty ?? false) count++;
      if (item['act sam3']?.isNotEmpty ?? false) count++;
      if (item['act sam4']?.isNotEmpty ?? false) count++;
      return count;
    }).fold(0, (sum, count) => sum + count);

// %Visit MEDIUM
    double MEDIUMVisitPercent =
        (MEDIUMVisitActualCount / MEDIUMVisitPlanSum) * 100;

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
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: const [
                            Colors.blueAccent,
                            Colors.lightBlueAccent
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'SAR : Technical Service Report of Group $selectedGroup ($selectedMonth $selectedYear)',
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
                        sPlaceholder:
                            "Search... (Type, Group, Customer ,Incharge)",
                        isSideIcon: false,
                        height: 30,
                        width: 400,
                        isContr: P05TABLESERVICEVAR.iscontrol,
                        fnContr: (input) {
                          P05TABLESERVICEVAR.iscontrol = input;
                        },
                        sValue: P05TABLESERVICEVAR.SEARCH,
                        returnfunc: (String s) {
                          setState(() {
                            P05TABLESERVICEVAR.SEARCH = s;
                          });
                        },
                      ),
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            P05TABLESERVICEVAR.isHoveredClear = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            P05TABLESERVICEVAR.isHoveredClear = false;
                          });
                        },
                        child: InkWell(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          onTap: () {
                            setState(() {
                              P05TABLESERVICEVAR.isHoveredClear = false;
                              P05TABLESERVICEVAR.iscontrol = true;
                              P05TABLESERVICEVAR.SEARCH = '';
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: P05TABLESERVICEVAR.isHoveredClear
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
                                      begin: P05TABLESERVICEVAR.isHoveredClear
                                          ? 8
                                          : 8,
                                      end: P05TABLESERVICEVAR.isHoveredClear
                                          ? 8
                                          : 8,
                                    ),
                                    duration: Duration(milliseconds: 200),
                                    builder: (context, size, child) {
                                      return TweenAnimationBuilder<Color?>(
                                        tween: ColorTween(
                                          begin: P05TABLESERVICEVAR
                                                  .isHoveredClear
                                              ? Colors.redAccent.shade700
                                              : Colors.yellowAccent.shade700,
                                          end: P05TABLESERVICEVAR.isHoveredClear
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
                              .read<P05TABLESERVICEGETDATA_Bloc>()
                              .add(P05TABLESERVICEGETDATA_GET());
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
                          if (P05TABLESERVICEVAR.DropDownGroup.isNotEmpty ||
                              P05TABLESERVICEVAR.DropDownYear.isNotEmpty ||
                              P05TABLESERVICEVAR.DropDownMonth.isNotEmpty)
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
                                P05TABLESERVICEVAR.DropDownGroup = d;
                              });
                            },
                            value: P05TABLESERVICEVAR.DropDownGroup,
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
                          if (P05TABLESERVICEVAR.DropDownGroup.isNotEmpty ||
                              P05TABLESERVICEVAR.DropDownYear.isNotEmpty ||
                              P05TABLESERVICEVAR.DropDownMonth.isNotEmpty)
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
                                P05TABLESERVICEVAR.DropDownYear = d;
                              });
                            },
                            value: P05TABLESERVICEVAR.DropDownYear,
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
                          if (P05TABLESERVICEVAR.DropDownGroup.isNotEmpty ||
                              P05TABLESERVICEVAR.DropDownYear.isNotEmpty ||
                              P05TABLESERVICEVAR.DropDownMonth.isNotEmpty)
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
                                P05TABLESERVICEVAR.DropDownMonth = d;
                              });
                            },
                            value: P05TABLESERVICEVAR.DropDownMonth,
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
                          ..._datasearch.map((item) {
                            int dataCount = _datasearch.indexOf(item) + 1;
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
                          2: FixedColumnWidth(70),
                          3: FixedColumnWidth(70),
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
                          ..._datasearch.map((item) {
                            return TableRow(
                              children: [
                                TableCell(
                                  child: SizedBox(
                                    height: 20,
                                    child: Center(
                                        child: Text(
                                      item.GROUP,
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
                                        ' ${item.CUSTOMER}',
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
                                        item.FREQUENCY,
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
                                        item.INCHARGE,
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
                              0: FixedColumnWidth(30),
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
                                            'KPI\nserv.',
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
                          Container(
                            height:
                                max(adjustedGroupADataCount * 20, 0.5) - 0.5,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '100%',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          if (GroupBKACDataCount > 0)
                            Container(
                              height: GroupAMEDIUMDataCount * 20 + 0.5,
                              width: 30,
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
                                  right: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '> 90%',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          if (GroupAMEDIUMDataCount > 0)
                            Container(
                              height: max(GroupBKACDataCount * 20, 0.5) - 0.5,
                              width: 30,
                              decoration: BoxDecoration(
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
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '100%',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          Container(
                            height: adjustedGroupBDataCount * 20 + 0.5,
                            width: 30,
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
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '> 90%',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
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
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          top: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        columnWidths: const {
                          0: FixedColumnWidth(30),
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
                                        'Rep.\nitems',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ..._datasearch.map((item) {
                            return TableRow(
                              children: [
                                TableCell(
                                  child: SizedBox(
                                    height: 20,
                                    child: Center(
                                      child: Text(
                                        item.REPITEM,
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
                              right: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              left: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            columnWidths: const {
                              0: FixedColumnWidth(1200),
                            },
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                      height: 15,
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            '$selectedMonth $selectedYear',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Table(
                                    border: TableBorder(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      left: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    columnWidths: const {
                                      0: FixedColumnWidth(300),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 15,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'W1',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Table(
                                    border: TableBorder.all(),
                                    columnWidths: const {
                                      0: FixedColumnWidth(50),
                                      1: FixedColumnWidth(50),
                                      2: FixedColumnWidth(50),
                                      3: FixedColumnWidth(50),
                                      4: FixedColumnWidth(50),
                                      5: FixedColumnWidth(50),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Freq.',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Plan\nSam\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Act\nSam\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Rep\nDue\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Sent\nRep\nDate',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Rep days',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ..._datasearch.map((item) {
                                        return TableRow(
                                          children: [
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.FREQ1,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.PLANSAM1,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.ACTSAM1,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.REPDUE1,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.SENTREP1,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.REPDAYS1,
                                                    style:
                                                        TextStyle(fontSize: 8),
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
                              Column(
                                children: [
                                  Table(
                                    border: TableBorder(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    columnWidths: const {
                                      0: FixedColumnWidth(300),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 15,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'W2',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Freq.',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Plan\nSam\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Act\nSam\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Rep\nDue\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Sent\nRep\nDate',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Rep days',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ..._datasearch.map((item) {
                                        return TableRow(
                                          children: [
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.FREQ2,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.PLANSAM2,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.ACTSAM2,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.REPDUE2,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.SENTREP2,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.REPDAYS2,
                                                    style:
                                                        TextStyle(fontSize: 8),
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
                              Column(
                                children: [
                                  Table(
                                    border: TableBorder(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    columnWidths: const {
                                      0: FixedColumnWidth(300),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 15,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'W3',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                        bottom: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        left: BorderSide(
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                    columnWidths: const {
                                      0: FixedColumnWidth(50),
                                      1: FixedColumnWidth(50),
                                      2: FixedColumnWidth(50),
                                      3: FixedColumnWidth(50),
                                      4: FixedColumnWidth(50),
                                      5: FixedColumnWidth(50),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Freq.',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Plan\nSam\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Act\nSam\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Rep\nDue\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Sent\nRep\nDate',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Rep days',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ..._datasearch.map((item) {
                                        return TableRow(
                                          children: [
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.FREQ3,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.PLANSAM3,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.ACTSAM3,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.REPDUE3,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.SENTREP3,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.REPDAYS3,
                                                    style:
                                                        TextStyle(fontSize: 8),
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
                              Column(
                                children: [
                                  Table(
                                    border: TableBorder(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    columnWidths: const {
                                      0: FixedColumnWidth(300),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 15,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'W4',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Table(
                                    border: TableBorder.all(),
                                    columnWidths: const {
                                      0: FixedColumnWidth(50),
                                      1: FixedColumnWidth(50),
                                      2: FixedColumnWidth(50),
                                      3: FixedColumnWidth(50),
                                      4: FixedColumnWidth(50),
                                      5: FixedColumnWidth(50),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Freq.',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Plan\nSam\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Act\nSam\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Rep\nDue\nDate',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Sent\nRep\nDate',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 50,
                                              child: Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    'Rep days',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ..._datasearch.map((item) {
                                        return TableRow(
                                          children: [
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.FREQ4,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.PLANSAM4,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.ACTSAM4,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.REPDUE4,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.SENTREP4,
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    item.REPDAYS4,
                                                    style:
                                                        TextStyle(fontSize: 8),
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
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            height: 120,
                            width: 175,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                left: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Group A:\nLong sample preparation time',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 175,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                left: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Group B:\nOther (Not long sample\npreparation time)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 175,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                left: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Service performance',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
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
                                'Weekly',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
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
                                'Monthly',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
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
                                'Weekly',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
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
                                'Monthly',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
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
                                'KAC customer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
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
                                'Medium customer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Total report (issue)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupASumFreq1.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupASumFreq2.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupASumFreq3.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupASumFreq4.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Report more than 12 WD (issue)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupACountRepDays1.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupACountRepDays2.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupACountRepDays3.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupACountRepDays4.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'KPI achievement (Target 100%)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupAKPIAchievement1.isNaN
                                        ? '0%'
                                        : (groupAKPIAchievement1 % 1 == 0
                                            ? '${groupAKPIAchievement1.toInt()}%'
                                            : '${groupAKPIAchievement1.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupAKPIAchievement2.isNaN
                                        ? '0%'
                                        : (groupAKPIAchievement2 % 1 == 0
                                            ? '${groupAKPIAchievement2.toInt()}%'
                                            : '${groupAKPIAchievement2.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupAKPIAchievement3.isNaN
                                        ? '0%'
                                        : (groupAKPIAchievement3 % 1 == 0
                                            ? '${groupAKPIAchievement3.toInt()}%'
                                            : '${groupAKPIAchievement3.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupAKPIAchievement4.isNaN
                                        ? '0%'
                                        : (groupAKPIAchievement4 % 1 == 0
                                            ? '${groupAKPIAchievement4.toInt()}%'
                                            : '${groupAKPIAchievement4.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Total report (issue)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 1200,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupASumAllFreq.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Report more than 12 WD (issue)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 1200,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupASumAllRepDays.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'KPI achievement (Target 100%)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 1200,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupAKPISumAchievement.isNaN
                                        ? '0%'
                                        : (groupAKPISumAchievement % 1 == 0
                                            ? '${groupAKPISumAchievement.toInt()}%'
                                            : '${groupAKPISumAchievement.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Total report (issue)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBSumFreq1.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBSumFreq2.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBSumFreq3.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBSumFreq4.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Report more than 10 WD (issue)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBCountRepDays1.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBCountRepDays2.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBCountRepDays3.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBCountRepDays4.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'KPI achievement (Target 100%)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBKPIAchievement1.isNaN
                                        ? '0%'
                                        : (groupBKPIAchievement1 % 1 == 0
                                            ? '${groupBKPIAchievement1.toInt()}%'
                                            : '${groupBKPIAchievement1.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBKPIAchievement2.isNaN
                                        ? '0%'
                                        : (groupBKPIAchievement2 % 1 == 0
                                            ? '${groupBKPIAchievement2.toInt()}%'
                                            : '${groupBKPIAchievement2.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBKPIAchievement3.isNaN
                                        ? '0%'
                                        : (groupBKPIAchievement3 % 1 == 0
                                            ? '${groupBKPIAchievement3.toInt()}%'
                                            : '${groupBKPIAchievement3.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBKPIAchievement4.isNaN
                                        ? '0%'
                                        : (groupBKPIAchievement4 % 1 == 0
                                            ? '${groupBKPIAchievement4.toInt()}%'
                                            : '${groupBKPIAchievement4.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Total report (issue)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 1200,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBSumAllFreq.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Report more than 10 WD (issue)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 1200,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBSumAllRepDays.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: 260,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'KPI achievement (Target 100%)',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 1200,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    groupBKPISumAchievement.isNaN
                                        ? '0%'
                                        : (groupBKPISumAchievement % 1 == 0
                                            ? '${groupBKPISumAchievement.toInt()}%'
                                            : '${groupBKPISumAchievement.toStringAsFixed(2)}%'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 170,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    'Visit 100%',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
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
                                            'Visit plan',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 1200,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
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
                                            KACVisitPlanSum.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
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
                                            'Visit actual',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 1200,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
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
                                            KACVisitActualCount.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
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
                                            '%Visit',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 1200,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
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
                                            KACVisitPercent.isNaN
                                                ? '0%'
                                                : (KACVisitPercent % 1 == 0
                                                    ? '${KACVisitPercent.toInt()}%'
                                                    : '${KACVisitPercent.toStringAsFixed(2)}%'),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 170,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
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
                                    'Visit 95%',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
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
                                                'Visit plan',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 1200,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
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
                                                MEDIUMVisitPlanSum.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
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
                                                'Visit actual',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 1200,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
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
                                                MEDIUMVisitActualCount
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
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
                                                '%Visit',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 1200,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
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
                                                MEDIUMVisitPercent.isNaN
                                                    ? '0%'
                                                    : (MEDIUMVisitPercent % 1 ==
                                                            0
                                                        ? '${MEDIUMVisitPercent.toInt()}%'
                                                        : '${MEDIUMVisitPercent.toStringAsFixed(2)}%'),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
