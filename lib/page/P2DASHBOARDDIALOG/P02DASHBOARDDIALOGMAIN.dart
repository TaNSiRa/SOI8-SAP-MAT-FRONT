// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/01-01-P01DASHBOARDGETDATA.dart';
import '../../bloc/BlocEvent/02-01-P02DASHBOARDDIALOGGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import '../P1DASHBOARD/P01DASHBOARDMAIN.dart';
import 'P02DASHBOARDDIALOGVAR.dart';

late BuildContext P02DASHBOARDDIALOGMAINcontext;

class P02DASHBOARDDIALOGMAIN extends StatefulWidget {
  P02DASHBOARDDIALOGMAIN({
    super.key,
    this.data,
  });
  List<P02DASHBOARDDIALOGGETDATAclass>? data;

  @override
  State<P02DASHBOARDDIALOGMAIN> createState() => _P02DASHBOARDDIALOGMAINState();
}

class _P02DASHBOARDDIALOGMAINState extends State<P02DASHBOARDDIALOGMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P02DASHBOARDDIALOGGETDATA_Bloc>()
        .add(P02DASHBOARDDIALOGGETDATA_GET());
    P02DASHBOARDDIALOGVAR.iscontrol = true;
    P02DASHBOARDDIALOGVAR.SEARCH = '';
  }

  @override
  Widget build(BuildContext context) {
    P02DASHBOARDDIALOGMAINcontext = context;
    List<P02DASHBOARDDIALOGGETDATAclass> _datain = widget.data ?? [];
    List<P02DASHBOARDDIALOGGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      _datain.where(
        (data) =>
            data.OrderNo.toLowerCase().contains(P02DASHBOARDDIALOGVAR.SEARCH) ||
            data.ProductName.toLowerCase()
                .contains(P02DASHBOARDDIALOGVAR.SEARCH) ||
            data.Quantity.toLowerCase()
                .contains(P02DASHBOARDDIALOGVAR.SEARCH) ||
            data.Tank.toLowerCase().contains(P02DASHBOARDDIALOGVAR.SEARCH) ||
            data.Lot.toLowerCase().contains(P02DASHBOARDDIALOGVAR.SEARCH) ||
            data.Order_Start_DT.toLowerCase()
                .contains(P02DASHBOARDDIALOGVAR.SEARCH) ||
            data.Order_Status.toLowerCase()
                .contains(P02DASHBOARDDIALOGVAR.SEARCH),
      ),
    );
    if (_datasearch.isNotEmpty && _datasearch[0].Order_Status == 'SAP') {
      P02DASHBOARDDIALOGVAR.ColumnWidth4 = 100.0;
      P02DASHBOARDDIALOGVAR.ColumnWidth5 = 200.0;
      P02DASHBOARDDIALOGVAR.ColumnWidthProduction = 950;
      P02DASHBOARDDIALOGVAR.ColumnWidthProcessOrder = 225;
      P02DASHBOARDDIALOGVAR.ColumnWidthNo = 225;
    } else {
      P02DASHBOARDDIALOGVAR.ColumnWidth4 = 200.0;
      P02DASHBOARDDIALOGVAR.ColumnWidth5 = 100.0;
      P02DASHBOARDDIALOGVAR.ColumnWidthProduction = 1050;
      P02DASHBOARDDIALOGVAR.ColumnWidthProcessOrder = 275;
      P02DASHBOARDDIALOGVAR.ColumnWidthNo = 275;
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
                    'Compare Data between SAP & SCADA',
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
                          P02DASHBOARDDIALOGVAR.ColumnWidthProcessOrder),
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
                              height: 70,
                              child: Center(
                                child: Text(_datasearch[0].ProductName),
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
                        width: 500,
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
                            'ผลิตเคมีผง (Powder Mixing)',
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
                          4: FixedColumnWidth(100.0),
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
                                      'T.Batch',
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
                                      'Batch',
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
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                        '${_datasearch[0].Quantity} ${_datasearch[0].UOM}'),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(_datasearch[0].Tank),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(''),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(_datasearch[0].Lot),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(''),
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
                              P02DASHBOARDDIALOGVAR.ColumnWidthNo),
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
                                  height: 71,
                                  child: Center(
                                    child: Text(_datasearch[0].OrderNo),
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
                width: P02DASHBOARDDIALOGVAR.ColumnWidthProduction,
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
                      3: FixedColumnWidth(100.0),
                      4: FixedColumnWidth(P02DASHBOARDDIALOGVAR.ColumnWidth4),
                      5: FixedColumnWidth(P02DASHBOARDDIALOGVAR.ColumnWidth5),
                      6: FixedColumnWidth(100.0),
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
                          if (_datasearch[0].Order_Status == 'SAP')
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
                                  'Per Batch',
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
                          if (_datasearch[0].Order_Status != 'SAP')
                            TableCell(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(
                                    'Store R/M',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          if (_datasearch[0].Order_Status != 'SAP')
                            TableCell(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(
                                    'Production',
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
                          if (_datasearch[0].Order_Status == 'SAP')
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
                          if (_datasearch[0].Order_Status != 'SAP')
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
                                    double.tryParse(item.Mat_Quantity)
                                            ?.toStringAsFixed(3)
                                            .replaceAll(
                                                RegExp(r'([.]*0+)(?!.*\d)'),
                                                '') ??
                                        item.Mat_Quantity,
                                    style: TextStyle(
                                      color: _datasearch[0].Order_Status !=
                                              'SAP'
                                          ? Colors.black
                                          : (double.tryParse(
                                                      item.Mat_Quantity) !=
                                                  double.tryParse(
                                                      item.Mat_Quantity_Scada)
                                              ? Colors.red
                                              : Colors.green),
                                      fontWeight:
                                          _datasearch[0].Order_Status != 'SAP'
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (_datasearch[0].Order_Status == 'SAP')
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                      double.tryParse(item.Mat_Quantity_Scada)
                                              ?.toStringAsFixed(3)
                                              .replaceAll(
                                                  RegExp(r'([.]*0+)(?!.*\d)'),
                                                  '') ??
                                          item.Mat_Quantity_Scada,
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
                                  child: Text(item.Mat_Quantity),
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
                                        '${double.tryParse(item.Mat_Full_SP)?.toStringAsFixed(3).replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '') ?? item.Mat_Full_SP} ${item.Mat_Full_UOM}',
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
                                          '${double.tryParse(item.Mat_Sep_SP)?.toStringAsFixed(3).replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '') ?? item.Mat_Sep_SP} ${item.Mat_Sep_UOM}',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_datasearch[0].Order_Status != 'SAP')
                              TableCell(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      child: TextFormField(
                                        initialValue: item.Mat_Full_Act_Weight,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d*\.?\d*$')),
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(fontSize: 14),
                                        onChanged: (value) {
                                          item.Mat_Full_Act_Weight = value;
                                        },
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
                                        child: TextFormField(
                                          initialValue: item.Mat_Sep_Act_Weight,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^\d*\.?\d*$')),
                                          ],
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          style: TextStyle(fontSize: 14),
                                          onChanged: (value) {
                                            item.Mat_Sep_Act_Weight = value;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (_datasearch[0].Order_Status != 'SAP')
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d*$')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: TextStyle(fontSize: 14),
                                      onChanged: (value) {},
                                    ),
                                  ),
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
                                        style: TextStyle(fontSize: 10),
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
                                            style: TextStyle(fontSize: 10),
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
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (_datasearch[0].Order_Status == 'SAP')
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: AdvanceDropDown(
                                      hint: "Status",
                                      borderRaio: 0,
                                      borderCO: Colors.transparent,
                                      listdropdown: const [
                                        MapEntry("UnFinish", "UnFinish"),
                                        MapEntry("Auto", "Auto"),
                                        MapEntry("All_Full", "All_Full"),
                                        MapEntry("Finish", "Finish"),
                                        MapEntry("Bypass", "Bypass"),
                                        MapEntry("StandardWeightError",
                                            "StandardWeightError"),
                                      ],
                                      onChangeinside: (d, k) {
                                        setState(() {
                                          item.Mat_Status = d;
                                        });
                                      },
                                      value: item.Mat_Status,
                                      height: 60,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                            if (_datasearch[0].Order_Status != 'SAP')
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: TextFormField(
                                      initialValue: item.Remark,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: TextStyle(fontSize: 14),
                                      maxLines: null,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(
                                            r'^[^\u0E00-\u0E7F]*$')) // กำหนดให้ไม่อนุญาตให้พิมพ์ตัวอักษรภาษาไทย
                                      ],
                                      onChanged: (value) {
                                        item.Remark = value;
                                      },
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
            if (_datasearch.isNotEmpty && _datasearch[0].Order_Status == 'SAP')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: P01DASHBOARDMAINcontext,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: Row(
                            children: const [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Confirmation'),
                            ],
                          ),
                          content: Text(
                            'Are you sure you want to confirm this comparison?',
                            style: TextStyle(fontSize: 14),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel',
                                  style: TextStyle(color: Colors.red)),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                P02DASHBOARDDIALOGVAR.SendAllDataToAPI =
                                    jsonEncode(_datasearch
                                        .map((e) => e.toJson())
                                        .toList());
                                print(P02DASHBOARDDIALOGVAR
                                    .SendAllDataToAPI.length);
                                P02DASHBOARDDIALOGMAINcontext.read<
                                        P02DASHBOARDDIALOGGETDATA_Bloc>()
                                    .add(P02DASHBOARDDIALOGGETDATA_GET2());
                                print('Sent complete');
                                Navigator.of(context).pop();
                                Navigator.of(P02DASHBOARDDIALOGMAINcontext)
                                    .pop();
                                P01DASHBOARDMAINcontext.read<
                                        P01DASHBOARDGETDATA_Bloc>()
                                    .add(P01DASHBOARDGETDATA_GET());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: Text('Confirm',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shadowColor: Colors.blueAccent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.blue, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    'Confirm Compare',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            if (_datasearch.isNotEmpty && _datasearch[0].Order_Status != 'SAP')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: Row(
                            children: const [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Confirmation'),
                            ],
                          ),
                          content: Text(
                            'Are you sure you want to confirm this comparison?',
                            style: TextStyle(fontSize: 14),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel',
                                  style: TextStyle(color: Colors.red)),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                P02DASHBOARDDIALOGVAR.SendAllDataToAPI =
                                    jsonEncode(_datasearch
                                        .map((e) => e.toJson())
                                        .toList());
                                print(P02DASHBOARDDIALOGVAR
                                    .SendAllDataToAPI.length);
                                P02DASHBOARDDIALOGMAINcontext.read<
                                        P02DASHBOARDDIALOGGETDATA_Bloc>()
                                    .add(P02DASHBOARDDIALOGGETDATA_GET2());
                                print('Sent complete');
                                Navigator.of(context).pop();
                                Navigator.of(P02DASHBOARDDIALOGMAINcontext)
                                    .pop();
                                P01DASHBOARDMAINcontext.read<
                                        P01DASHBOARDGETDATA_Bloc>()
                                    .add(P01DASHBOARDGETDATA_GET());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: Text('Confirm',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shadowColor: Colors.blueAccent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.blue, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    'Send to SAP',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
