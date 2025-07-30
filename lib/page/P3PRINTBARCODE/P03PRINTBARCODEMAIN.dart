// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/03-01-P03PRINTBARCODEGETDATA.dart';
import '../../widget/common/Loading.dart';
import '../../widget/function/helper.dart';
import 'P03PRINTBARCODEVAR.dart';

late BuildContext P03PRINTBARCODEMAINcontext;
ScrollController _controllerIN01 = ScrollController();
final GlobalKey _globalKey = GlobalKey();

class P03PRINTBARCODEMAIN extends StatefulWidget {
  P03PRINTBARCODEMAIN({
    super.key,
    this.data,
  });
  List<P03PRINTBARCODEGETDATAclass>? data;

  @override
  State<P03PRINTBARCODEMAIN> createState() => _P03PRINTBARCODEMAINState();
}

class _P03PRINTBARCODEMAINState extends State<P03PRINTBARCODEMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P03PRINTBARCODEGETDATA_Bloc>()
        .add(P03PRINTBARCODEGETDATA_GET());
    P03PRINTBARCODEVAR.iscontrol = true;
    P03PRINTBARCODEVAR.SEARCH = '';
  }

  @override
  Widget build(BuildContext context) {
    P03PRINTBARCODEMAINcontext = context;
    List<P03PRINTBARCODEGETDATAclass> _datain = widget.data ?? [];
    List<Map<String, dynamic>> dataForApi =
        _datain.map((item) => item.toJson()).toList();

    List<P03PRINTBARCODEGETDATAclass> _datasearch = [];
    _datasearch.addAll(
      _datain.where(
        (data) =>
            data.PDNAME.toLowerCase().contains(P03PRINTBARCODEVAR.SEARCH) ||
            data.QUANTITY.toLowerCase().contains(P03PRINTBARCODEVAR.SEARCH) ||
            data.TANK.toLowerCase().contains(P03PRINTBARCODEVAR.SEARCH) ||
            data.LOT.toLowerCase().contains(P03PRINTBARCODEVAR.SEARCH) ||
            data.ORDERNO.toLowerCase().contains(P03PRINTBARCODEVAR.SEARCH) ||
            data.STDATE.toLowerCase().contains(P03PRINTBARCODEVAR.SEARCH) ||
            data.STATUS.toLowerCase().contains(P03PRINTBARCODEVAR.SEARCH),
      ),
    );

    for (var data in _datasearch) {
      if (!P03PRINTBARCODEVAR.groupedData.containsKey(data.ORDERNO)) {
        P03PRINTBARCODEVAR.groupedData[data.ORDERNO] = [];
      }
      P03PRINTBARCODEVAR.groupedData[data.ORDERNO]!.add(data);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: const [
                          Colors.blueAccent,
                          Colors.lightBlueAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        'Print Barcode',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        P03PRINTBARCODEVAR.jsonData = jsonEncode(dataForApi);
                        context
                            .read<P03PRINTBARCODEGETDATA_Bloc>()
                            .add(P03PRINTBARCODEGETDATA_GET2());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Icon(
                        Icons.print,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_datasearch.isNotEmpty)
              ...P03PRINTBARCODEVAR.groupedData.entries.map((entry) {
                // print(groupedData);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Table(
                          border: TableBorder.all(),
                          columnWidths: const {
                            0: FixedColumnWidth(150.0),
                            1: FixedColumnWidth(150.0),
                            2: FixedColumnWidth(150.0),
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
                                          'Process order',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    height: 20,
                                    child: Container(
                                      color: Colors.grey,
                                      child: Center(
                                        child: Text(
                                          'Quantity',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    height: 20,
                                    child: Container(
                                      color: Colors.grey,
                                      child: Center(
                                        child: Text(
                                          'Lot. No.',
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
                                      child: Text(entry.value[0].PDNAME),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    height: 70,
                                    child: Center(
                                      child: Text(entry.value[0].QUANTITY),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    height: 70,
                                    child: Center(
                                      child: Text(entry.value[0].LOT),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
                          columnWidths: const {
                            0: FixedColumnWidth(150.0),
                            1: FixedColumnWidth(150.0),
                            2: FixedColumnWidth(150.0),
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
                                          'Mat.',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    height: 20,
                                    child: Container(
                                      color: Colors.grey,
                                      child: Center(
                                        child: Text(
                                          'Code',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    height: 20,
                                    child: Container(
                                      color: Colors.grey,
                                      child: Center(
                                        child: Text(
                                          'Quantity',
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
                            ...entry.value.map((item) {
                              return TableRow(
                                children: [
                                  /* TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SfBarcodeGenerator(
                                            value: item.MAT,
                                            symbology: Code93(),
                                            showValue: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ), */
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Center(
                                        child: Text(item.CODE),
                                      ),
                                    ),
                                  ),
                                  /* TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SfBarcodeGenerator(
                                            value: item.TTQUANTITY,
                                            symbology: Code93(),
                                            showValue: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ), */
                                ],
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }
}
