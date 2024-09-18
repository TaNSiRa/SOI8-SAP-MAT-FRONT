import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/widget/common/Loading.dart';
import '../../data/dummydata2.dart';
import '../../page/P2PROGRESS/P02PROGRESSMAIN.dart';

//-------------------------------------------------

abstract class P02PROGRESSGETDATA_Event {}

class P02PROGRESSGETDATA_GET extends P02PROGRESSGETDATA_Event {}

class P02PROGRESSGETDATA_GET2 extends P02PROGRESSGETDATA_Event {}

class P02PROGRESSGETDATA_GET3 extends P02PROGRESSGETDATA_Event {}

class P02PROGRESSGETDATA_FLUSH extends P02PROGRESSGETDATA_Event {}

class P02PROGRESSGETDATA_Bloc
    extends Bloc<P02PROGRESSGETDATA_Event, List<P02PROGRESSGETDATAclass>> {
  P02PROGRESSGETDATA_Bloc() : super([]) {
    on<P02PROGRESSGETDATA_GET>((event, emit) {
      return _P02PROGRESSGETDATA_GET([], emit);
    });

    on<P02PROGRESSGETDATA_GET2>((event, emit) {
      return _P02PROGRESSGETDATA_GET2([], emit);
    });
    on<P02PROGRESSGETDATA_GET3>((event, emit) {
      return _P02PROGRESSGETDATA_GET3([], emit);
    });
    on<P02PROGRESSGETDATA_FLUSH>((event, emit) {
      return _P02PROGRESSGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P02PROGRESSGETDATA_GET(List<P02PROGRESSGETDATAclass> toAdd,
      Emitter<List<P02PROGRESSGETDATAclass>> emit) async {
    FreeLoadingTan(P02PROGRESSMAINcontext);
    List<P02PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    var input = dummydatainput3;
    List<P02PROGRESSGETDATAclass> outputdata = input.map((data) {
      return P02PROGRESSGETDATAclass(
        TOPIC: savenull(data['topic']),
        TARGET: savenull(data['target']),
        ACTUAL: savenull(data['actual']),
      );
    }).toList();
    // print(outputdata);
    Navigator.pop(P02PROGRESSMAINcontext);
    output = outputdata;
    emit(output);
  }

  Future<void> _P02PROGRESSGETDATA_GET2(List<P02PROGRESSGETDATAclass> toAdd,
      Emitter<List<P02PROGRESSGETDATAclass>> emit) async {
    // List<P02PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P02PROGRESSGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P02PROGRESSGETDATAclass(
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

  Future<void> _P02PROGRESSGETDATA_GET3(List<P02PROGRESSGETDATAclass> toAdd,
      Emitter<List<P02PROGRESSGETDATAclass>> emit) async {
    // List<P02PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P02PROGRESSGETDATAclass> datadummy = [
    //   P02PROGRESSGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P02PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P02PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P02PROGRESSGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P02PROGRESSGETDATA_FLUSH(List<P02PROGRESSGETDATAclass> toAdd,
      Emitter<List<P02PROGRESSGETDATAclass>> emit) async {
    List<P02PROGRESSGETDATAclass> output = [];
    emit(output);
  }
}

class P02PROGRESSGETDATAclass {
  P02PROGRESSGETDATAclass({
    this.TOPIC = '',
    this.TARGET = '',
    this.ACTUAL = '',
  });

  String TOPIC;
  String TARGET;
  String ACTUAL;
}

String savenull(input) {
  String output = '-';
  if (input != null) {
    output = input.toString();
  }
  return output;
}
