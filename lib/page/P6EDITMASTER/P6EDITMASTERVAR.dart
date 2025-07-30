import 'dart:convert';

List<STDProductclass> modelSTDProductclassFromJson(String str) =>
    List<STDProductclass>.from(
        json.decode(str).map((x) => STDProductclass.fromJson(x)));

String modelSTDProductclassToJson(List<STDProductclass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class STDProductclass {
  STDProductclass({
    this.ID = '',
    this.CP_Master = '',
    this.Product_Name = '',
    this.Plant = '',
    this.ST_Sep = '',
  });

  String ID;
  String CP_Master;
  String Product_Name;
  String Plant;
  String ST_Sep;

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'CP_Master': CP_Master,
      'Product_Name': Product_Name,
      'Plant': Plant,
      'ST_Sep': ST_Sep
    };
  }

  factory STDProductclass.fromJson(Map<String, dynamic> json) =>
      STDProductclass(
        ID: json["ID"].toString() ?? "",
        CP_Master: json["CP_Master"].toString() ?? "",
        Product_Name: json["Product_Name"].toString() ?? "",
        Plant: json["Plant"].toString() ?? "",
        ST_Sep: json["ST_Sep"].toString() ?? "",
      );
}

List<STDWeightclass> modelSTDWeightclassFromJson(String str) =>
    List<STDWeightclass>.from(
        json.decode(str).map((x) => STDWeightclass.fromJson(x)));

String modelSTDWeightclassToJson(List<STDWeightclass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class STDWeightclass {
  STDWeightclass({
    this.ID = '',
    this.Mat_CP = '',
    this.Chm = '',
    this.Volume = '',
    this.Unit = '',
    this.Package_Weight = '',
  });

  String ID;
  String Mat_CP;
  String Chm;
  String Volume;
  String Unit;
  String Package_Weight;

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'Mat_CP': Mat_CP,
      'Chm': Chm,
      'Volume': Volume,
      'Unit': Unit,
      'Package_Weight': Package_Weight
    };
  }

  factory STDWeightclass.fromJson(Map<String, dynamic> json) => STDWeightclass(
        ID: json["ID"].toString() ?? "",
        Mat_CP: json["Mat_CP"].toString() ?? "",
        Chm: json["Chm"].toString() ?? "",
        Volume: json["Volume"].toString() ?? "",
        Unit: json["Unit"].toString() ?? "",
        Package_Weight: json["Package_Weight"].toString() ?? "",
      );
}
