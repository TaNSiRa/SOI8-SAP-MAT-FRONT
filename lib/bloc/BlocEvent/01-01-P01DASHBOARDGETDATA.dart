// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, use_build_context_synchronously, file_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';
import '../../data/dummydata2.dart';
import '../../data/global.dart';
import '../../page/P1DASHBOARD/P01DASHBOARDMAIN.dart';
import '../../widget/common/Loading.dart';

//-------------------------------------------------

abstract class P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_GET extends P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_GET2 extends P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_GET3 extends P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_FLUSH extends P01DASHBOARDGETDATA_Event {}

class P01DASHBOARDGETDATA_Bloc
    extends Bloc<P01DASHBOARDGETDATA_Event, List<P01DASHBOARDGETDATAclass>> {
  P01DASHBOARDGETDATA_Bloc() : super([]) {
    on<P01DASHBOARDGETDATA_GET>((event, emit) {
      return _P01DASHBOARDGETDATA_GET([], emit);
    });

    on<P01DASHBOARDGETDATA_GET2>((event, emit) {
      return _P01DASHBOARDGETDATA_GET2([], emit);
    });
    on<P01DASHBOARDGETDATA_GET3>((event, emit) {
      return _P01DASHBOARDGETDATA_GET3([], emit);
    });
    on<P01DASHBOARDGETDATA_FLUSH>((event, emit) {
      return _P01DASHBOARDGETDATA_FLUSH([], emit);
    });
  }

  Future<void> _P01DASHBOARDGETDATA_GET(List<P01DASHBOARDGETDATAclass> toAdd,
      Emitter<List<P01DASHBOARDGETDATAclass>> emit) async {
    FreeLoadingTan(P01DASHBOARDMAINcontext);
    List<P01DASHBOARDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().get(
      "$APIArsa/soi8/fetchOrder",
      data: {},
    );
    var input = [];
    if (response.statusCode == 200) {
      print(response.statusCode);
      // print(response.data);
      var databuff = response.data;
      input = databuff;

      List<P01DASHBOARDGETDATAclass> outputdata = input.map((dataActual) {
        return P01DASHBOARDGETDATAclass(
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
      Navigator.pop(P01DASHBOARDMAINcontext);

      output = outputdata;
      emit(output);
    } else {
      print("where is my server");
      output = [];
      emit(output);
    }
  }

  Future<void> _P01DASHBOARDGETDATA_GET2(List<P01DASHBOARDGETDATAclass> toAdd,
      Emitter<List<P01DASHBOARDGETDATAclass>> emit) async {
    FreeLoadingTan(P01DASHBOARDMAINcontext);
    List<P01DASHBOARDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    final response = await Dio().post(
      "$APIArsa/soi8/printPickingList",
      data: {},
    );

    String input = response.data;
    print(input);
    Navigator.pop(P01DASHBOARDMAINcontext);

    showPDF(input, P01DASHBOARDMAINcontext);
    print('test');
    output = [];
    emit(output);
  }

  Future<void> _P01DASHBOARDGETDATA_GET3(List<P01DASHBOARDGETDATAclass> toAdd,
      Emitter<List<P01DASHBOARDGETDATAclass>> emit) async {
    // List<P01DASHBOARDGETDATAclass> output = [];
    //-------------------------------------------------------------------------------------
    // List<P01DASHBOARDGETDATAclass> datadummy = [
    //   P01DASHBOARDGETDATAclass(
    //     PLANT: "PH PO:1234",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //   ),
    //   P01DASHBOARDGETDATAclass(
    //     PLANT: "PH PO:5555",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //     STEP03: "YES",
    //     STEP04: "YES",
    //   ),
    //   P01DASHBOARDGETDATAclass(
    //     PLANT: "PH PO:5556",
    //     STEP01: "YES",
    //     STEP02: "YES",
    //   ),
    //   P01DASHBOARDGETDATAclass(
    //     PLANT: "PH PO:9999",
    //   ),
    // ];

    // //-------------------------------------------------------------------------------------
    // output = datadummy;
    // emit(output);
  }

  Future<void> _P01DASHBOARDGETDATA_FLUSH(List<P01DASHBOARDGETDATAclass> toAdd,
      Emitter<List<P01DASHBOARDGETDATAclass>> emit) async {
    List<P01DASHBOARDGETDATAclass> output = [];
    emit(output);
  }
}

String modelFullRequestDataToJson(List<P01DASHBOARDGETDATAclass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class P01DASHBOARDGETDATAclass {
  P01DASHBOARDGETDATAclass({
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
  String output = '-';
  if (input != null) {
    output = input.toString();
  }
  return output;
}

void showPDF(String pdf64, BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // หัวข้อ
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Preview PDF',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
              ),

              // แสดง PDF
              Container(
                width: width * 0.8,
                height: height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: PdfPreview(
                    padding: const EdgeInsets.all(8),
                    actionBarTheme: PdfActionBarTheme(
                      backgroundColor: Colors.blueGrey[800],
                      iconColor: Colors.white,
                    ),
                    canChangePageFormat: false,
                    canChangeOrientation: false,
                    canDebug: false,
                    useActions: true,
                    build: (format) => base64Decode(pdf64),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ปุ่มปิด
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, size: 20, color: Colors.red),
                label: const Text('Close'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blueGrey[600],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
