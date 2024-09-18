import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dummydata2.dart';
import '../../page/P1PROGRESS/P01PROGRESSMAIN.dart';
import '../../widget/common/Loading.dart';
//-------------------------------------------------

abstract class P01PROGRESSGETDATA_Event {}

class P01PROGRESSGETDATA_GET extends P01PROGRESSGETDATA_Event {}

class P01PROGRESSGETDATA_GET2 extends P01PROGRESSGETDATA_Event {}

class P01PROGRESSGETDATA_GET3 extends P01PROGRESSGETDATA_Event {}

class P01PROGRESSGETDATA_FLUSH extends P01PROGRESSGETDATA_Event {}

class P01PROGRESSGETDATA_Bloc
    extends Bloc<P01PROGRESSGETDATA_Event, List<P01PROGRESSGETDATAclass>> {
  P01PROGRESSGETDATA_Bloc() : super([]) {
    on<P01PROGRESSGETDATA_GET>((event, emit) {
      return _P01PROGRESSGETDATA_GET([], emit);
    });

    on<P01PROGRESSGETDATA_GET2>((event, emit) {
      return _P01PROGRESSGETDATA_GET2([], emit);
    });
    on<P01PROGRESSGETDATA_GET3>((event, emit) {
      return _P01PROGRESSGETDATA_GET3([], emit);
    });
    on<P01PROGRESSGETDATA_FLUSH>((event, emit) {
      return _P01PROGRESSGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P01PROGRESSGETDATA_GET(List<P01PROGRESSGETDATAclass> toAdd,
      Emitter<List<P01PROGRESSGETDATAclass>> emit) async {
    FreeLoadingTan(P01PROGRESSMAINcontext);
    List<P01PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    var input = dummydatainput2;
    List<P01PROGRESSGETDATAclass> outputdata = input.map((data) {
      return P01PROGRESSGETDATAclass(
        MONTH: savenull(data['month']),
        KAC: savenull(data['kac']),
        MEDIUM: savenull(data['medium']),
      );
    }).toList();
    Navigator.pop(P01PROGRESSMAINcontext);
    output = outputdata;
    emit(output);
  }

  Future<void> _P01PROGRESSGETDATA_GET2(List<P01PROGRESSGETDATAclass> toAdd,
      Emitter<List<P01PROGRESSGETDATAclass>> emit) async {
    // List<P01PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P01PROGRESSGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P01PROGRESSGETDATAclass(
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

  Future<void> _P01PROGRESSGETDATA_GET3(List<P01PROGRESSGETDATAclass> toAdd,
      Emitter<List<P01PROGRESSGETDATAclass>> emit) async {
    // List<P01PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P01PROGRESSGETDATAclass> datadummy = [
    //   P01PROGRESSGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P01PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P01PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P01PROGRESSGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P01PROGRESSGETDATA_FLUSH(List<P01PROGRESSGETDATAclass> toAdd,
      Emitter<List<P01PROGRESSGETDATAclass>> emit) async {
    List<P01PROGRESSGETDATAclass> output = [];
    emit(output);
  }
}

class P01PROGRESSGETDATAclass {
  P01PROGRESSGETDATAclass({
    this.MONTH = '',
    this.KAC = '',
    this.MEDIUM = '',
  });

  String MONTH;
  String KAC;
  String MEDIUM;
}

String savenull(input) {
  String output = '-';
  if (input != null) {
    output = input.toString();
  }
  return output;
}
