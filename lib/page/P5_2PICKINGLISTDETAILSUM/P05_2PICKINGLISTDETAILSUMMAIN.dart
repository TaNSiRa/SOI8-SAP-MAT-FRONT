// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, use_build_context_synchronously
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/05-03-P05_2PICKINGLISTDETAILSUMGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import 'P05_2PICKINGLISTDETAILSUMVAR.dart';

late BuildContext P05_2PICKINGLISTDETAILSUMMAINcontext;

class P05_2PICKINGLISTDETAILSUMMAIN extends StatefulWidget {
  P05_2PICKINGLISTDETAILSUMMAIN({
    super.key,
    this.data,
  });
  List<P05_2PICKINGLISTDETAILSUMGETDATAclass>? data;

  @override
  State<P05_2PICKINGLISTDETAILSUMMAIN> createState() =>
      _P05_2PICKINGLISTDETAILSUMMAINState();
}

class _P05_2PICKINGLISTDETAILSUMMAINState
    extends State<P05_2PICKINGLISTDETAILSUMMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P05_2PICKINGLISTDETAILSUMGETDATA_Bloc>()
        .add(P05_2PICKINGLISTDETAILSUMGETDATA_GET());
    P05_2PICKINGLISTDETAILSUMVAR.iscontrol = true;
    P05_2PICKINGLISTDETAILSUMVAR.SEARCH = '';
  }

  @override
  Widget build(BuildContext context) {
    P05_2PICKINGLISTDETAILSUMMAINcontext = context;
    List<double> columnDatawidth = [50, 300, 150, 300];
    double columnHeadwidth = columnDatawidth.reduce((a, b) => a + b);

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
                    'PICKING LIST SUMMARY DETAIL',
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
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: dataHead.length,
                itemBuilder: (context, index) {
                  print(dataHead.length);
                  return Column(
                    children: [
                      Container(
                          height: 40,
                          width: columnHeadwidth,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border(
                              top: BorderSide(color: Colors.black, width: 1),
                              left: BorderSide(color: Colors.black, width: 1),
                              right: BorderSide(color: Colors.black, width: 1),
                              // เฉพาะตัวสุดท้ายให้มีเส้นล่าง
                              bottom: index == dataHead.length - 1
                                  ? BorderSide(color: Colors.black, width: 1)
                                  : BorderSide.none,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              dataHead[index]['ST_Sep'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
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
                          0: FixedColumnWidth(columnDatawidth[0]),
                          1: FixedColumnWidth(columnDatawidth[1]),
                          2: FixedColumnWidth(columnDatawidth[2]),
                          3: FixedColumnWidth(columnDatawidth[3]),
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                            ],
                          ),
                          ...dataHead[index]['Mat'].map((item) {
                            int dataCount =
                                dataHead[index]['Mat'].indexOf(item) + 1;
                            return TableRow(
                              children: [
                                TableCell(
                                  child: SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: Text(dataCount.toString()),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: Text(item['Mat_Name']),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: Text(
                                        item['Mat_Quantity'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            item['isShowBC'] =
                                                !item['isShowBC'];
                                          });
                                        },
                                        child: item['isShowBC']
                                            ? SizedBox(
                                                height: 80,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: BarcodeWidget(
                                                      barcode: Barcode.code128(
                                                          escapes: true),
                                                      data:
                                                          '${item['Mat_CP']}${item['Mat_Quantity']}',
                                                      width: 200,
                                                      // height: 120,
                                                      drawText: true,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 80,
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
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
         
            const SizedBox(height: 5),
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
      return Colors.green;
    default:
      return Colors.red;
  }
}
