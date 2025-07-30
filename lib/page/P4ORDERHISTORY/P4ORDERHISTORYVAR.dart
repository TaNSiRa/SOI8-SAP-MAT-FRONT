// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

class P4ORDERHISTORYVAR {
  static bool iscontrol = false;
  static String SEARCH = '';
  static bool isHoveredClear = false;
  static String OrderStatusForSwitchAPI = '';
  static String SendAllDataToAPI = '';
  static String DropDownPlant = 'ALL';
  static String OrderNo = '';
  static bool DropCheck = false;
  static bool isChecked1 = true;
  static bool isChecked2 = true;
  static bool isChecked3 = true;
  static bool isChecked4 = true;
  static bool isChecked5 = true;
  static bool isChecked6 = true;
  static bool isChecked7 = true;
  static bool isChecked8 = true;
  static bool isChecked9 = false;
  static bool isCheckedALL = true;
  static String searchDate = '';
  static String searchDateSTA = '';
  static String searchDateEND = '';
}


List<DEATAILOrderclass> modelDEATAILOrderclassFromJson(String str) =>
    List<DEATAILOrderclass>.from(
        json.decode(str).map((x) => DEATAILOrderclass.fromJson(x)));

String modelDEATAILOrderclassToJson(List<DEATAILOrderclass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DEATAILOrderclass {
  DEATAILOrderclass({
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
    this.Mat_UOM = '',
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
    this.Order_Picking_DT = '',
    this.Complete_Time = '',
    this.User_Complete = '',
    this.isSelected = false,
    this.User_Gen = '',
    this.Mat_Full_Act_Weight_Each_Pallet = '',
    this.Mat_Full_Act_Tare_Weight_Each_Pallet = '',
    this.Mat_Full_Act_Preset_Tare_Weight_Each_Pallet = '',
    this.Sep_Array = '',
    this.Full_Array = '',
    this.User_Full = '',
    this.Time_Full = '',
    this.Mat_Full_Status = '',
    this.Mat_Full_Pallet = '',
    this.Mat_Full_Act_Tag = '',
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
  String Mat_UOM;
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
  String Mat_Full_Status;
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
  String Order_Picking_DT;
  String Complete_Time;
  String User_Complete;
  String User_Gen;
  bool isSelected;
  String Mat_Full_Act_Weight_Each_Pallet;
  String Mat_Full_Act_Tare_Weight_Each_Pallet;
  String Mat_Full_Act_Preset_Tare_Weight_Each_Pallet;
  dynamic Sep_Array;
  dynamic Full_Array;
  String User_Full;
  String Time_Full;
  String Mat_Full_Pallet;
  String Mat_Full_Act_Tag;

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
      'Mat_UOM': Mat_UOM,
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
      'Order_Picking_DT': Order_Picking_DT,
      'Complete_Time': Complete_Time,
      'User_Complete': Complete_Time,
      'isSelected': isSelected,
      'User_Gen': User_Gen,
      'Mat_Full_Act_Weight_Each_Pallet': Mat_Full_Act_Weight_Each_Pallet,
      'Mat_Full_Act_Tare_Weight_Each_Pallet':
          Mat_Full_Act_Tare_Weight_Each_Pallet,
      'Mat_Full_Act_Preset_Tare_Weight_Each_Pallet':
          Mat_Full_Act_Preset_Tare_Weight_Each_Pallet,
      'Sep_Array': Sep_Array,
      'Full_Array': Full_Array,
      'User_Full': User_Full,
      'Time_Full': Time_Full,
      'Mat_Full_Status' : Mat_Full_Status,
      'Mat_Full_Pallet' : Mat_Full_Pallet,
      'Mat_Full_Act_Tag' : Mat_Full_Act_Tag
    };
  }

  factory DEATAILOrderclass.fromJson(Map<String, dynamic> json) =>
      DEATAILOrderclass(
        ID: json["ID"] ?? "",
        MainOrder: json["MainOrder"] ?? "",
        OrderNo: json["OrderNo"] ?? "",
        Order_Start_DT: json["Order_Start_DT"] ?? "",
        Order_Finish_DT: json["Order_Finish_DT"] ?? "",
        Order_Status: json["Order_Status"] ?? "",
        CP: json["CP"] ?? "",
        ProductName: json["ProductName"] ?? "",
        Tank: json["Tank"] ?? "",
        Lot: json["Lot"] ?? "",
        Quantity: json["Quantity"] ?? "",
        UOM: json["UOM"] ?? "",
        ST_Sep: json["ST_Sep"] ?? "",
        Time_Gen: json["Time_Gen"] ?? "",
        Mat_Count: json["Mat_Count"] ?? "",
        Mat_CP: json["Mat_CP"] ?? "",
        Mat_Name: json["Mat_Name"] ?? "",
        Mat_Quantity: json["Mat_Quantity"] ?? "",
        Mat_UOM: json["Mat_UOM"] ?? "",
        Mat_Quantity_Scada: json["Mat_Quantity_Scada"] ?? "",
        Mat_Status: json["Mat_Status"] ?? "",
        Mat_SAP_Lot1: json["Mat_SAP_Lot1"] ?? "",
        Mat_SAP_QTY1: json["Mat_SAP_QTY1"] ?? "",
        Mat_SAP_Lot2: json["Mat_SAP_Lot2"] ?? "",
        Mat_SAP_QTY2: json["Mat_SAP_QTY2"] ?? "",
        Mat_SAP_Lot3: json["Mat_SAP_Lot3"] ?? "",
        Mat_SAP_QTY3: json["Mat_SAP_QTY3"] ?? "",
        Mat_Full_SP: json["Mat_Full_SP"] ?? "",
        Mat_Full_UOM: json["Mat_Full_UOM"] ?? "",
        Mat_Sep_SP: json["Mat_Sep_SP"] ?? "",
        Mat_Sep_UOM: json["Mat_Sep_UOM"] ?? "",
        Mat_Full_Act_Lot: json["Mat_Full_Act_Lot"] ?? "",
        Mat_Full_Act_Weight: json["Mat_Full_Act_Weight"] ?? "",
        Mat_Full_Act_Tare_Weight: json["Mat_Full_Act_Tare_Weight"] ?? "",
        Mat_Sep_Act_Lot: json["Mat_Sep_Act_Lot"] ?? "",
        Mat_Sep_Act_Weight: json["Mat_Sep_Act_Weight"] ?? "",
        Mat_Sep_Act_Tare_Weight: json["Mat_Sep_Act_Tare_Weight"] ?? "",
        User_Compare: json["User_Compare"] ?? "",
        Time_Compare: json["Time_Compare"] ?? "",
        Mat_Sep_Tag: json["Mat_Sep_Tag"] ?? "",
        Mat_Sep_Tag2: json["Mat_Sep_Tag2"] ?? "",
        Remark: json["Remark"] ?? "",
        Recheck_User: json["Recheck_User"] ?? "",
        Recheck_Status: json["Recheck_Status"] ?? "",
        Recheck_Time: json["Recheck_Time"] ?? "",
        Order_Picking_DT: json["Order_Picking_DT"] ?? "",
        Complete_Time: json["Complete_Time"] ?? "",
        User_Complete: json["User_Complete"] ?? "",
        User_Gen: json["User_Gen"] ?? "",
        isSelected: json["isSelected"] ?? false,
        Mat_Full_Act_Weight_Each_Pallet:
            json["Mat_Full_Act_Weight_Each_Pallet"] ?? "",
        Mat_Full_Act_Tare_Weight_Each_Pallet:
            json["Mat_Full_Act_Tare_Weight_Each_Pallet"] ?? "",
        Mat_Full_Act_Preset_Tare_Weight_Each_Pallet:
            json["Mat_Full_Act_Preset_Tare_Weight_Each_Pallet"] ?? "",
        Sep_Array: json["Sep_Array"] ?? [],
        Full_Array: json["Full_Array"] ?? [],
        User_Full: json["User_Full"] ?? "",
        Time_Full: json["Time_Full"] ?? "",
        Mat_Full_Status : json["Mat_Full_Status"] ?? "",
        Mat_Full_Pallet : json["Mat_Full_Pallet"] ?? "",
        Mat_Full_Act_Tag : json["Mat_Full_Act_Tag"] ?? "",
      );
}
