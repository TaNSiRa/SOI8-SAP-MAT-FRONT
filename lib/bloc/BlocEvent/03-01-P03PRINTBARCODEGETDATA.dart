// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/dummydata2.dart';
import '../../data/global.dart';
import '../../page/P3PRINTBARCODE/P03PRINTBARCODEMAIN.dart';
import '../../page/P3PRINTBARCODE/P03PRINTBARCODEVAR.dart';
import '../../widget/common/Loading.dart';

//-------------------------------------------------

abstract class P03PRINTBARCODEGETDATA_Event {}

class P03PRINTBARCODEGETDATA_GET extends P03PRINTBARCODEGETDATA_Event {}

class P03PRINTBARCODEGETDATA_GET2 extends P03PRINTBARCODEGETDATA_Event {}

class P03PRINTBARCODEGETDATA_GET3 extends P03PRINTBARCODEGETDATA_Event {}

class P03PRINTBARCODEGETDATA_FLUSH extends P03PRINTBARCODEGETDATA_Event {}

class P03PRINTBARCODEGETDATA_Bloc extends Bloc<P03PRINTBARCODEGETDATA_Event,
    List<P03PRINTBARCODEGETDATAclass>> {
  P03PRINTBARCODEGETDATA_Bloc() : super([]) {
    on<P03PRINTBARCODEGETDATA_GET>((event, emit) {
      return _P03PRINTBARCODEGETDATA_GET([], emit);
    });

    on<P03PRINTBARCODEGETDATA_GET2>((event, emit) {
      return _P03PRINTBARCODEGETDATA_GET2([], emit);
    });
    on<P03PRINTBARCODEGETDATA_GET3>((event, emit) {
      return _P03PRINTBARCODEGETDATA_GET3([], emit);
    });
    on<P03PRINTBARCODEGETDATA_FLUSH>((event, emit) {
      return _P03PRINTBARCODEGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P03PRINTBARCODEGETDATA_GET(
      List<P03PRINTBARCODEGETDATAclass> toAdd,
      Emitter<List<P03PRINTBARCODEGETDATAclass>> emit) async {
    FreeLoadingTan(P03PRINTBARCODEMAINcontext);
    List<P03PRINTBARCODEGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    var input = dummydata2;

    List<P03PRINTBARCODEGETDATAclass> outputdata = input.map((dataActual) {
      return P03PRINTBARCODEGETDATAclass(
        PDNAME: savenull(dataActual['Product_Name']),
        QUANTITY: savenull(dataActual['Quantity']),
        UNIT: savenull(dataActual['Unit']),
        TANK: savenull(dataActual['Tank']),
        LOT: savenull(dataActual['Lot']),
        ORDERNO: savenull(dataActual['Order_No']),
        STDATE: savenull(dataActual['ST_Date']),
        STATUS: savenull(dataActual['Status']),
        CODE: savenull(dataActual['Code']),
        TBATCH: savenull(dataActual['T_Batch']),
        BATCH: savenull(dataActual['Batch']),
        TTQUANTITY: savenull(dataActual['TT_Quantity']),
        PBATCH: savenull(dataActual['P_Batch']),
        PQBAGSAP: savenull(dataActual['P_Quantity_Bag_SAP']),
        PQKGSAP: savenull(dataActual['P_Quantity_KG_SAP']),
        PQBAGSCADA: savenull(dataActual['P_Quantity_Bag_SCADA']),
        PQKGSCADA: savenull(dataActual['P_Quantity_KG_SCADA']),
        PLOT1: savenull(dataActual['Product_Lot_1']),
        PLOT2: savenull(dataActual['Product_Lot_2']),
        PLOT3: savenull(dataActual['Product_Lot_3']),
        MAT: savenull(dataActual['Mat']),
      );
    }).toList();
    Navigator.pop(P03PRINTBARCODEMAINcontext);

    output = outputdata;
    emit(output);
  }

  Future<void> _P03PRINTBARCODEGETDATA_GET2(
      List<P03PRINTBARCODEGETDATAclass> toAdd,
      Emitter<List<P03PRINTBARCODEGETDATAclass>> emit) async {
    FreeLoadingTan(P03PRINTBARCODEMAINcontext);
    List<P03PRINTBARCODEGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    print(P03PRINTBARCODEVAR.groupedData);
    final response = await Dio().post(
      "http://127.0.0.1:7700/02GENBARCODE/GenBarcodePDF",
      data: {
        'Printdata': P03PRINTBARCODEVAR.jsonData,
        'userData': {
              'Id': USERDATA.ID,
              'Name': USERDATA.NAME,
            },
      },
    );
    Navigator.pop(P03PRINTBARCODEMAINcontext);
    // output = response.data;
    // emit(output);
  }

  Future<void> _P03PRINTBARCODEGETDATA_GET3(
      List<P03PRINTBARCODEGETDATAclass> toAdd,
      Emitter<List<P03PRINTBARCODEGETDATAclass>> emit) async {
    // List<P03PRINTBARCODEGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P03PRINTBARCODEGETDATAclass> datadummy = [
    //   P03PRINTBARCODEGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P03PRINTBARCODEGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P03PRINTBARCODEGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P03PRINTBARCODEGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P03PRINTBARCODEGETDATA_FLUSH(
      List<P03PRINTBARCODEGETDATAclass> toAdd,
      Emitter<List<P03PRINTBARCODEGETDATAclass>> emit) async {
    List<P03PRINTBARCODEGETDATAclass> output = [];
    emit(output);
  }
}

class P03PRINTBARCODEGETDATAclass {
  P03PRINTBARCODEGETDATAclass({
    this.PDNAME = '',
    this.LOT = '',
    this.ORDERNO = '',
    this.STDATE = '',
    this.STATUS = '',
    this.TANK = '',
    this.QUANTITY = '',
    this.UNIT = '',
    this.CODE = '',
    this.TBATCH = '',
    this.BATCH = '',
    this.TTQUANTITY = '',
    this.PBATCH = '',
    this.PQBAGSAP = '',
    this.PQKGSAP = '',
    this.PQBAGSCADA = '',
    this.PQKGSCADA = '',
    this.PLOT1 = '',
    this.PLOT2 = '',
    this.PLOT3 = '',
    this.MAT = '',
  });

  String PDNAME;
  String LOT;
  String ORDERNO;
  String STDATE;
  String STATUS;
  String TANK;
  String QUANTITY;
  String UNIT;
  String CODE;
  String TBATCH;
  String BATCH;
  String TTQUANTITY;
  String PBATCH;
  String PQBAGSAP;
  String PQKGSAP;
  String PQBAGSCADA;
  String PQKGSCADA;
  String PLOT1;
  String PLOT2;
  String PLOT3;
  String MAT;

  Map<String, dynamic> toJson() {
    return {
      'pdname': PDNAME,
      'lot': LOT,
      'orderno': ORDERNO,
      'stdate': STDATE,
      'status': STATUS,
      'tank': TANK,
      'quantity': QUANTITY,
      'unit': UNIT,
      'code': CODE,
      'tbatch': TBATCH,
      'batch': BATCH,
      'ttquantity': TTQUANTITY,
      'pbatch': PBATCH,
      'pqbagsap': PQBAGSAP,
      'pqkgsap': PQKGSAP,
      'pqbagscada': PQBAGSCADA,
      'pqkgscada': PQKGSCADA,
      'plot1': PLOT1,
      'plot2': PLOT2,
      'plot3': PLOT3,
      'mat': MAT
    };
  }
}

String savenull(input) {
  String output = '';
  if (input != null) {
    output = input.toString();
  }
  return output;
}

String formatDate(String? date) {
  if (date == null || date.isEmpty) return '';
  if (date == 'CLOSE LINE') return 'CLOSE LINE';
  try {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat('dd-MMM').format(parsedDate);
  } catch (e) {
    return '';
  }
}
