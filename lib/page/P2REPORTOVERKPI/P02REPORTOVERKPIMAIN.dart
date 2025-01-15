// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02REPORTOVERKPIGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import '../P6TABLEREPORTOVERDUE/P06TABLEREPORTOVERDUEMAIN.dart';
import 'P02REPORTOVERKPIVAR.dart';

late BuildContext P02REPORTOVERKPIMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P02REPORTOVERKPIMAIN extends StatefulWidget {
  P02REPORTOVERKPIMAIN({
    super.key,
    this.data,
  });
  List<P02REPORTOVERKPIGETDATAclass>? data;

  @override
  State<P02REPORTOVERKPIMAIN> createState() => _P02REPORTOVERKPIMAINState();
}

class _P02REPORTOVERKPIMAINState extends State<P02REPORTOVERKPIMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P02REPORTOVERKPIGETDATA_Bloc>()
        .add(P02REPORTOVERKPIGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P02REPORTOVERKPIMAINcontext = context;
    List<P02REPORTOVERKPIGETDATAclass> _datain = widget.data ?? [];

    // ตัวแปรสําหรับใช้กับ Dropdown
    final selectedType = (P02REPORTOVERKPIVAR.DropDownType.isNotEmpty)
        ? P02REPORTOVERKPIVAR.DropDownType
        : 'A';
    final selectedYear = (P02REPORTOVERKPIVAR.DropDownYear.isNotEmpty)
        ? P02REPORTOVERKPIVAR.DropDownYear
        : P02REPORTOVERKPIVAR.currentYear;
    final selectedMonth = (P02REPORTOVERKPIVAR.DropDownMonth.isNotEmpty)
        ? P02REPORTOVERKPIVAR.DropDownMonth
        : P02REPORTOVERKPIVAR.currentMonth2;
    // แปลง MM เป็น MMM
    final selectedMonthMMM = P02REPORTOVERKPIVAR
        .convertMonthToMMM(P02REPORTOVERKPIVAR.DropDownMonth);

    // Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupTargetDaysMap = {
      'A': P02REPORTOVERKPIVAR.GroupATargetDays,
      'B': P02REPORTOVERKPIVAR.GroupBTargetDays,
    };

    // เลือก Group A,B ตาม selectedType
    final GroupTargetDays = groupTargetDaysMap[selectedType] ??
        P02REPORTOVERKPIVAR.GroupATargetDays;

    // Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupSampleTimeMap = {
      'A': P02REPORTOVERKPIVAR.GroupAsampleTime,
      'B': P02REPORTOVERKPIVAR.GroupBsampleTime,
    };

    // เลือก Group A,B ตาม selectedType
    final groupSampleTime = groupSampleTimeMap[selectedType] ??
        P02REPORTOVERKPIVAR.GroupAsampleTime;

    // กำหนด Period ตาม selectedType
    final typeValue = (selectedType == 'A')
        ? 12
        : (selectedType == 'B')
            ? 10
            : 0;

    // กรองข้อมูลด้วย Type ,YEAR ,MONTH
    List<P02REPORTOVERKPIGETDATAclass> filteredData = _datain.where((data) {
      return data.TYPE == selectedType;
    }).toList();

    // print(filteredData.length);

    //แยกข้อมูล week 1-4
    List<Map<String, String>> newData = [];
    for (var data in filteredData) {
      if (data.REPDAYS1.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          extractYear(data.REPDUE1) == selectedYear &&
          extractMonth(data.REPDUE1) == selectedMonth &&
          int.tryParse(data.REPDAYS1)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'custshort': data.CUSTSHORT,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'reqno': data.REQNO1,
          'freq': data.FREQ1,
          'plan sam': (data.PLANSAM1),
          'act sam': (data.ACTSAM1),
          'rep due': (data.REPDUE1),
          'sent rep': (data.SENTREP1),
          'rep days': (data.REPDAYS1),
          'request': (data.REQUEST1),
          'ttcresult': (data.TTCRESULT1),
          'issuedate': (data.ISSUEDATE1),
          'sublead': (data.SUBLEAD1),
          'gl': (data.GL1),
          'mgr': (data.MGR1),
          'jp': (data.JP1),
          'revise1': (data.REVISE1_1),
          'sublead1': (data.SUBLEAD1_1),
          'gl1': (data.GL1_1),
          'mgr1': (data.MGR1_1),
          'jp1': (data.JP1_1),
          'revise2': (data.REVISE1_2),
          'sublead2': (data.SUBLEAD1_1),
          'gl2': (data.GL1_2),
          'mgr2': (data.MGR1_2),
          'jp2': (data.JP1_2),
          'revise3': (data.REVISE1_3),
          'sublead3': (data.SUBLEAD1_3),
          'gl3': (data.GL1_3),
          'mgr3': (data.MGR1_3),
          'jp3': (data.JP1_3),
          'bdprepare': data.BDPREPARE1,
          'bdttc': data.BDTTC1,
          'bdissue': data.BDISSUE1,
          'bdsublead': data.BDSUBLEAD1,
          'bdgl': data.BDGL1,
          'bdmgr': data.BDMGR1,
          'bdjp': data.BDJP1,
          'bdrevise1': data.BDREVISE1_1,
          'bdsublead1': data.BDSUBLEAD1_1,
          'bdgl1': data.BDGL1_1,
          'bdmgr1': data.BDMGR1_1,
          'bdjp1': data.BDJP1_1,
          'bdrevise2': data.BDREVISE1_2,
          'bdsublead2': data.BDSUBLEAD1_2,
          'bdgl2': data.BDGL1_2,
          'bdmgr2': data.BDMGR1_2,
          'bdjp2': data.BDJP1_2,
          'bdrevise3': data.BDREVISE1_3,
          'bdsublead3': data.BDSUBLEAD1_3,
          'bdgl3': data.BDGL1_3,
          'bdmgr3': data.BDMGR1_3,
          'bdjp3': data.BDJP1_3,
          'bdsent': data.BDSENT1,
          'reason': data.REASON1,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS2.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          extractYear(data.REPDUE2) == selectedYear &&
          extractMonth(data.REPDUE2) == selectedMonth &&
          int.tryParse(data.REPDAYS2)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'custshort': data.CUSTSHORT,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'reqno': data.REQNO2,
          'freq': data.FREQ2,
          'plan sam': (data.PLANSAM2),
          'act sam': (data.ACTSAM2),
          'rep due': (data.REPDUE2),
          'sent rep': (data.SENTREP2),
          'rep days': (data.REPDAYS2),
          'request': (data.REQUEST2),
          'ttcresult': (data.TTCRESULT2),
          'issuedate': (data.ISSUEDATE2),
          'sublead': (data.SUBLEAD2),
          'gl': (data.GL2),
          'mgr': (data.MGR2),
          'jp': (data.JP2),
          'revise1': (data.REVISE2_1),
          'sublead1': (data.SUBLEAD2_1),
          'gl1': (data.GL2_1),
          'mgr1': (data.MGR2_1),
          'jp1': (data.JP2_1),
          'revise2': (data.REVISE2_2),
          'sublead2': (data.SUBLEAD2_1),
          'gl2': (data.GL2_2),
          'mgr2': (data.MGR2_2),
          'jp2': (data.JP2_2),
          'revise3': (data.REVISE2_3),
          'sublead3': (data.SUBLEAD2_3),
          'gl3': (data.GL2_3),
          'mgr3': (data.MGR2_3),
          'jp3': (data.JP2_3),
          'bdprepare': data.BDPREPARE2,
          'bdttc': data.BDTTC2,
          'bdissue': data.BDISSUE2,
          'bdsublead': data.BDSUBLEAD2,
          'bdgl': data.BDGL2,
          'bdmgr': data.BDMGR2,
          'bdjp': data.BDJP2,
          'bdrevise1': data.BDREVISE2_1,
          'bdsublead1': data.BDSUBLEAD2_1,
          'bdgl1': data.BDGL2_1,
          'bdmgr1': data.BDMGR2_1,
          'bdjp1': data.BDJP2_1,
          'bdrevise2': data.BDREVISE2_2,
          'bdsublead2': data.BDSUBLEAD2_2,
          'bdgl2': data.BDGL2_2,
          'bdmgr2': data.BDMGR2_2,
          'bdjp2': data.BDJP2_2,
          'bdrevise3': data.BDREVISE2_3,
          'bdsublead3': data.BDSUBLEAD2_3,
          'bdgl3': data.BDGL2_3,
          'bdmgr3': data.BDMGR2_3,
          'bdjp3': data.BDJP2_3,
          'bdsent': data.BDSENT2,
          'reason': data.REASON2,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS3.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          extractYear(data.REPDUE3) == selectedYear &&
          extractMonth(data.REPDUE3) == selectedMonth &&
          int.tryParse(data.REPDAYS3)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'custshort': data.CUSTSHORT,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'reqno': data.REQNO3,
          'freq': data.FREQ3,
          'plan sam': (data.PLANSAM3),
          'act sam': (data.ACTSAM3),
          'rep due': (data.REPDUE3),
          'sent rep': (data.SENTREP3),
          'rep days': (data.REPDAYS3),
          'request': (data.REQUEST3),
          'ttcresult': (data.TTCRESULT3),
          'issuedate': (data.ISSUEDATE3),
          'sublead': (data.SUBLEAD3),
          'gl': (data.GL3),
          'mgr': (data.MGR3),
          'jp': (data.JP3),
          'revise1': (data.REVISE3_1),
          'sublead1': (data.SUBLEAD3_1),
          'gl1': (data.GL3_1),
          'mgr1': (data.MGR3_1),
          'jp1': (data.JP3_1),
          'revise2': (data.REVISE3_2),
          'sublead2': (data.SUBLEAD3_1),
          'gl2': (data.GL3_2),
          'mgr2': (data.MGR3_2),
          'jp2': (data.JP3_2),
          'revise3': (data.REVISE3_3),
          'sublead3': (data.SUBLEAD3_3),
          'gl3': (data.GL3_3),
          'mgr3': (data.MGR3_3),
          'jp3': (data.JP3_3),
          'bdprepare': data.BDPREPARE3,
          'bdttc': data.BDTTC3,
          'bdissue': data.BDISSUE3,
          'bdsublead': data.BDSUBLEAD3,
          'bdgl': data.BDGL3,
          'bdmgr': data.BDMGR3,
          'bdjp': data.BDJP3,
          'bdrevise1': data.BDREVISE3_1,
          'bdsublead1': data.BDSUBLEAD3_1,
          'bdgl1': data.BDGL3_1,
          'bdmgr1': data.BDMGR3_1,
          'bdjp1': data.BDJP3_1,
          'bdrevise2': data.BDREVISE3_2,
          'bdsublead2': data.BDSUBLEAD3_2,
          'bdgl2': data.BDGL3_2,
          'bdmgr2': data.BDMGR3_2,
          'bdjp2': data.BDJP3_2,
          'bdrevise3': data.BDREVISE3_3,
          'bdsublead3': data.BDSUBLEAD3_3,
          'bdgl3': data.BDGL3_3,
          'bdmgr3': data.BDMGR3_3,
          'bdjp3': data.BDJP3_3,
          'bdsent': data.BDSENT3,
          'reason': data.REASON3,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS4.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          extractYear(data.REPDUE4) == selectedYear &&
          extractMonth(data.REPDUE4) == selectedMonth &&
          int.tryParse(data.REPDAYS4)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'custshort': data.CUSTSHORT,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'reqno': data.REQNO4,
          'freq': data.FREQ4,
          'plan sam': (data.PLANSAM4),
          'act sam': (data.ACTSAM4),
          'rep due': (data.REPDUE4),
          'sent rep': (data.SENTREP4),
          'rep days': (data.REPDAYS4),
          'request': (data.REQUEST4),
          'ttcresult': (data.TTCRESULT4),
          'issuedate': (data.ISSUEDATE4),
          'sublead': (data.SUBLEAD4),
          'gl': (data.GL4),
          'mgr': (data.MGR4),
          'jp': (data.JP4),
          'revise1': (data.REVISE4_1),
          'sublead1': (data.SUBLEAD4_1),
          'gl1': (data.GL4_1),
          'mgr1': (data.MGR4_1),
          'jp1': (data.JP4_1),
          'revise2': (data.REVISE4_2),
          'sublead2': (data.SUBLEAD4_1),
          'gl2': (data.GL4_2),
          'mgr2': (data.MGR4_2),
          'jp2': (data.JP4_2),
          'revise3': (data.REVISE4_3),
          'sublead3': (data.SUBLEAD4_3),
          'gl3': (data.GL4_3),
          'mgr3': (data.MGR4_3),
          'jp3': (data.JP4_3),
          'bdprepare': data.BDPREPARE4,
          'bdttc': data.BDTTC4,
          'bdissue': data.BDISSUE4,
          'bdsublead': data.BDSUBLEAD4,
          'bdgl': data.BDGL4,
          'bdmgr': data.BDMGR4,
          'bdjp': data.BDJP4,
          'bdrevise1': data.BDREVISE4_1,
          'bdsublead1': data.BDSUBLEAD4_1,
          'bdgl1': data.BDGL4_1,
          'bdmgr1': data.BDMGR4_1,
          'bdjp1': data.BDJP4_1,
          'bdrevise2': data.BDREVISE4_2,
          'bdsublead2': data.BDSUBLEAD4_2,
          'bdgl2': data.BDGL4_2,
          'bdmgr2': data.BDMGR4_2,
          'bdjp2': data.BDJP4_2,
          'bdrevise3': data.BDREVISE4_3,
          'bdsublead3': data.BDSUBLEAD4_3,
          'bdgl3': data.BDGL4_3,
          'bdmgr3': data.BDMGR4_3,
          'bdjp3': data.BDJP4_3,
          'bdsent': data.BDSENT4,
          'reason': data.REASON4,
        };
        newData.add(transformedData1);
      }
    }

    // print(newData);

    // Sum ข้อมูลแต่ะชุด
    List<double> avgAllBreakdown = [];

    List<double> FilterBdprepare = newData
        .where((item) => item['bdprepare'] != null && item['bdprepare'] != "")
        .map((item) => double.tryParse(item['bdprepare'].toString()) ?? 0.0)
        .toList();
    double AvgBdprepare = FilterBdprepare.isNotEmpty
        ? FilterBdprepare.reduce((a, b) => a + b) / FilterBdprepare.length
        : 0.0;

    List<double> FilterBdttc = newData
        .where((item) => item['bdttc'] != null && item['bdttc'] != "")
        .map((item) => double.tryParse(item['bdttc'].toString()) ?? 0.0)
        .toList();
    double AvgBdttc = FilterBdttc.isNotEmpty
        ? FilterBdttc.reduce((a, b) => a + b) / FilterBdttc.length
        : 0.0;

    List<double> FilterBdissue = newData
        .where((item) => item['bdissue'] != null && item['bdissue'] != "")
        .map((item) => double.tryParse(item['bdissue'].toString()) ?? 0.0)
        .toList();
    double AvgBdissue = FilterBdissue.isNotEmpty
        ? FilterBdissue.reduce((a, b) => a + b) / FilterBdissue.length
        : 0.0;

    List<double> allBdreviseValues = newData
        .expand((item) => [
              item['bdrevise1'],
              item['bdrevise2'],
              item['bdrevise3'],
            ])
        .where((value) =>
            value != null && value != 'null' && value.toString().isNotEmpty)
        .map((value) => double.tryParse(value.toString()) ?? 0.0)
        .toList();
    double AvgAllBdrevise = allBdreviseValues.isNotEmpty
        ? allBdreviseValues.reduce((a, b) => a + b) / allBdreviseValues.length
        : 0.0;

    List<double> allBdsubleadValues = newData
        .expand((item) => [
              item['bdsublead'],
              item['bdsublead1'],
              item['bdsublead2'],
              item['bdsublead3'],
            ])
        .where((value) =>
            value != null && value != 'null' && value.toString().isNotEmpty)
        .map((value) => double.tryParse(value.toString()) ?? 0.0)
        .toList();
    double AvgAllBdsublead = allBdsubleadValues.isNotEmpty
        ? allBdsubleadValues.reduce((a, b) => a + b) / allBdsubleadValues.length
        : 0.0;

    List<double> allBdglValues = newData
        .expand((item) => [
              item['bdgl'],
              item['bdgl1'],
              item['bdgl2'],
              item['bdgl3'],
            ])
        .where((value) =>
            value != null && value != 'null' && value.toString().isNotEmpty)
        .map((value) => double.tryParse(value.toString()) ?? 0.0)
        .toList();
    double AvgAllBdgl = allBdglValues.isNotEmpty
        ? allBdglValues.reduce((a, b) => a + b) / allBdglValues.length
        : 0.0;

    List<double> allBdmgrValues = newData
        .expand((item) => [
              item['bdmgr'],
              item['bdmgr1'],
              item['bdmgr2'],
              item['bdmgr3'],
            ])
        .where((value) =>
            value != null && value != 'null' && value.toString().isNotEmpty)
        .map((value) => double.tryParse(value.toString()) ?? 0.0)
        .toList();
    double AvgAllBdmgr = allBdmgrValues.isNotEmpty
        ? allBdmgrValues.reduce((a, b) => a + b) / allBdmgrValues.length
        : 0.0;

    List<double> allBdjpValues = newData
        .expand((item) => [
              item['bdjp'],
              item['bdjp1'],
              item['bdjp2'],
              item['bdjp3'],
            ])
        .where((value) =>
            value != null && value != 'null' && value.toString().isNotEmpty)
        .map((value) => double.tryParse(value.toString()) ?? 0.0)
        .toList();
    double AvgAllBdjp = allBdjpValues.isNotEmpty
        ? allBdjpValues.reduce((a, b) => a + b) / allBdjpValues.length
        : 0.0;

    List<double> FilterBdsent = newData
        .where((item) => item['bdsent'] != null && item['bdsent'] != "")
        .map((item) => double.tryParse(item['bdsent'].toString()) ?? 0.0)
        .toList();
    double AvgBdsent = FilterBdsent.isNotEmpty
        ? FilterBdsent.reduce((a, b) => a + b) / FilterBdsent.length
        : 0.0;

    if (newData.isNotEmpty) {
      List<double> sumList = [
        AvgBdprepare,
        AvgBdttc,
        AvgBdissue,
        AvgAllBdrevise,
        AvgAllBdsublead,
        AvgAllBdgl,
        AvgAllBdmgr,
        AvgAllBdjp,
        AvgBdsent
      ];
      // print("sumList: $sumList");

      // หา Avg ของ sumList
      if (sumList.isNotEmpty) {
        // double avgTotal = sumList.reduce((a, b) => a + b) / sumList.length;
        double avgTotal = sumList.reduce((a, b) => a + b);
        avgTotal = double.parse(avgTotal.toStringAsFixed(2));

        // ใส่ avgTotal เป็นตัวแรกใน avgAllBreakdown
        avgAllBreakdown.insert(0, avgTotal);

        // กรองข้อมูลมั้งหมดแล้วนำไปใส่ไว้ใน List avgAllBreakdown
        for (String breakdown in [
          'bdsent',
          // 'bdjp',
          // 'bdmgr',
          // 'bdgl',
          // 'bdsublead',
          // 'bdrevise',
          'bdissue',
          'bdttc',
          'bdprepare',
        ]) {
          List<double> breakdownValues = newData
              .where((item) => item[breakdown] != null && item[breakdown] != "")
              .map((item) => double.tryParse(item[breakdown].toString()) ?? 0.0)
              .toList();

          double AvgBreakdown =
              breakdownValues.reduce((a, b) => a + b) / breakdownValues.length;
          AvgBreakdown = double.parse(AvgBreakdown.toStringAsFixed(2));
          avgAllBreakdown.add(AvgBreakdown);
        }
        avgAllBreakdown.insert(2, AvgAllBdrevise);
        avgAllBreakdown.insert(2, AvgAllBdsublead);
        avgAllBreakdown.insert(2, AvgAllBdgl);
        avgAllBreakdown.insert(2, AvgAllBdmgr);
        avgAllBreakdown.insert(2, AvgAllBdjp);
      } else {
        print("sumList is empty.");
      }
    } else {}
    // print("avgAllBreakdown: $avgAllBreakdown");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        controller: _controllerIN01,
        thumbVisibility: true,
        interactive: true,
        thickness: 10,
        radius: Radius.circular(20),
        child: Center(
          child: SingleChildScrollView(
            controller: _controllerIN01,
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                          'SAR : Report Performance',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Report Over KPI: Customer $selectedType (Target ≤ $typeValue days) ($selectedMonthMMM $selectedYear)',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        color: Colors.yellow.shade600,
                      ),
                      Text(' Target Days'),
                      SizedBox(width: 20),
                      Container(
                        height: 10,
                        width: 10,
                        color: Colors.blue.shade900,
                      ),
                      Text(' Actual Days'),
                    ],
                  ),
                  SizedBox(
                    height: 390,
                    width: 1100,
                    child: Stack(
                      children: [
                        Center(
                          child: CustomBarChart(
                            GroupTargetDays: GroupTargetDays,
                            avgAllBreakdown: avgAllBreakdown,
                            maxY: 20,
                          ),
                        ),
                        Positioned(
                          top: 195,
                          left: -50,
                          child: Transform.rotate(
                            angle: -90 * (3.14159 / 180),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                groupSampleTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  if (P02REPORTOVERKPIVAR.DropDownType.isNotEmpty ||
                                      P02REPORTOVERKPIVAR
                                          .DropDownYear.isNotEmpty ||
                                      P02REPORTOVERKPIVAR
                                          .DropDownMonth.isNotEmpty)
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
                                      // MapEntry("TYPE", ""),
                                      MapEntry("Group A", "A"),
                                      MapEntry("Group B", "B"),
                                    ],
                                    onChangeinside: (d, k) {
                                      setState(() {
                                        P02REPORTOVERKPIVAR.DropDownType = d;
                                        // context
                                        //     .read<P02REPORTOVERKPIGETDATA_Bloc>()
                                        //     .add(P02REPORTOVERKPIGETDATA_GET());
                                      });
                                    },
                                    value: P02REPORTOVERKPIVAR.DropDownType,
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
                                  if (P02REPORTOVERKPIVAR.DropDownType.isNotEmpty ||
                                      P02REPORTOVERKPIVAR
                                          .DropDownYear.isNotEmpty ||
                                      P02REPORTOVERKPIVAR
                                          .DropDownMonth.isNotEmpty)
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
                                      // MapEntry("YEAR", ""),
                                      MapEntry("2023", "2023"),
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
                                        P02REPORTOVERKPIVAR.DropDownYear = d;
                                        // context
                                        //     .read<P02REPORTOVERKPIGETDATA_Bloc>()
                                        //     .add(P02REPORTOVERKPIGETDATA_GET());
                                      });
                                    },
                                    value: P02REPORTOVERKPIVAR.DropDownYear,
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
                                  if (P02REPORTOVERKPIVAR.DropDownType.isNotEmpty ||
                                      P02REPORTOVERKPIVAR
                                          .DropDownYear.isNotEmpty ||
                                      P02REPORTOVERKPIVAR
                                          .DropDownMonth.isNotEmpty)
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
                                      // MapEntry("MONTH", ""),
                                      MapEntry("Jan", "01"),
                                      MapEntry("Feb", "02"),
                                      MapEntry("Mar", "03"),
                                      MapEntry("Apr", "04"),
                                      MapEntry("May", "05"),
                                      MapEntry("Jun", "06"),
                                      MapEntry("Jul", "07"),
                                      MapEntry("Aug", "08"),
                                      MapEntry("Sep", "09"),
                                      MapEntry("Oct", "10"),
                                      MapEntry("Nov", "11"),
                                      MapEntry("Dec", "12"),
                                    ],
                                    onChangeinside: (d, k) {
                                      setState(() {
                                        P02REPORTOVERKPIVAR.DropDownMonth = d;
                                        // context
                                        //     .read<P02REPORTOVERKPIGETDATA_Bloc>()
                                        //     .add(P02REPORTOVERKPIGETDATA_GET());
                                      });
                                    },
                                    value: P02REPORTOVERKPIVAR.DropDownMonth,
                                    height: 30,
                                    width: 100,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//คลาสสำหรับสร้างกราฟ
class CustomBarChart extends StatelessWidget {
  final List<double> GroupTargetDays;
  final List<double> avgAllBreakdown;
  final double maxY;

  const CustomBarChart({
    super.key,
    required this.GroupTargetDays,
    required this.avgAllBreakdown,
    required this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: 800,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomPaint(
        painter: BarChartPainter(
          GroupTargetDays: GroupTargetDays,
          avgAllBreakdown: avgAllBreakdown,
          maxY: maxY,
        ),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<double> GroupTargetDays;
  final List<double> avgAllBreakdown;
  final double maxY;
  final selectedYear = (P02REPORTOVERKPIVAR.DropDownYear.isNotEmpty)
      ? P02REPORTOVERKPIVAR.DropDownYear
      : P02REPORTOVERKPIVAR.currentYear;

  BarChartPainter({
    required this.GroupTargetDays,
    required this.avgAllBreakdown,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // สีของแท่งกราฟ Target
    final paintNextTarget = Paint()
      ..color = Colors.yellow.shade600
      ..style = PaintingStyle.fill;

    // สีของแท่งกราฟ Actual
    final paintNextActual = Paint()
      ..color = Colors.blue.shade900
      ..style = PaintingStyle.fill;

    // สีของแท่งกราฟ Target แรก
    final paintFirstTarget = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // สีของแท่งกราฟ Actual แรก
    final paintFirstActual = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // สีของเส้นไกด์
    final guideLinePaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    final barHeight = (size.height / (GroupTargetDays.length * 2)) *
        0.3; // ความสูงของแท่ง,ความกว้างของแท่ง
    const spaceBetweenBars = 5.0; // ระยะห่างระหว่างแท่งที่ชิดกัน
    const spaceBetweenMonths = 17.5; // ระยะห่างระหว่างเดือน
    const startYOffset = 20.0; // จุดเริ่มต้นของกราฟแท่ง

    // วาดเส้นไกด์แนวตั้งบนแกน X
    for (int i = 0; i <= maxY; i += 2) {
      final xPosition = (i / maxY) * size.width;
      canvas.drawLine(
          Offset(xPosition, 0), Offset(xPosition, size.height), guideLinePaint);
    }

    // เริ่ม Loop สำหรับสร้างแท่งกราฟ
    for (int i = 0; i < GroupTargetDays.length; i++) {
      if (i >= avgAllBreakdown.length) {
        // หยุดการทำงานถ้าข้อมูลไม่เพียงพอ
        break;
      }
      // คำนวณตำแหน่งของแท่งกราฟ Target
      final topTarget = startYOffset +
          i * (barHeight * 2 + spaceBetweenBars) +
          (i * spaceBetweenMonths);
      // คำนวณความกว้างของแท่งกราฟ Target
      final rightTarget = (GroupTargetDays[i] / maxY) * size.width;
      // สร้างสี่เหลี่ยมพื้นผ้าของ Target (ตำแหน่งแกน X, ตำแหน่งแกน Y, ความกว้าง, ความสูง)
      final rectTarget = Rect.fromLTWH(0, topTarget, rightTarget, barHeight);

      // ตรวจสอบว่าเป็นแท่งแรกหรือไม่
      final paintTarget = (i == 0) ? paintFirstTarget : paintNextTarget;

      // วาดแท่งกราฟ Target
      canvas.drawRect(rectTarget, paintTarget);

      // วาดตัวเลขบนแท่งกราฟ Target
      String TargetText = '';

      if (GroupTargetDays[i] != 0) {
        TargetText = GroupTargetDays[i].toStringAsFixed(2);

        // ตรวจสอบว่าหมายเลขเป็นจำนวนเต็มหรือไม่
        if (GroupTargetDays[i] % 1 == 0) {
          TargetText = GroupTargetDays[i].toInt().toString();
        }
      }

      // ตรวจสอบว่า TargetText มีค่าหรือไม่
      if (TargetText.isNotEmpty) {
        // สร้าง TextPainter สำหรับ Target
        final textPainterTarget = TextPainter(
          text: TextSpan(
            text: TargetText,
            style: TextStyle(color: Colors.black, fontSize: 7),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainterTarget.layout();
        // หาตำแหน่งแกน X ของค่า Target
        final textXPositionTarget = rightTarget + 5;
        // หาตำแหน่งแกน Y ของค่า Target
        final textYPositionTarget = topTarget + (barHeight / 2) - 4;
        // วาดตัวเลขบนแท่งกราฟ Target (แกน X, แกน Y)
        textPainterTarget.paint(
            canvas, Offset(textXPositionTarget, textYPositionTarget));
      }

      // คำนวณตำแหน่งของแท่งกราฟ Actual
      final topActual = topTarget + barHeight + spaceBetweenBars;
      // คำนวณความกว้างของแท่งกราฟ Actual
      final rightActual = (avgAllBreakdown[i] / maxY) * size.width;
      // สร้างสี่เหลี่ยมพื้นผ้าของ Actual (ตำแหน่งแกน X, ตำแหน่งแกน Y, ความกว้าง, ความสูง)
      final rectActual = Rect.fromLTWH(0, topActual, rightActual, barHeight);

      // ตรวจสอบว่าเป็นแท่งแรกหรือไม่
      final paintActual = (i == 0) ? paintFirstActual : paintNextActual;

      // วาดแท่งกราฟ Actual
      canvas.drawRect(rectActual, paintActual);

      // วาดตัวเลขบนแท่งกราฟ Actual
      String ActualText = '';

      if (avgAllBreakdown[i] != 0) {
        ActualText = avgAllBreakdown[i].toStringAsFixed(2);

        // ตรวจสอบว่าหมายเลขเป็นจำนวนเต็มหรือไม่
        if (avgAllBreakdown[i] % 1 == 0) {
          ActualText = avgAllBreakdown[i].toInt().toString();
        }
      }

      // ตรวจสอบว่า ActualText มีค่าหรือไม่
      if (ActualText.isNotEmpty) {
        // สร้าง TextPainter สำหรับ Actual
        final textPainterActual = TextPainter(
          text: TextSpan(
            text: ActualText,
            style: TextStyle(color: Colors.black, fontSize: 7),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainterActual.layout();
        // หาตำแหน่งแกน X ของค่า Actual
        final textXPositionActual = rightActual + 5;
        // หาตำแหน่งแกน Y ของค่า Actual
        final textYPositionActual = topActual + (barHeight / 2) - 3;
        // วาดตัวเลขบนแท่งกราฟ Actual (แกน X, แกน Y)
        textPainterActual.paint(
            canvas, Offset(textXPositionActual, textYPositionActual));
      }
    }

    // กำหนดสี ,ความหนาของเส้นแกน X และ Y
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // เส้นแกน Y
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);

    // เส้นแกน X
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);

    // วาดตัวเลขบนแกน X
    final textStyle = TextStyle(color: Colors.black, fontSize: 10);
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i <= maxY; i += 2) {
      textPainter.text = TextSpan(
        text: '$i',
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset((i / maxY) * size.width - textPainter.width / 2,
              size.height + 5));
    }

    // วาดชื่อเดือนบนแกน Y
    for (int i = 0; i < GroupTargetDays.length; i++) {
      String monthText;

      monthText = P02REPORTOVERKPIVAR.breakdown[i];

      textPainter.text = TextSpan(
        text: monthText,
        style: textStyle,
      );

      textPainter.layout();

      // คำนวณตำแหน่งกลางระหว่างแท่ง Target และ Actual
      final yPosition = startYOffset +
          i * (barHeight * 2 + spaceBetweenBars) +
          (i * spaceBetweenMonths) +
          barHeight +
          (barHeight + spaceBetweenBars) / 2 -
          textPainter.height / 2;

      textPainter.paint(canvas, Offset(-textPainter.width - 5, yPosition - 3));
    }
  }

  void drawDashedLine(Canvas canvas, Paint paint, Offset p1, Offset p2) {
    const int dashWidth = 4;
    const int dashSpace = 4;
    double startX = p1.dx;
    while (startX < p2.dx) {
      canvas.drawLine(
          Offset(startX, p1.dy), Offset(startX + dashWidth, p1.dy), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
