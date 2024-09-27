import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dummydata2.dart';
import '../../page/P5PROGRESS/P05PROGRESSMAIN.dart';
import '../../widget/common/Loading.dart';

//-------------------------------------------------

abstract class P05PROGRESSGETDATA_Event {}

class P05PROGRESSGETDATA_GET extends P05PROGRESSGETDATA_Event {}

class P05PROGRESSGETDATA_GET2 extends P05PROGRESSGETDATA_Event {}

class P05PROGRESSGETDATA_GET3 extends P05PROGRESSGETDATA_Event {}

class P05PROGRESSGETDATA_FLUSH extends P05PROGRESSGETDATA_Event {}

class P05PROGRESSGETDATA_Bloc
    extends Bloc<P05PROGRESSGETDATA_Event, List<P05PROGRESSGETDATAclass>> {
  P05PROGRESSGETDATA_Bloc() : super([]) {
    on<P05PROGRESSGETDATA_GET>((event, emit) {
      return _P05PROGRESSGETDATA_GET([], emit);
    });

    on<P05PROGRESSGETDATA_GET2>((event, emit) {
      return _P05PROGRESSGETDATA_GET2([], emit);
    });
    on<P05PROGRESSGETDATA_GET3>((event, emit) {
      return _P05PROGRESSGETDATA_GET3([], emit);
    });
    on<P05PROGRESSGETDATA_FLUSH>((event, emit) {
      return _P05PROGRESSGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P05PROGRESSGETDATA_GET(List<P05PROGRESSGETDATAclass> toAdd,
      Emitter<List<P05PROGRESSGETDATAclass>> emit) async {
    FreeLoadingTan(P05PROGRESSMAINcontext);
    List<P05PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    var input = dummydatainput6;

    List<P05PROGRESSGETDATAclass> outputdata = input.map((data) {
      return P05PROGRESSGETDATAclass(
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
        FREQ2: savenull(data['freq2']),
        PLANSAM2: savenull(data['plan sam2']),
        ACTSAM2: savenull(data['act sam2']),
        REPDUE2: savenull(data['rep due2']),
        SENTREP2: savenull(data['sent rep2']),
        REPDAYS2: savenull(data['rep days2']),
        FREQ3: savenull(data['freq3']),
        PLANSAM3: savenull(data['plan sam3']),
        ACTSAM3: savenull(data['act sam3']),
        REPDUE3: savenull(data['rep due3']),
        SENTREP3: savenull(data['sent rep3']),
        REPDAYS3: savenull(data['rep days3']),
        FREQ4: savenull(data['freq4']),
        PLANSAM4: savenull(data['plan sam4']),
        ACTSAM4: savenull(data['act sam4']),
        REPDUE4: savenull(data['rep due4']),
        SENTREP4: savenull(data['sent rep4']),
        REPDAYS4: savenull(data['rep days4']),
      );
    }).toList();
    // print(outputdata);
    Navigator.pop(P05PROGRESSMAINcontext);
    output = outputdata;
    emit(output);
  }

  Future<void> _P05PROGRESSGETDATA_GET2(List<P05PROGRESSGETDATAclass> toAdd,
      Emitter<List<P05PROGRESSGETDATAclass>> emit) async {
    // List<P05PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P05PROGRESSGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P05PROGRESSGETDATAclass(
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

  Future<void> _P05PROGRESSGETDATA_GET3(List<P05PROGRESSGETDATAclass> toAdd,
      Emitter<List<P05PROGRESSGETDATAclass>> emit) async {
    // List<P05PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P05PROGRESSGETDATAclass> datadummy = [
    //   P05PROGRESSGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P05PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P05PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P05PROGRESSGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P05PROGRESSGETDATA_FLUSH(List<P05PROGRESSGETDATAclass> toAdd,
      Emitter<List<P05PROGRESSGETDATAclass>> emit) async {
    List<P05PROGRESSGETDATAclass> output = [];
    emit(output);
  }
}

class P05PROGRESSGETDATAclass {
  P05PROGRESSGETDATAclass({
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
    this.FREQ2 = '',
    this.PLANSAM2 = '',
    this.ACTSAM2 = '',
    this.REPDUE2 = '',
    this.SENTREP2 = '',
    this.REPDAYS2 = '',
    this.FREQ3 = '',
    this.PLANSAM3 = '',
    this.ACTSAM3 = '',
    this.REPDUE3 = '',
    this.SENTREP3 = '',
    this.REPDAYS3 = '',
    this.FREQ4 = '',
    this.PLANSAM4 = '',
    this.ACTSAM4 = '',
    this.REPDUE4 = '',
    this.SENTREP4 = '',
    this.REPDAYS4 = '',
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
  String FREQ2;
  String PLANSAM2;
  String ACTSAM2;
  String REPDUE2;
  String SENTREP2;
  String REPDAYS2;
  String FREQ3;
  String PLANSAM3;
  String ACTSAM3;
  String REPDUE3;
  String SENTREP3;
  String REPDAYS3;
  String FREQ4;
  String PLANSAM4;
  String ACTSAM4;
  String REPDUE4;
  String SENTREP4;
  String REPDAYS4;
}

String savenull(input) {
  String output = '-';
  if (input != null) {
    output = input.toString();
  }
  return output;
}
