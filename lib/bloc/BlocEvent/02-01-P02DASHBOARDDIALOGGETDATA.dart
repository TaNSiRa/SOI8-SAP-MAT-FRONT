// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newmaster/page/P1DASHBOARD/P01DASHBOARDVAR.dart';
import '../../data/global.dart';
import '../../page/P2DASHBOARDDIALOG/P02DASHBOARDDIALOGMAIN.dart';
import '../../page/P2DASHBOARDDIALOG/P02DASHBOARDDIALOGVAR.dart';
import '../../widget/common/Loading.dart';

//-------------------------------------------------

abstract class P02DASHBOARDDIALOGGETDATA_Event {}

class P02DASHBOARDDIALOGGETDATA_GET extends P02DASHBOARDDIALOGGETDATA_Event {}

class P02DASHBOARDDIALOGGETDATA_GET2 extends P02DASHBOARDDIALOGGETDATA_Event {}

class P02DASHBOARDDIALOGGETDATA_GET3 extends P02DASHBOARDDIALOGGETDATA_Event {}

class P02DASHBOARDDIALOGGETDATA_FLUSH extends P02DASHBOARDDIALOGGETDATA_Event {}

class P02DASHBOARDDIALOGGETDATA_Bloc extends Bloc<
    P02DASHBOARDDIALOGGETDATA_Event, List<P02DASHBOARDDIALOGGETDATAclass>> {
  P02DASHBOARDDIALOGGETDATA_Bloc() : super([]) {
    on<P02DASHBOARDDIALOGGETDATA_GET>((event, emit) {
      return _P02DASHBOARDDIALOGGETDATA_GET([], emit);
    });

    on<P02DASHBOARDDIALOGGETDATA_GET2>((event, emit) {
      return _P02DASHBOARDDIALOGGETDATA_GET2([], emit);
    });
    on<P02DASHBOARDDIALOGGETDATA_GET3>((event, emit) {
      return _P02DASHBOARDDIALOGGETDATA_GET3([], emit);
    });
    on<P02DASHBOARDDIALOGGETDATA_FLUSH>((event, emit) {
      return _P02DASHBOARDDIALOGGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P02DASHBOARDDIALOGGETDATA_GET(
      List<P02DASHBOARDDIALOGGETDATAclass> toAdd,
      Emitter<List<P02DASHBOARDDIALOGGETDATAclass>> emit) async {
    FreeLoadingTan(P02DASHBOARDDIALOGMAINcontext);
    List<P02DASHBOARDDIALOGGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    Response response;
    if (P01DASHBOARDVAR.OrderStatusForSwitchAPI == 'SAP') {
      response = await Dio().post(
        "$APIArsa/soi8/compareSCADA",
        data: {'dataOrder': P01DASHBOARDVAR.SendAllDataToAPI},
      );
      print('Sent complete');
    } else {
      response = await Dio().post(
        "$APIArsa/soi8/orderDetail",
        data: {'dataOrder': P01DASHBOARDVAR.SendAllDataToAPI},
      );
      print('Sent complete');
    }

    // response = await Dio().post(
    //   "$APIArsa/soi8/compareSCADA",
    //   data: {'OrderNo': P01DASHBOARDVAR.SendAllDataToAPI},
    // );
    var input = [];
    if (response.statusCode == 200) {
      print(response.statusCode);
      // print(response.data);
      var databuff = response.data;
      input = databuff;
      // input = dummydata2;

      List<P02DASHBOARDDIALOGGETDATAclass> outputdata = input.map((dataActual) {
        return P02DASHBOARDDIALOGGETDATAclass(
          ID: savenull(dataActual['ID']),
          MainOrder: savenull(dataActual['MainOrder']),
          OrderNo: savenull(dataActual['OrderNo']),
          Order_Start_DT: savenull(dataActual['Order_Start_DT']),
          Order_Finish_DT: savenull(dataActual['Order_Finish_DT']),
          Order_Status: savenull(dataActual['Order_Status']),
          CP: savenull(dataActual['CP']),
          ProductName: savenull(dataActual['ProductName']),
          Tank: savenull(dataActual['Tank']),
          Lot: savenull(dataActual['Lot']),
          Quantity: savenull(dataActual['Quantity']),
          UOM: savenull(dataActual['UOM']),
          ST_Sep: savenull(dataActual['ST_Sep']),
          Time_Gen: savenull(dataActual['Time_Gen']),
          Mat_Count: savenull(dataActual['Mat_Count']),
          Mat_CP: savenull(dataActual['Mat_CP']),
          Mat_Name: savenull(dataActual['Mat_Name']),
          Mat_Quantity: savenull(dataActual['Mat_Quantity']),
          Mat_Quantity_Scada: savenull(dataActual['Mat_Quantity_Scada']),
          Mat_Status: savenull(dataActual['Mat_Status']),
          Mat_SAP_Lot1: savenull(dataActual['Mat_SAP_Lot1']),
          Mat_SAP_QTY1: savenull(dataActual['Mat_SAP_QTY1']),
          Mat_SAP_Lot2: savenull(dataActual['Mat_SAP_Lot2']),
          Mat_SAP_QTY2: savenull(dataActual['Mat_SAP_QTY2']),
          Mat_SAP_Lot3: savenull(dataActual['Mat_SAP_Lot3']),
          Mat_SAP_QTY3: savenull(dataActual['Mat_SAP_QTY3']),
          Mat_Full_SP: savenull(dataActual['Mat_Full_SP']),
          Mat_Full_UOM: savenull(dataActual['Mat_Full_UOM']),
          Mat_Sep_SP: savenull(dataActual['Mat_Sep_SP']),
          Mat_Sep_UOM: savenull(dataActual['Mat_Sep_UOM']),
          Mat_Full_Act_Lot: savenull(dataActual['Mat_Full_Act_Lot']),
          Mat_Full_Act_Weight: savenull(dataActual['Mat_Full_Act_Weight']),
          Mat_Full_Act_Tare_Weight:
              savenull(dataActual['Mat_Full_Act_Tare_Weight']),
          Mat_Sep_Act_Lot: savenull(dataActual['Mat_Sep_Act_Lot']),
          Mat_Sep_Act_Weight: savenull(dataActual['Mat_Sep_Act_Weight']),
          Mat_Sep_Act_Tare_Weight:
              savenull(dataActual['Mat_Sep_Act_Tare_Weight']),
          User_Compare: savenull(dataActual['User_Compare']),
          Time_Compare: savenull(dataActual['Time_Compare']),
          Mat_Sep_Tag: savenull(dataActual['Mat_Sep_Tag']),
          Mat_Sep_Tag2: savenull(dataActual['Mat_Sep_Tag2']),
          Remark: savenull(dataActual['Remark']),
          Recheck_User: savenull(dataActual['Recheck_User']),
          Recheck_Status: savenull(dataActual['Recheck_Status']),
          Recheck_Time: savenull(dataActual['Recheck_Time']),
        );
      }).toList();
      Navigator.pop(P02DASHBOARDDIALOGMAINcontext);
      output = outputdata;
      emit(output);
    } else {
      print("where is my server");
      output = [];
      emit(output);
    }
  }

  Future<void> _P02DASHBOARDDIALOGGETDATA_GET2(
      List<P02DASHBOARDDIALOGGETDATAclass> toAdd,
      Emitter<List<P02DASHBOARDDIALOGGETDATAclass>> emit) async {
    // List<P02DASHBOARDDIALOGGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // var input = dummydatainput2;
    Response response;
    if (P01DASHBOARDVAR.OrderStatusForSwitchAPI == 'SAP') {
      response = await Dio().post(
        "$APIArsa/soi8/createOrder",
        data: {'dataOrder': P02DASHBOARDDIALOGVAR.SendAllDataToAPI},
      );
      print('Sent complete');
    } else {
      response = await Dio().post(
        "$APIArsa/soi8/sendOrderToSAP",
        data: {'dataOrder': P02DASHBOARDDIALOGVAR.SendAllDataToAPI},
      );
      print('Sent complete');
    }

    // List<P02DASHBOARDDIALOGGETDATAclass> outputdata = input
    //     .where((data) =>
    //         data['location'] == 'ESIE1' &&
    //         data['plant'] == 'YES' &&
    //         data['step01'] == 'YES')
    //     .map((data) {
    //   return P02DASHBOARDDIALOGGETDATAclass(
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

  Future<void> _P02DASHBOARDDIALOGGETDATA_GET3(
      List<P02DASHBOARDDIALOGGETDATAclass> toAdd,
      Emitter<List<P02DASHBOARDDIALOGGETDATAclass>> emit) async {
    // List<P02DASHBOARDDIALOGGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P02DASHBOARDDIALOGGETDATAclass> datadummy = [
    //   P02DASHBOARDDIALOGGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P02DASHBOARDDIALOGGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P02DASHBOARDDIALOGGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P02DASHBOARDDIALOGGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P02DASHBOARDDIALOGGETDATA_FLUSH(
      List<P02DASHBOARDDIALOGGETDATAclass> toAdd,
      Emitter<List<P02DASHBOARDDIALOGGETDATAclass>> emit) async {
    List<P02DASHBOARDDIALOGGETDATAclass> output = [];
    emit(output);
  }
}

class P02DASHBOARDDIALOGGETDATAclass {
  P02DASHBOARDDIALOGGETDATAclass({
    this.ID = '',
    this.MainOrder = '',
    this.OrderNo = '',
    this.Order_Start_DT = '',
    this.Order_Finish_DT = '',
    this.Order_Status = '',
    this.CP = '',
    this.ProductName = '',
    this.Tank = '',
    this.Lot = '',
    this.Quantity = '',
    this.UOM = '',
    this.ST_Sep = '',
    this.Time_Gen = '',
    this.Mat_Count = '',
    this.Mat_CP = '',
    this.Mat_Name = '',
    this.Mat_Quantity = '',
    this.Mat_Quantity_Scada = '',
    this.Mat_Status = '',
    this.Mat_SAP_Lot1 = '',
    this.Mat_SAP_QTY1 = '',
    this.Mat_SAP_Lot2 = '',
    this.Mat_SAP_QTY2 = '',
    this.Mat_SAP_Lot3 = '',
    this.Mat_SAP_QTY3 = '',
    this.Mat_Full_SP = '',
    this.Mat_Full_UOM = '',
    this.Mat_Sep_SP = '',
    this.Mat_Sep_UOM = '',
    this.Mat_Full_Act_Lot = '',
    this.Mat_Full_Act_Weight = '',
    this.Mat_Full_Act_Tare_Weight = '',
    this.Mat_Sep_Act_Lot = '',
    this.Mat_Sep_Act_Weight = '',
    this.Mat_Sep_Act_Tare_Weight = '',
    this.User_Compare = '',
    this.Time_Compare = '',
    this.Mat_Sep_Tag = '',
    this.Mat_Sep_Tag2 = '',
    this.Remark = '',
    this.Recheck_User = '',
    this.Recheck_Status = '',
    this.Recheck_Time = '',
  });

  String ID;
  String MainOrder;
  String OrderNo;
  String Order_Start_DT;
  String Order_Finish_DT;
  String Order_Status;
  String CP;
  String ProductName;
  String Tank;
  String Lot;
  String Quantity;
  String UOM;
  String ST_Sep;
  String Time_Gen;
  String Mat_Count;
  String Mat_CP;
  String Mat_Name;
  String Mat_Quantity;
  String Mat_Quantity_Scada;
  String Mat_Status;
  String Mat_SAP_Lot1;
  String Mat_SAP_QTY1;
  String Mat_SAP_Lot2;
  String Mat_SAP_QTY2;
  String Mat_SAP_Lot3;
  String Mat_SAP_QTY3;
  String Mat_Full_SP;
  String Mat_Full_UOM;
  String Mat_Sep_SP;
  String Mat_Sep_UOM;
  String Mat_Full_Act_Lot;
  String Mat_Full_Act_Weight;
  String Mat_Full_Act_Tare_Weight;
  String Mat_Sep_Act_Lot;
  String Mat_Sep_Act_Weight;
  String Mat_Sep_Act_Tare_Weight;
  String User_Compare;
  String Time_Compare;
  String Mat_Sep_Tag;
  String Mat_Sep_Tag2;
  String Remark;
  String Recheck_User;
  String Recheck_Status;
  String Recheck_Time;
  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'MainOrder': MainOrder,
      'OrderNo': OrderNo,
      'Order_Start_DT': Order_Start_DT,
      'Order_Finish_DT': Order_Finish_DT,
      'Order_Status': Order_Status,
      'CP': CP,
      'ProductName': ProductName,
      'Tank': Tank,
      'Lot': Lot,
      'Quantity': Quantity,
      'UOM': UOM,
      'ST_Sep': ST_Sep,
      'Time_Gen': Time_Gen,
      'Mat_Count': Mat_Count,
      'Mat_CP': Mat_CP,
      'Mat_Name': Mat_Name,
      'Mat_Quantity': Mat_Quantity,
      'Mat_Quantity_Scada': Mat_Quantity_Scada,
      'Mat_Status': Mat_Status,
      'Mat_SAP_Lot1': Mat_SAP_Lot1,
      'Mat_SAP_QTY1': Mat_SAP_QTY1,
      'Mat_SAP_Lot2': Mat_SAP_Lot2,
      'Mat_SAP_QTY2': Mat_SAP_QTY2,
      'Mat_SAP_Lot3': Mat_SAP_Lot3,
      'Mat_SAP_QTY3': Mat_SAP_QTY3,
      'Mat_Full_SP': Mat_Full_SP,
      'Mat_Full_UOM': Mat_Full_UOM,
      'Mat_Sep_SP': Mat_Sep_SP,
      'Mat_Sep_UOM': Mat_Sep_UOM,
      'Mat_Full_Act_Lot': Mat_Full_Act_Lot,
      'Mat_Full_Act_Weight': Mat_Full_Act_Weight,
      'Mat_Full_Act_Tare_Weight': Mat_Full_Act_Tare_Weight,
      'Mat_Sep_Act_Lot': Mat_Sep_Act_Lot,
      'Mat_Sep_Act_Weight': Mat_Sep_Act_Weight,
      'Mat_Sep_Act_Tare_Weight': Mat_Sep_Act_Tare_Weight,
      'User_Compare': User_Compare,
      'Time_Compare': Time_Compare,
      'Mat_Sep_Tag': Mat_Sep_Tag,
      'Mat_Sep_Tag2': Mat_Sep_Tag2,
      'Remark': Remark,
      'Recheck_User': Recheck_User,
      'Recheck_Status': Recheck_Status,
      'Recheck_Time': Recheck_Time,
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
    // print(date);
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  } catch (e) {
    return '';
  }
}
