// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, use_build_context_synchronously
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/05-02-P05_1PICKINGLISTDETAILGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import 'P05_1PICKINGLISTDETAILVAR.dart';

late BuildContext P05_1PICKINGLISTDETAILMAINcontext;

class P05_1PICKINGLISTDETAILMAIN extends StatefulWidget {
  P05_1PICKINGLISTDETAILMAIN({
    super.key,
    this.data,
  });
  List<P05_1PICKINGLISTDETAILGETDATAclass>? data;

  @override
  State<P05_1PICKINGLISTDETAILMAIN> createState() =>
      _P05_1PICKINGLISTDETAILMAINState();
}

class _P05_1PICKINGLISTDETAILMAINState
    extends State<P05_1PICKINGLISTDETAILMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P05_1PICKINGLISTDETAILGETDATA_Bloc>()
        .add(P05_1PICKINGLISTDETAILGETDATA_GET());
    P05_1PICKINGLISTDETAILVAR.iscontrol = true;
    P05_1PICKINGLISTDETAILVAR.SEARCH = '';
  }

  @override
  Widget build(BuildContext context) {
    P05_1PICKINGLISTDETAILMAINcontext = context;
    List<P05_1PICKINGLISTDETAILGETDATAclass> _datain = widget.data ?? [];
    List<P05_1PICKINGLISTDETAILGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      _datain.where(
        (data) =>
            data.OrderNo.toLowerCase()
                .contains(P05_1PICKINGLISTDETAILVAR.SEARCH) ||
            data.ProductName.toLowerCase()
                .contains(P05_1PICKINGLISTDETAILVAR.SEARCH) ||
            data.Quantity.toLowerCase()
                .contains(P05_1PICKINGLISTDETAILVAR.SEARCH) ||
            data.Tank.toLowerCase()
                .contains(P05_1PICKINGLISTDETAILVAR.SEARCH) ||
            data.Lot.toLowerCase().contains(P05_1PICKINGLISTDETAILVAR.SEARCH) ||
            data.Order_Start_DT.toLowerCase()
                .contains(P05_1PICKINGLISTDETAILVAR.SEARCH) ||
            data.Order_Status.toLowerCase()
                .contains(P05_1PICKINGLISTDETAILVAR.SEARCH),
      ),
    );
    if (_datasearch.isNotEmpty &&
        (_datasearch[0].Order_Status == 'SAP' ||
            _datasearch[0].Order_Status == 'UNSUGGEST')) {
      P05_1PICKINGLISTDETAILVAR.ColumnWidth3 = 100.0;
      P05_1PICKINGLISTDETAILVAR.ColumnWidth4 = 200.0;
      P05_1PICKINGLISTDETAILVAR.ColumnWidthProduction = 850;
      P05_1PICKINGLISTDETAILVAR.ColumnWidthProcessOrder = 225;
      P05_1PICKINGLISTDETAILVAR.ColumnWidthNo = 225;
    } else {
      P05_1PICKINGLISTDETAILVAR.ColumnWidth3 = 200.0;
      P05_1PICKINGLISTDETAILVAR.ColumnWidth4 = 100.0;
      P05_1PICKINGLISTDETAILVAR.ColumnWidthProduction = 1050;
      P05_1PICKINGLISTDETAILVAR.ColumnWidthProcessOrder = 325;
      P05_1PICKINGLISTDETAILVAR.ColumnWidthNo = 325;
    }

    Map<String, String> comparisonMap = {
      "TT": "Titrating",
      "PD": "Powder",
      "LQ": "Liquid",
      "NR": "Nox rust",
    };
    if (_datasearch.isNotEmpty) {
      P05_1PICKINGLISTDETAILVAR.switchPlant =
          comparisonMap[_datasearch[0].ST_Sep] ?? _datasearch[0].ST_Sep;
    }

    return Scaffold(
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: const [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'PICKING LIST DETAIL',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (_datasearch.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Table(
                    border: TableBorder.all(),
                    columnWidths: {
                      0: FixedColumnWidth(
                          P05_1PICKINGLISTDETAILVAR.ColumnWidthProcessOrder),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 20,
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    'ใบสั่งผลิต (Process order)',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  _datasearch[0].ProductName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: BarcodeWidget(
                                  padding: EdgeInsets.all(5),
                                  barcode: Barcode.code128(escapes: false),
                                  data: _datasearch[0].MainOrder,
                                  width: 200,
                                  height: 50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 20,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            P05_1PICKINGLISTDETAILVAR.switchPlant,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Table(
                        border: TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            verticalInside: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                              width: 1,
                            )),
                        columnWidths: const {
                          0: FixedColumnWidth(100.0),
                          1: FixedColumnWidth(100.0),
                          2: FixedColumnWidth(100.0),
                          3: FixedColumnWidth(100.0),
                        },
                        children: [
                          TableRow(
                            children: const [
                              TableCell(
                                child: SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      'Quantity',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      'Tank',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      'Lot. No',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      'Status',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                            '${_datasearch[0].Quantity} ${_datasearch[0].UOM}'),
                                      ),
                                      BarcodeWidget(
                                        padding: EdgeInsets.only(
                                            top: 0,
                                            bottom: 0,
                                            left: 5,
                                            right: 5),
                                        barcode:
                                            Barcode.code128(escapes: false),
                                        data: _datasearch[0].Quantity,
                                        drawText: false,
                                        //width: 200,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(_datasearch[0].Tank),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(_datasearch[0].Lot),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      _datasearch[0].Order_Status,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(
                                            _datasearch[0].Order_Status),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Table(
                        border: TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            verticalInside: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            top: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                              width: 1,
                            )),
                        columnWidths: {
                          0: FixedColumnWidth(
                              P05_1PICKINGLISTDETAILVAR.ColumnWidthNo),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 19,
                                  child: Container(
                                      color: Colors.grey,
                                      child: Row(
                                        children: [
                                          Text(
                                            ' No.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              _datasearch[0].OrderNo,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 90,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(_datasearch[0].OrderNo),
                                        ),
                                      ),
                                      Center(
                                        child: BarcodeWidget(
                                          padding: EdgeInsets.all(5),
                                          barcode:
                                              Barcode.code128(escapes: false),
                                          data: _datasearch[0].OrderNo,
                                          height: 50,
                                          width: 150,
                                          drawText: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            if (_datasearch.isNotEmpty)
              Container(
                height: 20,
                width: P05_1PICKINGLISTDETAILVAR.ColumnWidthProduction,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border(
                      right: BorderSide(color: Colors.black, width: 1.0),
                      left: BorderSide(color: Colors.black, width: 1.0),
                      bottom: BorderSide(color: Colors.black, width: 1.0),
                    )),
                child: Center(
                  child: Text(
                    'Production',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            if (_datasearch.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      verticalInside: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(50.0),
                      1: FixedColumnWidth(100.0),
                      2: FixedColumnWidth(100.0),
                      3: FixedColumnWidth(
                          P05_1PICKINGLISTDETAILVAR.ColumnWidth3),
                      4: FixedColumnWidth(
                          P05_1PICKINGLISTDETAILVAR.ColumnWidth4),
                      5: FixedColumnWidth(100.0),
                      6: FixedColumnWidth(200.0),
                      7: FixedColumnWidth(100.0),
                      8: FixedColumnWidth(100.0),
                      9: FixedColumnWidth(100.0),
                      10: FixedColumnWidth(100.0),
                      11: FixedColumnWidth(100.0),
                    },
                    children: [
                      TableRow(
                        children: [
                          const TableCell(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Item',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          const TableCell(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Code',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: const [
                                      TextSpan(
                                        text: 'Total\nQuantity ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'SAP',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (_datasearch[0].Order_Status == 'SAP' ||
                              _datasearch[0].Order_Status == 'UNSUGGEST')
                            TableCell(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: const [
                                        TextSpan(
                                          text: 'Total\nQuantity ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'SCADA',
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const TableCell(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Std Accept\n±2%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          const TableCell(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Package\nQuantity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          const TableCell(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Lot.No.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (_datasearch[0].Order_Status != 'SAP' &&
                              _datasearch[0].Order_Status != 'UNSUGGEST')
                            TableCell(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(
                                    'Mat No. Enter Qty.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          const TableCell(
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Raw Mat Status',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (_datasearch[0].Order_Status != 'SAP' &&
                              _datasearch[0].Order_Status != 'UNSUGGEST')
                            const TableCell(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(
                                    'Remark',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      ..._datasearch.map((item) {
                        int dataCount = _datasearch.indexOf(item) + 1;
                        return TableRow(
                          children: [
                            TableCell(
                              child: SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(dataCount.toString()),
                                ),
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(item.Mat_Name),
                                ),
                              ),
                            ),
                            TableCell(
                              child: SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    '${double.tryParse(item.Mat_Quantity)?.toStringAsFixed(3).replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '')} ${item.Mat_UOM}',
                                    style: TextStyle(
                                      color: _datasearch[0].Order_Status !=
                                                  'SAP' &&
                                              _datasearch[0].Order_Status !=
                                                  'UNSUGGEST'
                                          ? Colors.black
                                          : (double.tryParse(
                                                      item.Mat_Quantity) !=
                                                  double.tryParse(
                                                      item.Mat_Quantity_Scada)
                                              ? Colors.red
                                              : Colors.green),
                                      fontWeight: _datasearch[0].Order_Status !=
                                                  'SAP' &&
                                              _datasearch[0].Order_Status !=
                                                  'UNSUGGEST'
                                          ? FontWeight.normal
                                          : FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (_datasearch[0].Order_Status == 'SAP' ||
                                _datasearch[0].Order_Status == 'UNSUGGEST')
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                      '${double.tryParse(item.Mat_Quantity_Scada)?.toStringAsFixed(3).replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '')} ${item.Mat_Sep_UOM}',
                                      style: TextStyle(
                                        color: double.tryParse(
                                                    item.Mat_Quantity) !=
                                                double.tryParse(
                                                    item.Mat_Quantity_Scada)
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            TableCell(
                              child: SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(
                                      '${((double.tryParse(item.Mat_Quantity) ?? 0) * 0.98).toStringAsFixed(3).replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '')} - '
                                      '${((double.tryParse(item.Mat_Quantity) ?? 0) * 1.02).toStringAsFixed(3).replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '')}'),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        (item.Mat_Full_SP != null)
                                            ? item.Mat_Full_SP + ' ' + item.Mat_Full_UOM
                                            : '',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                    ),
                                    child: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          (item.Mat_Sep_SP != null)
                                              ? item.Mat_Sep_SP + ' ' + item.Mat_Sep_UOM
                                              : '',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TableCell(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: (item.Mat_SAP_Lot3.isNotEmpty)
                                        ? 20
                                        : (item.Mat_SAP_Lot2.isNotEmpty)
                                            ? 30
                                            : 60,
                                    child: Center(
                                      child: Text(
                                        item.Mat_SAP_Lot1,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  if (item.Mat_SAP_Lot2.isNotEmpty)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.black, width: 1),
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: (item.Mat_SAP_Lot3.isNotEmpty)
                                            ? 20
                                            : 30,
                                        child: Center(
                                          child: Text(
                                            item.Mat_SAP_Lot2,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (item.Mat_SAP_Lot3.isNotEmpty)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.black, width: 1),
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: 20,
                                        child: Center(
                                          child: Text(
                                            item.Mat_SAP_Lot3,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (_datasearch[0].Order_Status != 'SAP' &&
                                _datasearch[0].Order_Status != 'UNSUGGEST')
                              TableCell(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          item.isShowBC = !item.isShowBC;
                                        });
                                      },
                                      child: item.isShowBC
                                          ? SizedBox(
                                              height: 60,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: BarcodeWidget(
                                                    barcode: Barcode.code128(
                                                        escapes: true),
                                                    data:
                                                        '${item.Mat_CP}${item.Mat_Quantity}',
                                                    //width: 70,
                                                    // height: 120,
                                                    drawText: true,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 60,
                                              child: Center(
                                                child: const Icon(
                                                  Icons.barcode_reader,
                                                  color: Colors.blue,
                                                  size: 30,
                                                ),
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                            TableCell(
                              child: SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    item.Mat_Status,
                                    style: TextStyle(fontSize: 14,color: _getStatusColor(item.Mat_Status)),
                                  ),
                                ),
                              ),
                            ),
                            if (_datasearch[0].Order_Status != 'SAP' &&
                                _datasearch[0].Order_Status != 'UNSUGGEST')
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                      item.Remark,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'SAP':
    case 'UNSUGGEST':
      return Colors.yellow.shade700;
    case 'GEN SEP':
    case 'SEP':
    case 'FULL':
    case 'SEP/FULL':
      return Colors.blue;
    case 'RECHECK':
    case 'TITRATING':
      return Colors.orange;
    case 'COMPLETE':
    case 'Auto':
      return Colors.green;
    default:
      return Colors.red;
  }
}
