import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dummydata2.dart';
import '../../page/P3PROGRESS/P03PROGRESSMAIN.dart';
import '../../widget/common/Loading.dart';

//-------------------------------------------------

abstract class P03PROGRESSGETDATA_Event {}

class P03PROGRESSGETDATA_GET extends P03PROGRESSGETDATA_Event {}

class P03PROGRESSGETDATA_GET2 extends P03PROGRESSGETDATA_Event {}

class P03PROGRESSGETDATA_GET3 extends P03PROGRESSGETDATA_Event {}

class P03PROGRESSGETDATA_FLUSH extends P03PROGRESSGETDATA_Event {}

class P03PROGRESSGETDATA_Bloc
    extends Bloc<P03PROGRESSGETDATA_Event, List<P03PROGRESSGETDATAclass>> {
  P03PROGRESSGETDATA_Bloc() : super([]) {
    on<P03PROGRESSGETDATA_GET>((event, emit) {
      return _P03PROGRESSGETDATA_GET([], emit);
    });

    on<P03PROGRESSGETDATA_GET2>((event, emit) {
      return _P03PROGRESSGETDATA_GET2([], emit);
    });
    on<P03PROGRESSGETDATA_GET3>((event, emit) {
      return _P03PROGRESSGETDATA_GET3([], emit);
    });
    on<P03PROGRESSGETDATA_FLUSH>((event, emit) {
      return _P03PROGRESSGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P03PROGRESSGETDATA_GET(List<P03PROGRESSGETDATAclass> toAdd,
      Emitter<List<P03PROGRESSGETDATAclass>> emit) async {
    FreeLoadingTan(P03PROGRESSMAINcontext);
    List<P03PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    var input = dummydatainput4;

    List<P03PROGRESSGETDATAclass> outputdata = input.map((data) {
      return P03PROGRESSGETDATAclass(
        MONTH: savenull(data['month']),
        ACHIEVED: savenull(data['achieved']),
      );
    }).toList();
    // print(outputdata);
    Navigator.pop(P03PROGRESSMAINcontext);
    output = outputdata;
    emit(output);
  }

  Future<void> _P03PROGRESSGETDATA_GET2(List<P03PROGRESSGETDATAclass> toAdd,
      Emitter<List<P03PROGRESSGETDATAclass>> emit) async {
    // List<P03PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;

    // List<P03PROGRESSGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P03PROGRESSGETDATAclass(
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

  Future<void> _P03PROGRESSGETDATA_GET3(List<P03PROGRESSGETDATAclass> toAdd,
      Emitter<List<P03PROGRESSGETDATAclass>> emit) async {
    // List<P03PROGRESSGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P03PROGRESSGETDATAclass> datadummy = [
    //   P03PROGRESSGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P03PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P03PROGRESSGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P03PROGRESSGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P03PROGRESSGETDATA_FLUSH(List<P03PROGRESSGETDATAclass> toAdd,
      Emitter<List<P03PROGRESSGETDATAclass>> emit) async {
    List<P03PROGRESSGETDATAclass> output = [];
    emit(output);
  }
}

class P03PROGRESSGETDATAclass {
  P03PROGRESSGETDATAclass({
    this.MONTH = '',
    this.ACHIEVED = '',
  });

  String MONTH;
  String ACHIEVED;
}

String savenull(input) {
  String output = '-';
  if (input != null) {
    output = input.toString();
  }
  return output;
}
