// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/06-01-P06PROGRESSGETDATA.dart';

late BuildContext P06PROGRESSMAINcontext;

class P06PROGRESSMAIN extends StatefulWidget {
  P06PROGRESSMAIN({
    super.key,
    this.data,
  });
  List<P06PROGRESSGETDATAclass>? data;

  @override
  State<P06PROGRESSMAIN> createState() => _P06PROGRESSMAINState();
}

class _P06PROGRESSMAINState extends State<P06PROGRESSMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P06PROGRESSGETDATA_Bloc>().add(P06PROGRESSGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P06PROGRESSMAINcontext = context;
    List<P06PROGRESSGETDATAclass> _datain = widget.data ?? [];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: const [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'SAR : Service Report',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FixedColumnWidth(25),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: SizedBox(
                          height: 80,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'NO.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ..._datain.map((item) {
                  //   int dataCount = _datain.indexOf(item) + 1;
                  //   return TableRow(
                  //     children: [
                  //       TableCell(
                  //         child: SizedBox(
                  //           height: 20,
                  //           child: Center(
                  //             child: Text(
                  //               dataCount.toString(),
                  //               style: TextStyle(fontSize: 10),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   );
                  // }),
                ],
              ),
              Column(
                children: [
                  Table(
                    border: TableBorder(
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    columnWidths: const {
                      0: FixedColumnWidth(100),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: SizedBox(
                              height: 80,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    'Type',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // if (groupADataCount > 0 &&
                  //     uniqueTypesList.contains('Group A'))
                  // Container(
                  //   // height: max(groupADataCount * 20, 0.5) - 0.5,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       top: BorderSide(
                  //         color: Colors.black,
                  //         width: 1,
                  //       ),
                  //     ),
                  //   ),
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       'Group A: Long\nsample preparation\ntime',
                  //       style: TextStyle(fontSize: 10),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                  // if (groupBDataCount > 0 &&
                  //     uniqueTypesList.contains('Group B'))
                  // Container(
                  //   // height: groupBDataCount * 20 + 0.5,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       top: BorderSide(
                  //         color: Colors.black,
                  //         width: 1,
                  //       ),
                  //       bottom: BorderSide(
                  //         color: Colors.black,
                  //         width: 1,
                  //       ),
                  //     ),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       'Group B: Other\n(Not long sample\npreparation time)',
                  //       style: TextStyle(fontSize: 10),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FixedColumnWidth(50),
                  1: FixedColumnWidth(100),
                  2: FixedColumnWidth(50),
                  3: FixedColumnWidth(70),
                  4: FixedColumnWidth(70),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: SizedBox(
                          height: 80,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Group',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 80,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Customer and line',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 80,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'KPI\n(Days)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 80,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Frequency\n(Time/Month)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 80,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Incharge',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ..._datain.map((item) {
                  //   return TableRow(
                  //     children: [
                  //       TableCell(
                  //         child: SizedBox(
                  //           height: 20,
                  //           child: Center(
                  //               child: Text(
                  //             item.GROUP,
                  //             style: TextStyle(fontSize: 10),
                  //           )),
                  //         ),
                  //       ),
                  //       TableCell(
                  //         child: SizedBox(
                  //           height: 20,
                  //           child: Align(
                  //             alignment: Alignment.centerLeft,
                  //             child: Text(
                  //               ' ${item.CUSTOMER}',
                  //               style: TextStyle(fontSize: 10),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       TableCell(
                  //         child: SizedBox(
                  //           height: 20,
                  //           child: Center(
                  //             child: Text(
                  //               item.FREQUENCY,
                  //               style: TextStyle(fontSize: 10),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       TableCell(
                  //         child: SizedBox(
                  //           height: 20,
                  //           child: Center(
                  //             child: Text(
                  //               item.INCHARGE,
                  //               style: TextStyle(fontSize: 10),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   );
                  // }),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                    width: 550,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
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
                          'Operation (Date-Month-Year)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Row(
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
                          0: FixedColumnWidth(50),
                          1: FixedColumnWidth(50),
                          2: FixedColumnWidth(50),
                          3: FixedColumnWidth(50),
                          4: FixedColumnWidth(50),
                          5: FixedColumnWidth(50),
                          6: FixedColumnWidth(50),
                          7: FixedColumnWidth(50),
                          8: FixedColumnWidth(50),
                          9: FixedColumnWidth(50),
                          10: FixedColumnWidth(50),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Sampling',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Request\nsample',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'TTC\nresult',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Due date',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Issue date',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Revise\nreport',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Sub lead\nsign',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'GL. sign',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Mgr.\nsign',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'JP. sign',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Send to\ncustomer',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ..._datain.map((item) {
                          //   return TableRow(
                          //     children: [
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //               child: Text(
                          //             item.GROUP,
                          //             style: TextStyle(fontSize: 10),
                          //           )),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Align(
                          //             alignment: Alignment.centerLeft,
                          //             child: Text(
                          //               ' ${item.CUSTOMER}',
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //             child: Text(
                          //               item.FREQUENCY,
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //             child: Text(
                          //               item.INCHARGE,
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   );
                          // }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                    width: 550,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
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
                          'Break down working Day (Day)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Row(
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
                          0: FixedColumnWidth(50),
                          1: FixedColumnWidth(50),
                          2: FixedColumnWidth(50),
                          3: FixedColumnWidth(50),
                          4: FixedColumnWidth(50),
                          5: FixedColumnWidth(50),
                          6: FixedColumnWidth(50),
                          7: FixedColumnWidth(50),
                          8: FixedColumnWidth(50),
                          9: FixedColumnWidth(50),
                          10: FixedColumnWidth(50),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Prepare\n+Request\nsample',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'TTC\nanalysis',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Issue\nreport\nafter\nTTC\nanalysis',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Revise\nreport',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Sub lead\nsign',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'GL\nsign',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Mgr\nsign',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Jp. sign',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Sent to\ncustomer',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Total Day\n(amount)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Over due\n(Days)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ..._datain.map((item) {
                          //   return TableRow(
                          //     children: [
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //               child: Text(
                          //             item.GROUP,
                          //             style: TextStyle(fontSize: 10),
                          //           )),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Align(
                          //             alignment: Alignment.centerLeft,
                          //             child: Text(
                          //               ' ${item.CUSTOMER}',
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //             child: Text(
                          //               item.FREQUENCY,
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //             child: Text(
                          //               item.INCHARGE,
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   );
                          // }),
                        ],
                      ),
                    ],
                  ),
                ],
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
                  top: BorderSide(
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
                  0: FixedColumnWidth(250),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: SizedBox(
                          height: 80,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Reason',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ..._datain.map((item) {
                  //   int dataCount = _datain.indexOf(item) + 1;
                  //   return TableRow(
                  //     children: [
                  //       TableCell(
                  //         child: SizedBox(
                  //           height: 20,
                  //           child: Center(
                  //             child: Text(
                  //               dataCount.toString(),
                  //               style: TextStyle(fontSize: 10),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   );
                  // }),
                ],
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
                  top: BorderSide(
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
                  0: FixedColumnWidth(250),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: SizedBox(
                          height: 80,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Action',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ..._datain.map((item) {
                  //   int dataCount = _datain.indexOf(item) + 1;
                  //   return TableRow(
                  //     children: [
                  //       TableCell(
                  //         child: SizedBox(
                  //           height: 20,
                  //           child: Center(
                  //             child: Text(
                  //               dataCount.toString(),
                  //               style: TextStyle(fontSize: 10),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   );
                  // }),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                    width: 460,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
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
                          'Break down working Day (Day)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Row(
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
                          0: FixedColumnWidth(50),
                          1: FixedColumnWidth(50),
                          2: FixedColumnWidth(50),
                          3: FixedColumnWidth(70),
                          4: FixedColumnWidth(50),
                          5: FixedColumnWidth(50),
                          6: FixedColumnWidth(90),
                          7: FixedColumnWidth(50),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Follow up\nOther\nProject',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'TTC Result\nLate',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Revise\nReport',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Approved\nfrom Leader\n,JP and MGR',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Re-check\nResult from\nTTC',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Prepare\nSample long\ntime',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Forgot Request Sample,Make Report,Send report',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 60,
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Other\n(Covid)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ..._datain.map((item) {
                          //   return TableRow(
                          //     children: [
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //               child: Text(
                          //             item.GROUP,
                          //             style: TextStyle(fontSize: 10),
                          //           )),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Align(
                          //             alignment: Alignment.centerLeft,
                          //             child: Text(
                          //               ' ${item.CUSTOMER}',
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //             child: Text(
                          //               item.FREQUENCY,
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       TableCell(
                          //         child: SizedBox(
                          //           height: 20,
                          //           child: Center(
                          //             child: Text(
                          //               item.INCHARGE,
                          //               style: TextStyle(fontSize: 10),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   );
                          // }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
