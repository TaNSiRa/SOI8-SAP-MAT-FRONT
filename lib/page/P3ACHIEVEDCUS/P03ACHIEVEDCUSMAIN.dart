// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/03-01-P03ACHIEVEDCUSGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import '../P3ACHIEVEDCUS/P03ACHIEVEDCUSVAR.dart';

late BuildContext P03ACHIEVEDCUSMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P03ACHIEVEDCUSMAIN extends StatefulWidget {
  P03ACHIEVEDCUSMAIN({
    super.key,
    this.data,
  });
  List<P03ACHIEVEDCUSGETDATAclass>? data;

  @override
  State<P03ACHIEVEDCUSMAIN> createState() => _P03ACHIEVEDCUSMAINState();
}

class _P03ACHIEVEDCUSMAINState extends State<P03ACHIEVEDCUSMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P03ACHIEVEDCUSGETDATA_Bloc>().add(P03ACHIEVEDCUSGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P03ACHIEVEDCUSMAINcontext = context;
    List<P03ACHIEVEDCUSGETDATAclass> _datain = widget.data ?? [];

    // ตัวแปรสําหรับใช้กับ Dropdown
    final selectedType = (P03ACHIEVEDCUSVAR.DropDownType.isNotEmpty)
        ? P03ACHIEVEDCUSVAR.DropDownType
        : 'Group A';
    final selectedYear = (P03ACHIEVEDCUSVAR.DropDownYear.isNotEmpty)
        ? P03ACHIEVEDCUSVAR.DropDownYear
        : P03ACHIEVEDCUSVAR.currentYear;

    // กรองข้อมูลด้วยปีและเดือน
    List<P03ACHIEVEDCUSGETDATAclass> filteredData = _datain.where((data) {
      return data.TYPE == selectedType && data.YEAR == selectedYear;
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

//แยกข้อมูล week 1-4
    List<Map<String, String>> IssueDataPreviousYear = [];
    for (var data in _datain) {
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
    for (var data in _datain) {
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

    Map<String, int> IssueReportPreviousYear = {};
    for (String month in [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]) {
      // นับจำนวณ Report over due ของทุกเดือน
      int IssueReport = IssueDataPreviousYear.where((item) =>
          item['type'] == selectedType &&
          item['month'] == month &&
          item['year'] == '${int.parse(selectedYear) - 1}').length;
      IssueReportPreviousYear[month] = IssueReport;
    }

    Map<String, int> AllReportPreviousYear = {};
    for (String month in [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]) {
      // นับจำนวณ Report ทั้งหมดของทุกเดือน
      int AllReport = AllDataPreviousYear.where((item) =>
          item['type'] == selectedType &&
          item['month'] == month &&
          item['year'] == '${int.parse(selectedYear) - 1}').length;
      AllReportPreviousYear[month] = AllReport;
    }

    List<double> SuccessReportPreviousYear = [];
    for (String month in [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
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

    double AvgPreviousYear = 0;
    if (SuccessReportPreviousYear.isNotEmpty) {
      double sum = SuccessReportPreviousYear.reduce((a, b) => a + b);
      AvgPreviousYear = sum / SuccessReportPreviousYear.length;
    }

    Map<String, int> IssueReportMonths = {};
    for (String month in [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]) {
      // นับจำนวณ Report over due ของทุกเดือน
      int IssueReport = IssueData.where((item) =>
          item['type'] == selectedType &&
          item['month'] == month &&
          item['year'] == selectedYear).length;
      IssueReportMonths[month] = IssueReport;
    }

    Map<String, int> AllReportMonths = {};
    for (String month in [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]) {
      // นับจำนวณ Report ทั้งหมดของทุกเดือน
      int AllReport = AllData.where((item) =>
          item['type'] == selectedType &&
          item['month'] == month &&
          item['year'] == selectedYear &&
          item['freq'] != '' &&
          item['plan sam'] != '' &&
          item['act sam'] != '' &&
          item['rep due'] != '' &&
          item['sent rep'] != '' &&
          item['rep days'] != '').length;
      AllReportMonths[month] = AllReport;
    }

    List<double> SuccessReportMonths = [];
    SuccessReportMonths.add(AvgPreviousYear);
    for (String month in [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]) {
      int totalReports = AllReportMonths[month] ?? 0;
      int issueReports = IssueReportMonths[month] ?? 0;

      // ตรวจสอบว่า totalReports ไม่เป็น 0 เพื่อหลีกเลี่ยงการหารด้วยศูนย์
      double successReportPercent = totalReports > 0
          ? ((totalReports - issueReports) / totalReports) * 100
          : 0;
      successReportPercent =
          double.parse(successReportPercent.toStringAsFixed(1));
      SuccessReportMonths.add(successReportPercent);
    }

    return Scrollbar(
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
                    '% Achieved Customer $selectedType (Yr.$selectedYear)',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 380,
                  width: 1100,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: CustomBarChart(
                              SuccessReportMonths: SuccessReportMonths,
                              maxY: 140,
                            ),
                          ),
                          Positioned(
                            top: 93,
                            right: 0,
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back_rounded,
                                    size: 20, color: Colors.blue.shade900),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
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
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 180,
                        left: 30,
                        child: Transform.rotate(
                          angle: -90 * (3.14159 / 180),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '% Achieved Customer $selectedType',
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
                          children: [
                            Column(
                              children: [
                                if (P03ACHIEVEDCUSVAR.DropDownType.isNotEmpty ||
                                    P03ACHIEVEDCUSVAR.DropDownYear.isNotEmpty)
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
                                      P03ACHIEVEDCUSVAR.DropDownType = d;
                                    });
                                  },
                                  value: P03ACHIEVEDCUSVAR.DropDownType,
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
                                if (P03ACHIEVEDCUSVAR.DropDownType.isNotEmpty ||
                                    P03ACHIEVEDCUSVAR
                                        .DropDownYear.isNotEmpty) ...[
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'YEAR',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
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
                                      P03ACHIEVEDCUSVAR.DropDownYear = d;
                                    });
                                  },
                                  value: P03ACHIEVEDCUSVAR.DropDownYear,
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
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
      height: 380,
      width: 800,
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
  final selectedYear = (P03ACHIEVEDCUSVAR.DropDownYear.isNotEmpty)
      ? P03ACHIEVEDCUSVAR.DropDownYear
      : P03ACHIEVEDCUSVAR.currentYear;

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
    const spaceBetweenMonths = 15.0; // ระยะห่างระหว่างเดือน
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

    for (int i = 0; i <= maxY; i += 10) {
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
            '${P03ACHIEVEDCUSVAR.months[i]} ${(int.parse(selectedYear) - 1).toString().substring(2)}';
      } else {
        // เดือนอื่นๆ ใช้ชื่อเดือนตามปกติ
        monthText =
            '${P03ACHIEVEDCUSVAR.months[i]} ${selectedYear.toString().substring(2)}';
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
