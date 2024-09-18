import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dummydata2.dart';
import '../../page/P4PROGRESS/P04PROGRESSMAIN.dart';
import '../../widget/common/Loading.dart';

//-------------------------------------------------

abstract class P04PROGRESSGETDATA_Event {}

class P04PROGRESSGETDATA_GET extends P04PROGRESSGETDATA_Event {}

class P04PROGRESSGETDATA_GET2 extends P04PROGRESSGETDATA_Event {}

class P04PROGRESSGETDATA_GET3 extends P04PROGRESSGETDATA_Event {}

class P04PROGRESSGETDATA_FLUSH extends P04PROGRESSGETDATA_Event {}

class P04PROGRESSGETDATA_Bloc
    extends Bloc<P04PROGRESSGETDATA_Event, List<P04PROGRESSGETDATAclass>> {
  P04PROGRESSGETDATA_Bloc() : super([]) {
    on<P04PROGRESSGETDATA_GET>((event, emit) {
      return _P04PROGRESSGETDATA_GET([], emit);
    });

    on<P04PROGRESSGETDATA_GET2>((event, emit) {
      return _P04PROGRESSGETDATA_GET2([], emit);
    });
    on<P04PROGRESSGETDATA_GET3>((event, emit) {
      return _P04PROGRESSGETDATA_GET3([], emit);
    });
    on<P04PROGRESSGETDATA_FLUSH>((event, emit) {
      return _P04PROGRESSGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P04PROGRESSGETDATA_GET(List<P04PROGRESSGETDATAclass> toAdd,
      Emitter<List<P04PROGRESSGETDATAclass>> emit) async {
    FreeLoadingTan(P04PROGRESSMAINcontext);
    List<P04PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    var input = dummydatainput5;

    List<P04PROGRESSGETDATAclass> outputdata = input.map((data) {
      return P04PROGRESSGETDATAclass(
        ISSUE1: savenull(data['issue1']),
        ISSUE2: savenull(data['issue2']),
      );
    }).toList();
    // print(outputdata);
    Navigator.pop(P04PROGRESSMAINcontext);
    output = outputdata;
    emit(output);
  }

  Future<void> _P04PROGRESSGETDATA_GET2(List<P04PROGRESSGETDATAclass> toAdd,
      Emitter<List<P04PROGRESSGETDATAclass>> emit) async {
    // List<P04PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P04PROGRESSGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P04PROGRESSGETDATAclass(
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

  Future<void> _P04PROGRESSGETDATA_GET3(List<P04PROGRESSGETDATAclass> toAdd,
      Emitter<List<P04PROGRESSGETDATAclass>> emit) async {
    // List<P04PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P04PROGRESSGETDATAclass> datadummy = [
    //   P04PROGRESSGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P04PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P04PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P04PROGRESSGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P04PROGRESSGETDATA_FLUSH(List<P04PROGRESSGETDATAclass> toAdd,
      Emitter<List<P04PROGRESSGETDATAclass>> emit) async {
    List<P04PROGRESSGETDATAclass> output = [];
    emit(output);
  }
}

class P04PROGRESSGETDATAclass {
  P04PROGRESSGETDATAclass({
    this.ISSUE1 = '',
    this.ISSUE2 = '',
  });

  String ISSUE1;
  String ISSUE2;
}

String savenull(input) {
  String output = '-';
  if (input != null) {
    output = input.toString();
  }
  return output;
}
