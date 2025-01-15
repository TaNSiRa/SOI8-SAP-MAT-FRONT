// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, avoid_print
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/07-01-P07ASSEMBLEGRAPHGETDATA.dart';
import '../../bloc/BlocEvent/07-02-P07ASSEMBLEGRAPHGETDATA1.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/Loading.dart';
import '../../widget/function/helper.dart';
import '../../widget/piechart/chart_values_options.dart';
import '../../widget/piechart/legend_options.dart';
import '../../widget/piechart/pie_chart.dart';
import 'P07ASSEMBLEGRAPHVAR.dart';

final GlobalKey _globalKey = GlobalKey();
late BuildContext P07ASSEMBLEGRAPHMAINcontext;
ScrollController _controllerIN01 = ScrollController();
ScrollController _controllerIN02 = ScrollController();
ScrollController _controllerIN03 = ScrollController();

class P07ASSEMBLEGRAPHMAIN extends StatefulWidget {
  P07ASSEMBLEGRAPHMAIN({
    super.key,
    this.data,
    this.data1,
  });
  List<P07ASSEMBLEGRAPHGETDATAclass>? data;
  List<P07ASSEMBLEGRAPHGETDATA1class>? data1;

  @override
  State<P07ASSEMBLEGRAPHMAIN> createState() => _P07ASSEMBLEGRAPHMAINState();
}

class _P07ASSEMBLEGRAPHMAINState extends State<P07ASSEMBLEGRAPHMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P07ASSEMBLEGRAPHGETDATA_Bloc>()
        .add(P07ASSEMBLEGRAPHGETDATA_GET());
    Timer(Duration(seconds: 5), () {
      context
          .read<P07ASSEMBLEGRAPHGETDATA1_Bloc>()
          .add(P07ASSEMBLEGRAPHGETDATA1_GET());
    });
  }

  @override
  Widget build(BuildContext context) {
    P07ASSEMBLEGRAPHMAINcontext = context;
    List<P07ASSEMBLEGRAPHGETDATAclass> _datain = widget.data ?? [];
    List<P07ASSEMBLEGRAPHGETDATA1class> _datain1 = widget.data1 ?? [];
    // print(_datain.length);
    // print(_datain1.length);
// ตัวแปรสําหรับใช้กับ Dropdown
    final selectedType = (P07ASSEMBLEGRAPHVAR.DropDownType.isNotEmpty)
        ? P07ASSEMBLEGRAPHVAR.DropDownType
        : 'A';
    final selectedYear = (P07ASSEMBLEGRAPHVAR.DropDownYear.isNotEmpty)
        ? P07ASSEMBLEGRAPHVAR.DropDownYear
        : P07ASSEMBLEGRAPHVAR.currentYear;
    final selectedMonth = (P07ASSEMBLEGRAPHVAR.DropDownMonth.isNotEmpty)
        ? P07ASSEMBLEGRAPHVAR.DropDownMonth
        : P07ASSEMBLEGRAPHVAR.currentMonth2;
    // แปลง MM เป็น MMM
    final selectedMonthMMM = P07ASSEMBLEGRAPHVAR
        .convertMonthToMMM(P07ASSEMBLEGRAPHVAR.DropDownMonth);

// Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupTargetDaysMap = {
      'A': P07ASSEMBLEGRAPHVAR.GroupA,
      'B': P07ASSEMBLEGRAPHVAR.GroupB,
    };

    // เลือก Group A,B ตาม selectedType
    final GroupTargetDays =
        groupTargetDaysMap[selectedType] ?? P07ASSEMBLEGRAPHVAR.GroupA;

// Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupTargetDaysMap1 = {
      'A': P07ASSEMBLEGRAPHVAR.GroupATargetDays,
      'B': P07ASSEMBLEGRAPHVAR.GroupBTargetDays,
    };

    // เลือก Group A,B ตาม selectedType
    final GroupTargetDays1 = groupTargetDaysMap1[selectedType] ??
        P07ASSEMBLEGRAPHVAR.GroupATargetDays;

    // Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupSampleTimeMap = {
      'A': P07ASSEMBLEGRAPHVAR.GroupAsampleTime,
      'B': P07ASSEMBLEGRAPHVAR.GroupBsampleTime,
    };

    // เลือก Group A,B ตาม selectedType
    final groupSampleTime = groupSampleTimeMap[selectedType] ??
        P07ASSEMBLEGRAPHVAR.GroupAsampleTime;

    // กำหนด Period ตาม selectedType
    final typeValue = (selectedType == 'A')
        ? 12
        : (selectedType == 'B')
            ? 10
            : 0;

    // กรองข้อมูลด้วยปีและเดือน
    List<P07ASSEMBLEGRAPHGETDATAclass> filteredData = _datain.where((data) {
      int dataYear = int.parse(data.YEAR);
      int selectedYearInt = int.parse(selectedYear);
      return data.TYPE == selectedType &&
          (dataYear == selectedYearInt || dataYear == selectedYearInt - 1) &&
          data.REPDAYS1 != 'CLOSE LINE' &&
          data.REPDAYS2 != 'CLOSE LINE' &&
          data.REPDAYS3 != 'CLOSE LINE' &&
          data.REPDAYS4 != 'CLOSE LINE';
    }).toList();

    // กรองข้อมูลด้วย Type ,YEAR ,MONTH
    List<P07ASSEMBLEGRAPHGETDATA1class> filteredData1 = _datain1.where((data) {
      return data.TYPE == selectedType;
    }).toList();
    // print(filteredData1.length);

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
          'sublead': data.SUBLEAD1,
          'gl': data.GL1,
          'mgr': data.MGR1,
          'jp': data.JP1,
          'bdprepare': data.BDPREPARE1,
          'bdttc': data.BDTTC1,
          'bdissue': data.BDISSUE1,
          'bdsublead': data.BDSUBLEAD1,
          'bdgl': data.BDGL1,
          'bdmgr': data.BDMGR1,
          'bdjp': data.BDJP1,
          'bdsent': data.BDSENT1,
          'reason': data.REASON1,
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
          'sublead': data.SUBLEAD2,
          'gl': data.GL2,
          'mgr': data.MGR2,
          'jp': data.JP2,
          'bdprepare': data.BDPREPARE2,
          'bdttc': data.BDTTC2,
          'bdissue': data.BDISSUE2,
          'bdsublead': data.BDSUBLEAD2,
          'bdgl': data.BDGL2,
          'bdmgr': data.BDMGR2,
          'bdjp': data.BDJP2,
          'bdsent': data.BDSENT2,
          'reason': data.REASON2,
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
          'sublead': data.SUBLEAD3,
          'gl': data.GL3,
          'mgr': data.MGR3,
          'jp': data.JP3,
          'bdprepare': data.BDPREPARE3,
          'bdttc': data.BDTTC3,
          'bdissue': data.BDISSUE3,
          'bdsublead': data.BDSUBLEAD3,
          'bdgl': data.BDGL3,
          'bdmgr': data.BDMGR3,
          'bdjp': data.BDJP3,
          'bdsent': data.BDSENT3,
          'reason': data.REASON3,
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
          'sublead': data.SUBLEAD4,
          'gl': data.GL4,
          'mgr': data.MGR4,
          'jp': data.JP4,
          'bdprepare': data.BDPREPARE4,
          'bdttc': data.BDTTC4,
          'bdissue': data.BDISSUE4,
          'bdsublead': data.BDSUBLEAD4,
          'bdgl': data.BDGL4,
          'bdmgr': data.BDMGR4,
          'bdjp': data.BDJP4,
          'bdsent': data.BDSENT4,
          'reason': data.REASON4,
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
        'sublead': data.SUBLEAD1,
        'gl': data.GL1,
        'mgr': data.MGR1,
        'jp': data.JP1,
        'bdprepare': data.BDPREPARE1,
        'bdttc': data.BDTTC1,
        'bdissue': data.BDISSUE1,
        'bdsublead': data.BDSUBLEAD1,
        'bdgl': data.BDGL1,
        'bdmgr': data.BDMGR1,
        'bdjp': data.BDJP1,
        'bdsent': data.BDSENT1,
        'reason': data.REASON1,
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
        'sublead': data.SUBLEAD2,
        'gl': data.GL2,
        'mgr': data.MGR2,
        'jp': data.JP2,
        'bdprepare': data.BDPREPARE2,
        'bdttc': data.BDTTC2,
        'bdissue': data.BDISSUE2,
        'bdsublead': data.BDSUBLEAD2,
        'bdgl': data.BDGL2,
        'bdmgr': data.BDMGR2,
        'bdjp': data.BDJP2,
        'bdsent': data.BDSENT2,
        'reason': data.REASON2,
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
        'sublead': data.SUBLEAD3,
        'gl': data.GL3,
        'mgr': data.MGR3,
        'jp': data.JP3,
        'bdprepare': data.BDPREPARE3,
        'bdttc': data.BDTTC3,
        'bdissue': data.BDISSUE3,
        'bdsublead': data.BDSUBLEAD3,
        'bdgl': data.BDGL3,
        'bdmgr': data.BDMGR3,
        'bdjp': data.BDJP3,
        'bdsent': data.BDSENT3,
        'reason': data.REASON3,
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
        'sublead': data.SUBLEAD4,
        'gl': data.GL4,
        'mgr': data.MGR4,
        'jp': data.JP4,
        'bdprepare': data.BDPREPARE4,
        'bdttc': data.BDTTC4,
        'bdissue': data.BDISSUE4,
        'bdsublead': data.BDSUBLEAD4,
        'bdgl': data.BDGL4,
        'bdmgr': data.BDMGR4,
        'bdjp': data.BDJP4,
        'bdsent': data.BDSENT4,
        'reason': data.REASON4,
      };
      AllData.add(transformedData4);
    }

    List<Map<String, String>> IssueDataPreviousYear = [];
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
          'sublead': data.SUBLEAD1,
          'gl': data.GL1,
          'mgr': data.MGR1,
          'jp': data.JP1,
          'bdprepare': data.BDPREPARE1,
          'bdttc': data.BDTTC1,
          'bdissue': data.BDISSUE1,
          'bdsublead': data.BDSUBLEAD1,
          'bdgl': data.BDGL1,
          'bdmgr': data.BDMGR1,
          'bdjp': data.BDJP1,
          'bdsent': data.BDSENT1,
          'reason': data.REASON1,
        };
        IssueDataPreviousYear.add(transformedData);
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
          'sublead': data.SUBLEAD2,
          'gl': data.GL2,
          'mgr': data.MGR2,
          'jp': data.JP2,
          'bdprepare': data.BDPREPARE2,
          'bdttc': data.BDTTC2,
          'bdissue': data.BDISSUE2,
          'bdsublead': data.BDSUBLEAD2,
          'bdgl': data.BDGL2,
          'bdmgr': data.BDMGR2,
          'bdjp': data.BDJP2,
          'bdsent': data.BDSENT2,
          'reason': data.REASON2,
        };
        IssueDataPreviousYear.add(transformedData);
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
          'sublead': data.SUBLEAD3,
          'gl': data.GL3,
          'mgr': data.MGR3,
          'jp': data.JP3,
          'bdprepare': data.BDPREPARE3,
          'bdttc': data.BDTTC3,
          'bdissue': data.BDISSUE3,
          'bdsublead': data.BDSUBLEAD3,
          'bdgl': data.BDGL3,
          'bdmgr': data.BDMGR3,
          'bdjp': data.BDJP3,
          'bdsent': data.BDSENT3,
          'reason': data.REASON3,
        };
        IssueDataPreviousYear.add(transformedData);
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
          'sublead': data.SUBLEAD4,
          'gl': data.GL4,
          'mgr': data.MGR4,
          'jp': data.JP4,
          'bdprepare': data.BDPREPARE4,
          'bdttc': data.BDTTC4,
          'bdissue': data.BDISSUE4,
          'bdsublead': data.BDSUBLEAD4,
          'bdgl': data.BDGL4,
          'bdmgr': data.BDMGR4,
          'bdjp': data.BDJP4,
          'bdsent': data.BDSENT4,
          'reason': data.REASON4,
        };
        IssueDataPreviousYear.add(transformedData);
      }
    }

// ข้อมูลทั้งหมด
    List<Map<String, String>> AllDataPreviousYear = [];
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
        'sublead': data.SUBLEAD1,
        'gl': data.GL1,
        'mgr': data.MGR1,
        'jp': data.JP1,
        'bdprepare': data.BDPREPARE1,
        'bdttc': data.BDTTC1,
        'bdissue': data.BDISSUE1,
        'bdsublead': data.BDSUBLEAD1,
        'bdgl': data.BDGL1,
        'bdmgr': data.BDMGR1,
        'bdjp': data.BDJP1,
        'bdsent': data.BDSENT1,
        'reason': data.REASON1,
      };
      AllDataPreviousYear.add(transformedData1);

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
        'sublead': data.SUBLEAD2,
        'gl': data.GL2,
        'mgr': data.MGR2,
        'jp': data.JP2,
        'bdprepare': data.BDPREPARE2,
        'bdttc': data.BDTTC2,
        'bdissue': data.BDISSUE2,
        'bdsublead': data.BDSUBLEAD2,
        'bdgl': data.BDGL2,
        'bdmgr': data.BDMGR2,
        'bdjp': data.BDJP2,
        'bdsent': data.BDSENT2,
        'reason': data.REASON2,
      };
      AllDataPreviousYear.add(transformedData2);

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
        'sublead': data.SUBLEAD3,
        'gl': data.GL3,
        'mgr': data.MGR3,
        'jp': data.JP3,
        'bdprepare': data.BDPREPARE3,
        'bdttc': data.BDTTC3,
        'bdissue': data.BDISSUE3,
        'bdsublead': data.BDSUBLEAD3,
        'bdgl': data.BDGL3,
        'bdmgr': data.BDMGR3,
        'bdjp': data.BDJP3,
        'bdsent': data.BDSENT3,
        'reason': data.REASON3,
      };
      AllDataPreviousYear.add(transformedData3);

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
        'sublead': data.SUBLEAD4,
        'gl': data.GL4,
        'mgr': data.MGR4,
        'jp': data.JP4,
        'bdprepare': data.BDPREPARE4,
        'bdttc': data.BDTTC4,
        'bdissue': data.BDISSUE4,
        'bdsublead': data.BDSUBLEAD4,
        'bdgl': data.BDGL4,
        'bdmgr': data.BDMGR4,
        'bdjp': data.BDJP4,
        'bdsent': data.BDSENT4,
        'reason': data.REASON4,
      };
      AllDataPreviousYear.add(transformedData4);
    }

    double IssueReport = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear).length.toDouble();
    IssueReport = double.parse(IssueReport.toStringAsFixed(1));

    double AllReport = AllData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        item['freq'] != '' &&
        item['plan sam'] != '' &&
        item['act sam'] != '' &&
        item['rep due'] != '' &&
        item['sent rep'] != '' &&
        item['rep days'] != '').length.toDouble();
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

    double IssueReport1113 = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        int.parse(item['rep days']!) > 10 &&
        int.parse(item['rep days']!) < 14).length.toDouble();
    IssueReport1315 = double.parse(IssueReport1315.toStringAsFixed(1));

    double IssueReportMore13 = IssueData.where((item) =>
        item['type'] == selectedType &&
        item['month'] == selectedMonth &&
        item['year'] == selectedYear &&
        int.parse(item['rep days']!) >= 14).length.toDouble();
    IssueReportMore15 = double.parse(IssueReportMore15.toStringAsFixed(1));

    // Map pieData1 กับข้อมูลที่คำนวณมา
    Map<String, double> pieData1 = {};
    pieData1['Achieved KPI (Iss.)'] = SuccessReport;
    pieData1['Not Achieved KPI (Iss.)'] = IssueReport;

    // คำนวณมุมของ Not Achieved KPI (Iss.) ที่ต้องแสดงด้านขวาของ pieData1
    double IssueReportPercent = (IssueReport / AllReport) * 100;

    double initialAngleInDegree = (IssueReportPercent * 3.6) / 2;

    if (initialAngleInDegree.isNaN) {
      initialAngleInDegree = 0;
    }

    // Map pieData2 กับข้อมูลที่คำนวณมา
    Map<String, double> pieData2 = {};
    pieData2['13-15 Working days'] = IssueReport1315;
    pieData2['More than 15 Working days'] = IssueReportMore15;

    // คำนวณมุมของ 13-15 Working days ที่ต้องแสดงด้านซ้ายของ pieData2
    double notAchievedPercent1315 = (IssueReportMore15 / IssueReport) * 100;

    double initialAngleInDegree1315 = ((notAchievedPercent1315 * 3.6) / 2);

    if (initialAngleInDegree1315.isNaN) {
      initialAngleInDegree1315 = 0;
    }

    // Map pieData2 กับข้อมูลที่คำนวณมา
    Map<String, double> pieData3 = {};
    pieData3['11-13 Working days'] = IssueReport1113;
    pieData3['More than 13 Working days'] = IssueReportMore13;

    // คำนวณมุมของ 13-15 Working days ที่ต้องแสดงด้านซ้ายของ pieData2
    double notAchievedPercent1113 = (IssueReportMore13 / IssueReport) * 100;

    double initialAngleInDegree1113 = ((notAchievedPercent1113 * 3.6) / 2);

    if (initialAngleInDegree1113.isNaN) {
      initialAngleInDegree1113 = 0;
    }

    Map<String, int> IssueReportPreviousYear = {};
    for (String month in [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ]) {
      // นับจำนวณ Report over due ของทุกเดือน
      int IssueReport = IssueDataPreviousYear.where((item) =>
          item['type'] == selectedType &&
          item['month'] == month &&
          item['year'] == '${int.parse(selectedYear) - 1}' &&
          item['freq'] != '' &&
          item['freq'] != 'CLOSE LINE' &&
          item['plan sam'] != '' &&
          item['plan sam'] != 'CLOSE LINE' &&
          item['act sam'] != '' &&
          item['act sam'] != 'CLOSE LINE' &&
          item['rep due'] != '' &&
          item['rep due'] != 'CLOSE LINE' &&
          item['sent rep'] != '' &&
          item['sent rep'] != 'CLOSE LINE' &&
          item['rep days'] != '' &&
          item['rep days'] != 'CLOSE LINE').length;
      IssueReportPreviousYear[month] = IssueReport;
    }
    // print('IssueReportPreviousYear: ' + IssueReportPreviousYear.toString());
    Map<String, int> AllReportPreviousYear = {};
    for (String month in [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ]) {
      // นับจำนวณ Report ทั้งหมดของทุกเดือน
      int AllReport = AllDataPreviousYear.where((item) =>
          item['type'] == selectedType &&
          item['month'] == month &&
          item['year'] == '${int.parse(selectedYear) - 1}' &&
          item['freq'] != '' &&
          item['freq'] != 'CLOSE LINE' &&
          item['plan sam'] != '' &&
          item['plan sam'] != 'CLOSE LINE' &&
          item['act sam'] != '' &&
          item['act sam'] != 'CLOSE LINE' &&
          item['rep due'] != '' &&
          item['rep due'] != 'CLOSE LINE' &&
          item['sent rep'] != '' &&
          item['sent rep'] != 'CLOSE LINE' &&
          item['rep days'] != '' &&
          item['rep days'] != 'CLOSE LINE').length;
      AllReportPreviousYear[month] = AllReport;
    }

    List<double> SuccessReportPreviousYear = [];
    for (String month in [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ]) {
      int totalReports = AllReportPreviousYear[month] ?? 0;
      int issueReports = IssueReportPreviousYear[month] ?? 0;

      // ตรวจสอบว่า totalReports ไม่เป็น 0 เพื่อหลีกเลี่ยงการหารด้วยศูนย์
      double successReportPercent = totalReports > 0
          ? ((totalReports - issueReports) / totalReports) * 100
          : 0;
      successReportPercent =
          double.parse(successReportPercent.toStringAsFixed(1));
      SuccessReportPreviousYear.add(successReportPercent);
    }
    // print('SuccessReportPreviousYear ' + SuccessReportPreviousYear.toString());
    double AvgPreviousYear = 0;
    if (SuccessReportPreviousYear.isNotEmpty) {
      // กรองค่า 0 ออกจาก SuccessReportPreviousYear
      List<double> nonZeroReports =
          SuccessReportPreviousYear.where((percent) => percent > 0).toList();

      if (nonZeroReports.isNotEmpty) {
        double sum = nonZeroReports.reduce((a, b) => a + b);
        AvgPreviousYear = sum / nonZeroReports.length;
        // print(nonZeroReports.length); // แสดงจำนวนเดือนที่มีค่า
      }
    }

    Map<String, int> IssueReportMonths = {};
    for (String month in [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ]) {
      // นับจำนวณ Report over due ของทุกเดือน
      int IssueReport = IssueData.where((item) =>
          item['type'] == selectedType &&
          item['month'] == month &&
          item['year'] == selectedYear &&
          item['freq'] != '' &&
          item['freq'] != 'CLOSE LINE' &&
          item['plan sam'] != '' &&
          item['plan sam'] != 'CLOSE LINE' &&
          item['act sam'] != '' &&
          item['act sam'] != 'CLOSE LINE' &&
          item['rep due'] != '' &&
          item['rep due'] != 'CLOSE LINE' &&
          item['sent rep'] != '' &&
          item['sent rep'] != 'CLOSE LINE' &&
          item['rep days'] != '' &&
          item['rep days'] != 'CLOSE LINE').length;
      IssueReportMonths[month] = IssueReport;
    }

    Map<String, int> AllReportMonths = {};
    for (String month in [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ]) {
      // นับจำนวณ Report ทั้งหมดของทุกเดือน
      int AllReport = AllData.where((item) =>
          item['type'] == selectedType &&
          item['month'] == month &&
          item['year'] == selectedYear &&
          item['freq'] != '' &&
          item['freq'] != 'CLOSE LINE' &&
          item['plan sam'] != '' &&
          item['plan sam'] != 'CLOSE LINE' &&
          item['act sam'] != '' &&
          item['act sam'] != 'CLOSE LINE' &&
          item['rep due'] != '' &&
          item['rep due'] != 'CLOSE LINE' &&
          item['sent rep'] != '' &&
          item['sent rep'] != 'CLOSE LINE' &&
          item['rep days'] != '' &&
          item['rep days'] != 'CLOSE LINE').length;
      AllReportMonths[month] = AllReport;
    }

    List<double> SuccessReportMonths = [];
    SuccessReportMonths.add(AvgPreviousYear);
    for (String month in [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ]) {
      int totalReports = AllReportMonths[month] ?? 0;
      int issueReports = IssueReportMonths[month] ?? 0;
      // print('totalReports($month): $totalReports');
      // print('issueReports($month): $issueReports');
      // ตรวจสอบว่า totalReports ไม่เป็น 0 เพื่อหลีกเลี่ยงการหารด้วยศูนย์
      double successReportPercent = totalReports > 0
          ? ((totalReports - issueReports) / totalReports) * 100
          : 0;
      successReportPercent =
          double.parse(successReportPercent.toStringAsFixed(1));
      SuccessReportMonths.add(successReportPercent);
    }

    // print('SuccessReportMonths: $SuccessReportMonths');

    List<Map<String, String>> newData = [];
    for (var data in filteredData1) {
      if (data.REPDAYS1.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          P07ASSEMBLEGRAPHVAR.extractYear(data.REPDUE1) == selectedYear &&
          P07ASSEMBLEGRAPHVAR.extractMonth(data.REPDUE1) == selectedMonth &&
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
          P07ASSEMBLEGRAPHVAR.extractYear(data.REPDUE2) == selectedYear &&
          P07ASSEMBLEGRAPHVAR.extractMonth(data.REPDUE2) == selectedMonth &&
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
          P07ASSEMBLEGRAPHVAR.extractYear(data.REPDUE3) == selectedYear &&
          P07ASSEMBLEGRAPHVAR.extractMonth(data.REPDUE3) == selectedMonth &&
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
          P07ASSEMBLEGRAPHVAR.extractYear(data.REPDUE4) == selectedYear &&
          P07ASSEMBLEGRAPHVAR.extractMonth(data.REPDUE4) == selectedMonth &&
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                      colors: const [Colors.blueAccent, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'SAR : Export 3 graph',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      if (P07ASSEMBLEGRAPHVAR.DropDownType.isNotEmpty ||
                          P07ASSEMBLEGRAPHVAR.DropDownYear.isNotEmpty ||
                          P07ASSEMBLEGRAPHVAR.DropDownMonth.isNotEmpty)
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
                            P07ASSEMBLEGRAPHVAR.DropDownType = d;
                            // context
                            //     .read<P07ASSEMBLEGRAPHGETDATA_Bloc>()
                            //     .add(P07ASSEMBLEGRAPHGETDATA_GET());
                          });
                        },
                        value: P07ASSEMBLEGRAPHVAR.DropDownType,
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
                      if (P07ASSEMBLEGRAPHVAR.DropDownType.isNotEmpty ||
                          P07ASSEMBLEGRAPHVAR.DropDownYear.isNotEmpty ||
                          P07ASSEMBLEGRAPHVAR.DropDownMonth.isNotEmpty)
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
                            P07ASSEMBLEGRAPHVAR.DropDownYear = d;
                            // context
                            //     .read<P07ASSEMBLEGRAPHGETDATA_Bloc>()
                            //     .add(P07ASSEMBLEGRAPHGETDATA_GET());
                          });
                        },
                        value: P07ASSEMBLEGRAPHVAR.DropDownYear,
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
                      if (P07ASSEMBLEGRAPHVAR.DropDownType.isNotEmpty ||
                          P07ASSEMBLEGRAPHVAR.DropDownYear.isNotEmpty ||
                          P07ASSEMBLEGRAPHVAR.DropDownMonth.isNotEmpty)
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
                            P07ASSEMBLEGRAPHVAR.DropDownMonth = d;
                            // context
                            //     .read<P07ASSEMBLEGRAPHGETDATA_Bloc>()
                            //     .add(P07ASSEMBLEGRAPHGETDATA_GET());
                          });
                        },
                        value: P07ASSEMBLEGRAPHVAR.DropDownMonth,
                        height: 30,
                        width: 100,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FreeLoadingTan(P07ASSEMBLEGRAPHMAINcontext);
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        captureDefault(
                          _globalKey,
                          "ReportPDFCommonvar",
                        ).then((value) {
                          // print(value);
                          Navigator.pop(P07ASSEMBLEGRAPHMAINcontext);
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // กำหนดสีพื้นหลังของปุ่ม
                    ),
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
                        'Export to PDF',
                        style: TextStyle(
                          color: Colors.white, // กำหนดสีตัวหนังสือให้ชัดเจน
                        ),
                      ),
                    ),
                  )
                ],
              ),
              RepaintBoundary(
                key: _globalKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 566,
                      width: 765,
                      child: Scrollbar(
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
                                  Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              'Group $selectedType\n'
                                              '$GroupTargetDays ($selectedMonthMMM $selectedYear)',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          SizedBox(
                                            width: 750,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Positioned(
                                                  top: 100,
                                                  left: 335,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Text(
                                                      'Total : $AllReport Iss.',
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    PieChart(
                                                      dataMap: pieData1,
                                                      chartRadius: 200,
                                                      colorList: [
                                                        Colors.lightGreen,
                                                        Colors.yellow.shade200
                                                      ],
                                                      chartValuesOptions:
                                                          ChartValuesOptions(
                                                        showChartValueBackground:
                                                            true,
                                                        chartValueBackgroundColor:
                                                            Colors.white,
                                                        showChartValues: true,
                                                        chartValueStyle:
                                                            TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      legendOptions:
                                                          LegendOptions(
                                                        legendPosition:
                                                            LegendPosition
                                                                .bottom,
                                                        showLegendsInRow: true,
                                                        legendTextStyle:
                                                            TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      chartType: ChartType.disc,
                                                      baseChartColor:
                                                          Colors.grey[300]!,
                                                      centerTextStyle:
                                                          TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      initialAngleInDegree:
                                                          initialAngleInDegree,
                                                    ),
                                                    PieChart(
                                                        dataMap: P07ASSEMBLEGRAPHVAR
                                                                    .DropDownType ==
                                                                'B'
                                                            ? pieData3
                                                            : P07ASSEMBLEGRAPHVAR.DropDownType ==
                                                                    'A'
                                                                ? pieData2
                                                                : {},
                                                        chartRadius: 150,
                                                        colorList: [
                                                          Colors
                                                              .yellow.shade200,
                                                          Colors.red
                                                        ],
                                                        chartValuesOptions:
                                                            ChartValuesOptions(
                                                          showChartValueBackground:
                                                              true,
                                                          chartValueBackgroundColor:
                                                              Colors.white,
                                                          showChartValues: true,
                                                          chartValueStyle:
                                                              TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        legendOptions:
                                                            LegendOptions(
                                                          legendPosition:
                                                              LegendPosition
                                                                  .bottom,
                                                          showLegendsInRow:
                                                              true,
                                                          legendTextStyle:
                                                              TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        chartType:
                                                            ChartType.disc,
                                                        baseChartColor:
                                                            Colors.grey[300]!,
                                                        centerTextStyle:
                                                            TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        initialAngleInDegree: P07ASSEMBLEGRAPHVAR
                                                                    .DropDownType ==
                                                                'B'
                                                            ? initialAngleInDegree1113
                                                            : P07ASSEMBLEGRAPHVAR
                                                                        .DropDownType ==
                                                                    'A'
                                                                ? initialAngleInDegree1315
                                                                : 0.0),
                                                  ],
                                                ),
                                                CustomPaint(
                                                  size: Size(600,
                                                      300), // กำหนดขนาดของพื้นที่วาด
                                                  painter:
                                                      LinePainter(), // ใช้ CustomPainter ที่สร้างขึ้น
                                                ),
                                              ],
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
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 280.5,
                          width: 765,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Scrollbar(
                            controller: _controllerIN03,
                            thumbVisibility: true,
                            interactive: true,
                            thickness: 10,
                            radius: Radius.circular(20),
                            child: Center(
                              child: SingleChildScrollView(
                                controller: _controllerIN03,
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 20,
                                        left: 300,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 5,
                                              color: Colors.yellow.shade600,
                                            ),
                                            Text(
                                              ' Target Days',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Container(
                                              height: 5,
                                              width: 5,
                                              color: Colors.blue.shade900,
                                            ),
                                            Text(
                                              ' Actual Days',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 2,
                                        left: 180,
                                        child: Text(
                                          'Report Over KPI: Customer $selectedType (Target ≤ $typeValue days) ($selectedMonthMMM $selectedYear)',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(height: 8),
                                          SizedBox(
                                            height: 270,
                                            width: 760,
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: CustomBarChart1(
                                                    GroupTargetDays1:
                                                        GroupTargetDays1,
                                                    avgAllBreakdown:
                                                        avgAllBreakdown,
                                                    maxY: 20,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 130,
                                                  left: -40,
                                                  child: Transform.rotate(
                                                    angle:
                                                        -90 * (3.14159 / 180),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        groupSampleTime,
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Positioned(
                              top: 60,
                              right: 5,
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back_rounded,
                                      size: 12, color: Colors.blue.shade900),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue.shade900,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Target 100%',
                                        style: TextStyle(
                                          fontSize: 8.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 280.5,
                              width: 765,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Scrollbar(
                                controller: _controllerIN02,
                                thumbVisibility: true,
                                interactive: true,
                                thickness: 10,
                                radius: Radius.circular(20),
                                child: Center(
                                  child: SingleChildScrollView(
                                    controller: _controllerIN02,
                                    scrollDirection: Axis.horizontal,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5),
                                          Center(
                                            child: Text(
                                              '% Achieved Customer Group $selectedType (Yr.$selectedYear)',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          CustomBarChart(
                                            SuccessReportMonths:
                                                SuccessReportMonths,
                                            maxY: 100,
                                          ),
                                        ],
                                      ),
                                    ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // สีเส้น
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    // จุดเริ่มต้นและสิ้นสุดของเส้น
    final startPoint = Offset(127, 13);
    final endPoint = Offset(459, 38);

    // วาดเส้น
    canvas.drawLine(startPoint, endPoint, paint);

    // วาดเส้นที่สอง
    final startPoint2 = Offset(127, 215);
    final endPoint2 = Offset(459, 190);

    // วาดเส้นที่สอง
    canvas.drawLine(startPoint2, endPoint2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // ไม่ต้อง repaint ถ้าไม่มีอะไรเปลี่ยนแปลง
  }
}

// คลาสสำหรับสร้างกราฟ
class CustomBarChart extends StatelessWidget {
  final List<double> SuccessReportMonths;
  final double maxY;

  const CustomBarChart({
    super.key,
    required this.SuccessReportMonths,
    required this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 600,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomPaint(
        painter: BarChartPainter(
          SuccessReportMonths: SuccessReportMonths,
          maxY: maxY,
        ),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<double> SuccessReportMonths;
  final double maxY;
  final selectedYear = (P07ASSEMBLEGRAPHVAR.DropDownYear.isNotEmpty)
      ? P07ASSEMBLEGRAPHVAR.DropDownYear
      : P07ASSEMBLEGRAPHVAR.currentYear;

  BarChartPainter({
    required this.SuccessReportMonths,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // สีของแท่งกราฟ KAC
    final paintKAC = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // เส้นประ
    final paintDashed1 = Paint()
      ..color = Colors.blue.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // ตำแหน่งความสูงของเส้นประ
    double ySetpoint100 = size.height - (100 / maxY) * size.height;

    // วาดเส้นประ
    drawDashedLine(canvas, paintDashed1, Offset(0, ySetpoint100),
        Offset(size.width + 30, ySetpoint100));

    final barWidth = (size.width / (SuccessReportMonths.length * 2)) *
        0.7; // ความกว้างของแท่ง
    const spaceBetweenBars = 5.0; // ระยะห่างระหว่างแท่งที่ชิดกัน
    const spaceBetweenMonths = 10.0; // ระยะห่างระหว่างเดือน
    const startXOffset = 20.0; // จุดเริ่มต้นของกราฟแท่ง

    for (int i = 0; i < SuccessReportMonths.length; i++) {
      // คำนวณตำแหน่งของแท่งกราฟ KAC
      final leftKAC = startXOffset +
          i * (barWidth * 2 + spaceBetweenBars) +
          (i * spaceBetweenMonths);
      // คำนวณความสูงของแท่งกราฟ KAC
      final topKAC =
          size.height - (SuccessReportMonths[i] / maxY) * size.height;
      // สร้างสี่เหลี่ยมพื้นผ้าของ KAC (ตำแหน่งแกน X, ตำแหน่งแกน Y, ความกว้าง, ความสูง)
      final rectKAC =
          Rect.fromLTWH(leftKAC, topKAC, barWidth, size.height - topKAC);

      // วาดแท่งกราฟ KAC
      canvas.drawRect(rectKAC, paintKAC);

      // วาดตัวเลขบนแท่งกราฟ KAC
      String kacText = '';

      if (SuccessReportMonths[i] != 0) {
        kacText = SuccessReportMonths[i].toStringAsFixed(1);

        // ตรวจสอบว่าหมายเลขเป็นจำนวนเต็มหรือไม่
        if (SuccessReportMonths[i] % 1 == 0) {
          kacText = SuccessReportMonths[i].toInt().toString();
        }
      }

      // ตรวจสอบว่า kacText มีค่าหรือไม่
      if (kacText.isNotEmpty) {
        // สร้าง TextPainter สำหรับ KAC
        final textPainterKAC = TextPainter(
          text: TextSpan(
            text: kacText,
            style: TextStyle(color: Colors.black, fontSize: 7),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainterKAC.layout();
        // หาตำแหน่งแกน X ของค่า KAC
        final textXPositionKAC =
            leftKAC + (barWidth / 2) - (textPainterKAC.width / 2);
        // หาตำแหน่งแกน Y ของค่า KAC
        final textYPositionKAC = topKAC - 15;
        // วาดตัวเลขบนแท่งกราฟ KAC (แกน X, แกน Y)
        textPainterKAC.paint(
            canvas, Offset(textXPositionKAC, textYPositionKAC));
      }
    }

    // กำหนดสี ,ความหนาของเส้นแกน X และ Y
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // เส้นแกน Y
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);

    // เส้นแกน X
    canvas.drawLine(Offset(0, size.height),
        Offset(size.width + 30, size.height), axisPaint);

    // วาดตัวเลขบนแกน Y
    final textStyle = TextStyle(color: Colors.black, fontSize: 10);
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i <= maxY; i += 50) {
      textPainter.text = TextSpan(
        text: '$i',
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-20, size.height - (i / maxY) * size.height - 6));
    }

    // วาดชื่อเดือนบนแกน X
    for (int i = 0; i < SuccessReportMonths.length; i++) {
      String monthText;

      // ตรวจสอบว่าเป็นชื่อแรก (Avg)
      if (i == 0) {
        // ถ้าเป็นเดือนแรกให้ใช้ "Avg" และลบปีไป 1
        monthText =
            '${P07ASSEMBLEGRAPHVAR.months[i]} ${(int.parse(selectedYear) - 1).toString().substring(2)}';
      } else {
        // เดือนอื่นๆ ใช้ชื่อเดือนตามปกติ
        monthText =
            '${P07ASSEMBLEGRAPHVAR.months[i]} ${selectedYear.toString().substring(2)}';
      }

      textPainter.text = TextSpan(
        text: monthText,
        style: textStyle,
      );

      textPainter.layout();

      // คำนวณตำแหน่งกลางระหว่างแท่ง KAC และ Medium พร้อมเลื่อนตำแหน่งจากแกน Y ด้วย startXOffset
      final xPosition = startXOffset +
          i * (barWidth * 2 + spaceBetweenBars + spaceBetweenMonths) +
          barWidth - // ปรับตำแหน่งให้ตรงกลางระหว่างแท่ง KAC และช่องว่าง
          (textPainter.width / 2) -
          10; // ให้อยู่กลางแท่งกราฟ

      textPainter.paint(canvas, Offset(xPosition, size.height + 5));
    }
  }

// ฟังก์ชั่นสำหรับวาดเส้นแกน X และ Y
  void drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;

    double distance = (end - start).distance;
    double dashCount = distance / (dashWidth + dashSpace);

    for (int i = 0; i < dashCount.floor(); i++) {
      double startX = start.dx + (i * (dashWidth + dashSpace));
      double endX = startX + dashWidth;
      canvas.drawLine(
        Offset(startX, start.dy),
        Offset(endX, start.dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // รีเพนท์ทุกครั้งเมื่อมีการเปลี่ยนแปลงข้อมูล
  }
}

class CustomBarChart1 extends StatelessWidget {
  final List<double> GroupTargetDays1;
  final List<double> avgAllBreakdown;
  final double maxY;

  const CustomBarChart1({
    super.key,
    required this.GroupTargetDays1,
    required this.avgAllBreakdown,
    required this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 600,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomPaint(
        painter: BarChartPainter1(
          GroupTargetDays1: GroupTargetDays1,
          avgAllBreakdown: avgAllBreakdown,
          maxY: maxY,
        ),
      ),
    );
  }
}

class BarChartPainter1 extends CustomPainter {
  final List<double> GroupTargetDays1;
  final List<double> avgAllBreakdown;
  final double maxY;
  final selectedYear = (P07ASSEMBLEGRAPHVAR.DropDownYear.isNotEmpty)
      ? P07ASSEMBLEGRAPHVAR.DropDownYear
      : P07ASSEMBLEGRAPHVAR.currentYear;

  BarChartPainter1({
    required this.GroupTargetDays1,
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

    final barHeight = (size.height / (GroupTargetDays1.length * 2)) *
        0.3; // ความสูงของแท่ง,ความกว้างของแท่ง
    const spaceBetweenBars = 5.0; // ระยะห่างระหว่างแท่งที่ชิดกัน
    const spaceBetweenMonths = 10; // ระยะห่างระหว่างเดือน
    const startYOffset = 0.0; // จุดเริ่มต้นของกราฟแท่ง

    // วาดเส้นไกด์แนวตั้งบนแกน X
    for (int i = 0; i <= maxY; i += 2) {
      final xPosition = (i / maxY) * size.width;
      canvas.drawLine(
          Offset(xPosition, 0), Offset(xPosition, size.height), guideLinePaint);
    }

    // เริ่ม Loop สำหรับสร้างแท่งกราฟ
    for (int i = 0; i < GroupTargetDays1.length; i++) {
      if (i >= avgAllBreakdown.length) {
        // หยุดการทำงานถ้าข้อมูลไม่เพียงพอ
        break;
      }
      // คำนวณตำแหน่งของแท่งกราฟ Target
      final topTarget = startYOffset +
          i * (barHeight * 2 + spaceBetweenBars) +
          (i * spaceBetweenMonths);
      // คำนวณความกว้างของแท่งกราฟ Target
      final rightTarget = (GroupTargetDays1[i] / maxY) * size.width;
      // สร้างสี่เหลี่ยมพื้นผ้าของ Target (ตำแหน่งแกน X, ตำแหน่งแกน Y, ความกว้าง, ความสูง)
      final rectTarget = Rect.fromLTWH(0, topTarget, rightTarget, barHeight);

      // ตรวจสอบว่าเป็นแท่งแรกหรือไม่
      final paintTarget = (i == 0) ? paintFirstTarget : paintNextTarget;

      // วาดแท่งกราฟ Target
      canvas.drawRect(rectTarget, paintTarget);

      // วาดตัวเลขบนแท่งกราฟ Target
      String TargetText = '';

      if (GroupTargetDays1[i] != 0) {
        TargetText = GroupTargetDays1[i].toStringAsFixed(2);

        // ตรวจสอบว่าหมายเลขเป็นจำนวนเต็มหรือไม่
        if (GroupTargetDays1[i] % 1 == 0) {
          TargetText = GroupTargetDays1[i].toInt().toString();
        }
      }

      // ตรวจสอบว่า TargetText มีค่าหรือไม่
      if (TargetText.isNotEmpty) {
        // สร้าง TextPainter สำหรับ Target
        final textPainterTarget = TextPainter(
          text: TextSpan(
            text: TargetText,
            style: TextStyle(color: Colors.black, fontSize: 6),
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
            style: TextStyle(color: Colors.black, fontSize: 6),
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
    final textStyle = TextStyle(color: Colors.black, fontSize: 6);
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
    for (int i = 0; i < GroupTargetDays1.length; i++) {
      String monthText;

      monthText = P07ASSEMBLEGRAPHVAR.breakdown[i];

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
