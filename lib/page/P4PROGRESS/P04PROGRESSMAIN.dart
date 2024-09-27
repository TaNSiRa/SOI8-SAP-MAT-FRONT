// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/04-01-P04PROGRESSGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/piechart/chart_values_options.dart';
import '../../widget/piechart/legend_options.dart';
import '../../widget/piechart/pie_chart.dart';
import 'P04PROGRESSVAR.dart';

late BuildContext P04PROGRESSMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P04PROGRESSMAIN extends StatefulWidget {
  P04PROGRESSMAIN({
    super.key,
    this.data,
  });
  List<P04PROGRESSGETDATAclass>? data;

  @override
  State<P04PROGRESSMAIN> createState() => _P04PROGRESSMAINState();
}

class _P04PROGRESSMAINState extends State<P04PROGRESSMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P04PROGRESSGETDATA_Bloc>().add(P04PROGRESSGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P04PROGRESSMAINcontext = context;
    List<P04PROGRESSGETDATAclass> _datain = widget.data ?? [];

// ตัวแปรสําหรับใช้กับ Dropdown
    final selectedType = (P04PROGRESSVAR.DropDownType.isNotEmpty)
        ? P04PROGRESSVAR.DropDownType
        : 'Group A';
    final selectedYear = (P04PROGRESSVAR.DropDownYear.isNotEmpty)
        ? P04PROGRESSVAR.DropDownYear
        : P04PROGRESSVAR.currentYear;
    final selectedMonth = (P04PROGRESSVAR.DropDownMonth.isNotEmpty)
        ? P04PROGRESSVAR.DropDownMonth
        : P04PROGRESSVAR.currentMonth;

// Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupTargetDaysMap = {
      'Group A': P04PROGRESSVAR.GroupA,
      'Group B': P04PROGRESSVAR.GroupB,
    };

    // เลือก Group A,B ตาม selectedType
    final GroupTargetDays =
        groupTargetDaysMap[selectedType] ?? P04PROGRESSVAR.GroupA;

    // กรองข้อมูลด้วยปีและเดือน
    List<P04PROGRESSGETDATAclass> filteredData = _datain.where((data) {
      return data.TYPE == selectedType &&
          data.YEAR == selectedYear &&
          data.MONTH == selectedMonth;
    }).toList();

//แยกข้อมูล week 1-4
    List<Map<String, String>> IssueData = [];
    for (var data in filteredData) {
      if (data.REPDAYS1.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS1)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData = {
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
        IssueData.add(transformedData);
      }
      if (data.REPDAYS2.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS2)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData = {
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
        IssueData.add(transformedData);
      }
      if (data.REPDAYS3.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS3)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData = {
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
        IssueData.add(transformedData);
      }
      if (data.REPDAYS4.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS4)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData = {
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
        IssueData.add(transformedData);
      }
    }

// ข้อมูลทั้งหมด
    List<Map<String, String>> AllData = [];
    for (var data in filteredData) {
      // เก็บข้อมูลแรก
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
      AllData.add(transformedData1);

      // เก็บข้อมูลที่สอง
      Map<String, String> transformedData2 = {
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
      AllData.add(transformedData2);

      // เก็บข้อมูลที่สาม
      Map<String, String> transformedData3 = {
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
      AllData.add(transformedData3);

      // เก็บข้อมูลที่สี่
      Map<String, String> transformedData4 = {
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
      AllData.add(transformedData4);
    }

    double IssueReport = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear).length.toDouble();
    IssueReport = double.parse(IssueReport.toStringAsFixed(1));

    double AllReport = AllData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear).length.toDouble();
    AllReport = double.parse(AllReport.toStringAsFixed(1));

    double SuccessReport = AllReport - IssueReport;

    double IssueReport1315 = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        int.parse(item['rep days']!) > 12 &&
        int.parse(item['rep days']!) < 16).length.toDouble();
    IssueReport1315 = double.parse(IssueReport1315.toStringAsFixed(1));

    double IssueReportMore15 = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        int.parse(item['rep days']!) >= 16).length.toDouble();
    IssueReportMore15 = double.parse(IssueReportMore15.toStringAsFixed(1));

    Map<String, double> pieData1 = {};
    pieData1['Achieved KPI (Iss.)'] = SuccessReport;
    pieData1['Not Achieved KPI (Iss.)'] = IssueReport;

    Map<String, double> pieData2 = {};
    pieData2['13-15 Working days'] = IssueReport1315;
    pieData2['More than 15 Working days'] = IssueReportMore15;

    return Stack(
      children: [
        Scrollbar(
          controller: _controllerIN01,
          thumbVisibility: true,
          interactive: true,
          thickness: 10,
          radius: Radius.circular(20),
          child: SingleChildScrollView(
            controller: _controllerIN01,
            child: Column(
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
                        'SAR : Report Performance ($selectedMonth $selectedYear)',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '$selectedType\n'
                  '$GroupTargetDays',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      right: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              if (P04PROGRESSVAR.DropDownType.isNotEmpty ||
                                  P04PROGRESSVAR.DropDownYear.isNotEmpty ||
                                  P04PROGRESSVAR.DropDownMonth.isNotEmpty)
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    'TYPE',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              AdvanceDropDown(
                                hint: "TYPE",
                                listdropdown: const [
                                  MapEntry("TYPE", ""),
                                  MapEntry("Group A", "Group A"),
                                  MapEntry("Group B", "Group B"),
                                ],
                                onChangeinside: (d, k) {
                                  setState(() {
                                    P04PROGRESSVAR.DropDownType = d;
                                  });
                                },
                                value: P04PROGRESSVAR.DropDownType,
                                height: 30,
                                width: 100,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              if (P04PROGRESSVAR.DropDownType.isNotEmpty ||
                                  P04PROGRESSVAR.DropDownYear.isNotEmpty ||
                                  P04PROGRESSVAR.DropDownMonth.isNotEmpty)
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
                                    P04PROGRESSVAR.DropDownYear = d;
                                  });
                                },
                                value: P04PROGRESSVAR.DropDownYear,
                                height: 30,
                                width: 100,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              if (P04PROGRESSVAR.DropDownType.isNotEmpty ||
                                  P04PROGRESSVAR.DropDownYear.isNotEmpty ||
                                  P04PROGRESSVAR.DropDownMonth.isNotEmpty)
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
                                    P04PROGRESSVAR.DropDownMonth = d;
                                  });
                                },
                                value: P04PROGRESSVAR.DropDownMonth,
                                height: 30,
                                width: 100,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PieChart(
                          dataMap: pieData1,
                          chartRadius: MediaQuery.of(context).size.width / 4,
                          colorList: [
                            Colors.lightGreen,
                            Colors.yellow.shade200
                          ],
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            chartValueBackgroundColor: Colors.white,
                            showChartValues: true,
                            chartValueStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.bottom,
                            showLegendsInRow: true,
                            legendTextStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          chartType: ChartType.disc,
                          baseChartColor: Colors.grey[300]!,
                          centerTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 35),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'Total : ${AllReport} Iss.',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PieChart(
                          dataMap: pieData2,
                          chartRadius: MediaQuery.of(context).size.width / 6,
                          colorList: [Colors.yellow.shade200, Colors.red],
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            chartValueBackgroundColor: Colors.white,
                            showChartValues: true,
                            chartValueStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.bottom,
                            showLegendsInRow: true,
                            legendTextStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartType: ChartType.disc,
                          baseChartColor: Colors.grey[300]!,
                          centerTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
