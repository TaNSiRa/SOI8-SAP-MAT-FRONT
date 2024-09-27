import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dummydata2.dart';
import '../../page/P3ACHIEVEDCUS/P03ACHIEVEDCUSMAIN.dart';
import '../../widget/common/Loading.dart';

//-------------------------------------------------

abstract class P03ACHIEVEDCUSGETDATA_Event {}

class P03ACHIEVEDCUSGETDATA_GET extends P03ACHIEVEDCUSGETDATA_Event {}

class P03ACHIEVEDCUSGETDATA_GET2 extends P03ACHIEVEDCUSGETDATA_Event {}

class P03ACHIEVEDCUSGETDATA_GET3 extends P03ACHIEVEDCUSGETDATA_Event {}

class P03ACHIEVEDCUSGETDATA_FLUSH extends P03ACHIEVEDCUSGETDATA_Event {}

class P03ACHIEVEDCUSGETDATA_Bloc extends Bloc<P03ACHIEVEDCUSGETDATA_Event,
    List<P03ACHIEVEDCUSGETDATAclass>> {
  P03ACHIEVEDCUSGETDATA_Bloc() : super([]) {
    on<P03ACHIEVEDCUSGETDATA_GET>((event, emit) {
      return _P03ACHIEVEDCUSGETDATA_GET([], emit);
    });

    on<P03ACHIEVEDCUSGETDATA_GET2>((event, emit) {
      return _P03ACHIEVEDCUSGETDATA_GET2([], emit);
    });
    on<P03ACHIEVEDCUSGETDATA_GET3>((event, emit) {
      return _P03ACHIEVEDCUSGETDATA_GET3([], emit);
    });
    on<P03ACHIEVEDCUSGETDATA_FLUSH>((event, emit) {
      return _P03ACHIEVEDCUSGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P03ACHIEVEDCUSGETDATA_GET(
      List<P03ACHIEVEDCUSGETDATAclass> toAdd,
      Emitter<List<P03ACHIEVEDCUSGETDATAclass>> emit) async {
    FreeLoadingTan(P03ACHIEVEDCUSMAINcontext);
    List<P03ACHIEVEDCUSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    var input = dummydatainput6;

    List<P03ACHIEVEDCUSGETDATAclass> outputdata = input.map((data) {
      return P03ACHIEVEDCUSGETDATAclass(
        TYPE: savenull(data['type']),
        MKTGROUP: savenull(data['mktgroup']),
        GROUP: savenull(data['group']),
        CUSTOMER: savenull(data['customer']),
        FREQUENCY: savenull(data['frequency']),
        INCHARGE: savenull(data['incharge']),
        KPISERV: savenull(data['kpi serv']),
        KPIPERIOD: savenull(data['kpi period']),
        REPITEM: savenull(data['repitems']),
        MONTH: savenull(data['month']),
        YEAR: savenull(data['year']),
        FREQ1: savenull(data['freq1']),
        PLANSAM1: savenull(data['plan sam1']),
        ACTSAM1: savenull(data['act sam1']),
        REPDUE1: savenull(data['rep due1']),
        SENTREP1: savenull(data['sent rep1']),
        REPDAYS1: savenull(data['rep days1']),
        REQUEST1: savenull(data['request1']),
        TTCRESULT1: savenull(data['ttcresult1']),
        ISSUEDATE1: savenull(data['issuedate1']),
        REVISE1: savenull(data['revise1']),
        SUBLEAD1: savenull(data['sublead1']),
        GL1: savenull(data['gl1']),
        MGR1: savenull(data['mgr1']),
        JP1: savenull(data['jp1']),
        BDPREPARE1: savenull(data['bdprepare1']),
        BDTTC1: savenull(data['bdttc1']),
        BDISSUE1: savenull(data['bdissue1']),
        BDREVISE1: savenull(data['bdrevise1']),
        BDSUBLEAD1: savenull(data['bdsublead1']),
        BDGL1: savenull(data['bdgl1']),
        BDMGR1: savenull(data['bdmgr1']),
        BDJP1: savenull(data['bdjp1']),
        BDSENT1: savenull(data['bdsent1']),
        REASON1: savenull(data['reason1']),
        ACTION1: savenull(data['action1']),
        FREQ2: savenull(data['freq2']),
        PLANSAM2: savenull(data['plan sam2']),
        ACTSAM2: savenull(data['act sam2']),
        REPDUE2: savenull(data['rep due2']),
        SENTREP2: savenull(data['sent rep2']),
        REPDAYS2: savenull(data['rep days2']),
        REQUEST2: savenull(data['request2']),
        TTCRESULT2: savenull(data['ttcresult2']),
        ISSUEDATE2: savenull(data['issuedate2']),
        REVISE2: savenull(data['revise2']),
        SUBLEAD2: savenull(data['sublead2']),
        GL2: savenull(data['gl2']),
        MGR2: savenull(data['mgr2']),
        JP2: savenull(data['jp2']),
        BDPREPARE2: savenull(data['bdprepare2']),
        BDTTC2: savenull(data['bdttc2']),
        BDISSUE2: savenull(data['bdissue2']),
        BDREVISE2: savenull(data['bdrevise2']),
        BDSUBLEAD2: savenull(data['bdsublead2']),
        BDGL2: savenull(data['bdgl2']),
        BDMGR2: savenull(data['bdmgr2']),
        BDJP2: savenull(data['bdjp2']),
        BDSENT2: savenull(data['bdsent2']),
        REASON2: savenull(data['reason2']),
        ACTION2: savenull(data['action2']),
        FREQ3: savenull(data['freq3']),
        PLANSAM3: savenull(data['plan sam3']),
        ACTSAM3: savenull(data['act sam3']),
        REPDUE3: savenull(data['rep due3']),
        SENTREP3: savenull(data['sent rep3']),
        REPDAYS3: savenull(data['rep days3']),
        REQUEST3: savenull(data['request3']),
        TTCRESULT3: savenull(data['ttcresult3']),
        ISSUEDATE3: savenull(data['issuedate3']),
        REVISE3: savenull(data['revise3']),
        SUBLEAD3: savenull(data['sublead3']),
        GL3: savenull(data['gl3']),
        MGR3: savenull(data['mgr3']),
        JP3: savenull(data['jp3']),
        BDPREPARE3: savenull(data['bdprepare3']),
        BDTTC3: savenull(data['bdttc3']),
        BDISSUE3: savenull(data['bdissue3']),
        BDREVISE3: savenull(data['bdrevise3']),
        BDSUBLEAD3: savenull(data['bdsublead3']),
        BDGL3: savenull(data['bdgl3']),
        BDMGR3: savenull(data['bdmgr3']),
        BDJP3: savenull(data['bdjp3']),
        BDSENT3: savenull(data['bdsent3']),
        REASON3: savenull(data['reason3']),
        ACTION3: savenull(data['action3']),
        FREQ4: savenull(data['freq4']),
        PLANSAM4: savenull(data['plan sam4']),
        ACTSAM4: savenull(data['act sam4']),
        REPDUE4: savenull(data['rep due4']),
        SENTREP4: savenull(data['sent rep4']),
        REPDAYS4: savenull(data['rep days4']),
        REQUEST4: savenull(data['request4']),
        TTCRESULT4: savenull(data['ttcresult4']),
        ISSUEDATE4: savenull(data['issuedate4']),
        REVISE4: savenull(data['revise4']),
        SUBLEAD4: savenull(data['sublead4']),
        GL4: savenull(data['gl4']),
        MGR4: savenull(data['mgr4']),
        JP4: savenull(data['jp4']),
        BDPREPARE4: savenull(data['bdprepare4']),
        BDTTC4: savenull(data['bdttc4']),
        BDISSUE4: savenull(data['bdissue4']),
        BDREVISE4: savenull(data['bdrevise4']),
        BDSUBLEAD4: savenull(data['bdsublead4']),
        BDGL4: savenull(data['bdgl4']),
        BDMGR4: savenull(data['bdmgr4']),
        BDJP4: savenull(data['bdjp4']),
        BDSENT4: savenull(data['bdsent4']),
        REASON4: savenull(data['reason4']),
        ACTION4: savenull(data['action4']),
      );
    }).toList();
    // print(outputdata);
    Navigator.pop(P03ACHIEVEDCUSMAINcontext);
    output = outputdata;
    emit(output);
  }

  Future<void> _P03ACHIEVEDCUSGETDATA_GET2(
      List<P03ACHIEVEDCUSGETDATAclass> toAdd,
      Emitter<List<P03ACHIEVEDCUSGETDATAclass>> emit) async {
    // List<P03ACHIEVEDCUSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P03ACHIEVEDCUSGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P03ACHIEVEDCUSGETDATAclass(
    //     PLANT: savenull(data['plant']),
    //     ORDER: savenull(data['order']),
    //     MAT: savenull(data['mat']),
    //     LOCATION: savenull(data['location']),
    //     LOT: savenull(data['lot']),
    //     CUSTOMER: savenull(data['customer']),
    //     PARTNO: savenull(data['partno']),
    //     PARTNAME: savenull(data['partname']),
    //     STEP01: savenull(data['step1']),
    //     STEP02: savenull(data['step2']),
    //     STEP03: savenull(data['step3']),
    //     STEP04: savenull(data['step4']),
    //     STEP05: savenull(data['step5']),
    //     STEP06: savenull(data['step6']),
    //     STEP07: savenull(data['step7']),
    //     STEP08: savenull(data['step8']),
    //     STEP09: savenull(data['step9']),
    //   );
    // }).toList();

    // output = outputdata;
    // emit(output);
  }

  Future<void> _P03ACHIEVEDCUSGETDATA_GET3(
      List<P03ACHIEVEDCUSGETDATAclass> toAdd,
      Emitter<List<P03ACHIEVEDCUSGETDATAclass>> emit) async {
    // List<P03ACHIEVEDCUSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P03ACHIEVEDCUSGETDATAclass> datadummy = [
    //   P03ACHIEVEDCUSGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P03ACHIEVEDCUSGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P03ACHIEVEDCUSGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P03ACHIEVEDCUSGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P03ACHIEVEDCUSGETDATA_FLUSH(
      List<P03ACHIEVEDCUSGETDATAclass> toAdd,
      Emitter<List<P03ACHIEVEDCUSGETDATAclass>> emit) async {
    List<P03ACHIEVEDCUSGETDATAclass> output = [];
    emit(output);
  }
}

class P03ACHIEVEDCUSGETDATAclass {
  P03ACHIEVEDCUSGETDATAclass({
    this.TYPE = '',
    this.MKTGROUP = '',
    this.GROUP = '',
    this.CUSTOMER = '',
    this.FREQUENCY = '',
    this.INCHARGE = '',
    this.KPISERV = '',
    this.KPIPERIOD = '',
    this.REPITEM = '',
    this.MONTH = '',
    this.YEAR = '',
    this.FREQ1 = '',
    this.PLANSAM1 = '',
    this.ACTSAM1 = '',
    this.REPDUE1 = '',
    this.SENTREP1 = '',
    this.REPDAYS1 = '',
    this.REQUEST1 = '',
    this.TTCRESULT1 = '',
    this.ISSUEDATE1 = '',
    this.REVISE1 = '',
    this.SUBLEAD1 = '',
    this.GL1 = '',
    this.MGR1 = '',
    this.JP1 = '',
    this.BDPREPARE1 = '',
    this.BDTTC1 = '',
    this.BDISSUE1 = '',
    this.BDREVISE1 = '',
    this.BDSUBLEAD1 = '',
    this.BDGL1 = '',
    this.BDMGR1 = '',
    this.BDJP1 = '',
    this.BDSENT1 = '',
    this.REASON1 = '',
    this.ACTION1 = '',
    this.FREQ2 = '',
    this.PLANSAM2 = '',
    this.ACTSAM2 = '',
    this.REPDUE2 = '',
    this.SENTREP2 = '',
    this.REPDAYS2 = '',
    this.REQUEST2 = '',
    this.TTCRESULT2 = '',
    this.ISSUEDATE2 = '',
    this.REVISE2 = '',
    this.SUBLEAD2 = '',
    this.GL2 = '',
    this.MGR2 = '',
    this.JP2 = '',
    this.BDPREPARE2 = '',
    this.BDTTC2 = '',
    this.BDISSUE2 = '',
    this.BDREVISE2 = '',
    this.BDSUBLEAD2 = '',
    this.BDGL2 = '',
    this.BDMGR2 = '',
    this.BDJP2 = '',
    this.BDSENT2 = '',
    this.REASON2 = '',
    this.ACTION2 = '',
    this.FREQ3 = '',
    this.PLANSAM3 = '',
    this.ACTSAM3 = '',
    this.REPDUE3 = '',
    this.SENTREP3 = '',
    this.REPDAYS3 = '',
    this.REQUEST3 = '',
    this.TTCRESULT3 = '',
    this.ISSUEDATE3 = '',
    this.REVISE3 = '',
    this.SUBLEAD3 = '',
    this.GL3 = '',
    this.MGR3 = '',
    this.JP3 = '',
    this.BDPREPARE3 = '',
    this.BDTTC3 = '',
    this.BDISSUE3 = '',
    this.BDREVISE3 = '',
    this.BDSUBLEAD3 = '',
    this.BDGL3 = '',
    this.BDMGR3 = '',
    this.BDJP3 = '',
    this.BDSENT3 = '',
    this.REASON3 = '',
    this.ACTION3 = '',
    this.FREQ4 = '',
    this.PLANSAM4 = '',
    this.ACTSAM4 = '',
    this.REPDUE4 = '',
    this.SENTREP4 = '',
    this.REPDAYS4 = '',
    this.REQUEST4 = '',
    this.TTCRESULT4 = '',
    this.ISSUEDATE4 = '',
    this.REVISE4 = '',
    this.SUBLEAD4 = '',
    this.GL4 = '',
    this.MGR4 = '',
    this.JP4 = '',
    this.BDPREPARE4 = '',
    this.BDTTC4 = '',
    this.BDISSUE4 = '',
    this.BDREVISE4 = '',
    this.BDSUBLEAD4 = '',
    this.BDGL4 = '',
    this.BDMGR4 = '',
    this.BDJP4 = '',
    this.BDSENT4 = '',
    this.REASON4 = '',
    this.ACTION4 = '',
  });

  String TYPE;
  String MKTGROUP;
  String GROUP;
  String CUSTOMER;
  String FREQUENCY;
  String INCHARGE;
  String KPISERV;
  String KPIPERIOD;
  String REPITEM;
  String MONTH;
  String YEAR;
  String FREQ1;
  String PLANSAM1;
  String ACTSAM1;
  String REPDUE1;
  String SENTREP1;
  String REPDAYS1;
  String REQUEST1;
  String TTCRESULT1;
  String ISSUEDATE1;
  String REVISE1;
  String SUBLEAD1;
  String GL1;
  String MGR1;
  String JP1;
  String BDPREPARE1;
  String BDTTC1;
  String BDISSUE1;
  String BDREVISE1;
  String BDSUBLEAD1;
  String BDGL1;
  String BDMGR1;
  String BDJP1;
  String BDSENT1;
  String REASON1;
  String ACTION1;
  String FREQ2;
  String PLANSAM2;
  String ACTSAM2;
  String REPDUE2;
  String SENTREP2;
  String REPDAYS2;
  String REQUEST2;
  String TTCRESULT2;
  String ISSUEDATE2;
  String REVISE2;
  String SUBLEAD2;
  String GL2;
  String MGR2;
  String JP2;
  String BDPREPARE2;
  String BDTTC2;
  String BDISSUE2;
  String BDREVISE2;
  String BDSUBLEAD2;
  String BDGL2;
  String BDMGR2;
  String BDJP2;
  String BDSENT2;
  String REASON2;
  String ACTION2;
  String FREQ3;
  String PLANSAM3;
  String ACTSAM3;
  String REPDUE3;
  String SENTREP3;
  String REPDAYS3;
  String REQUEST3;
  String TTCRESULT3;
  String ISSUEDATE3;
  String REVISE3;
  String SUBLEAD3;
  String GL3;
  String MGR3;
  String JP3;
  String BDPREPARE3;
  String BDTTC3;
  String BDISSUE3;
  String BDREVISE3;
  String BDSUBLEAD3;
  String BDGL3;
  String BDMGR3;
  String BDJP3;
  String BDSENT3;
  String REASON3;
  String ACTION3;
  String FREQ4;
  String PLANSAM4;
  String ACTSAM4;
  String REPDUE4;
  String SENTREP4;
  String REPDAYS4;
  String REQUEST4;
  String TTCRESULT4;
  String ISSUEDATE4;
  String REVISE4;
  String SUBLEAD4;
  String GL4;
  String MGR4;
  String JP4;
  String BDPREPARE4;
  String BDTTC4;
  String BDISSUE4;
  String BDREVISE4;
  String BDSUBLEAD4;
  String BDGL4;
  String BDMGR4;
  String BDJP4;
  String BDSENT4;
  String REASON4;
  String ACTION4;
}

String savenull(input) {
  String output = '';
  if (input != null) {
    output = input.toString();
  }
  return output;
}
