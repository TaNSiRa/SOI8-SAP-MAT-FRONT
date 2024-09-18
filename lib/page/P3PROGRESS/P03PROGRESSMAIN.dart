// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/03-01-P03PROGRESSGETDATA.dart';

late BuildContext P03PROGRESSMAINcontext;

class P03PROGRESSMAIN extends StatefulWidget {
  P03PROGRESSMAIN({
    super.key,
    this.data,
  });
  List<P03PROGRESSGETDATAclass>? data;

  @override
  State<P03PROGRESSMAIN> createState() => _P03PROGRESSMAINState();
}

class _P03PROGRESSMAINState extends State<P03PROGRESSMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P03PROGRESSGETDATA_Bloc>().add(P03PROGRESSGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P03PROGRESSMAINcontext = context;
    List<P03PROGRESSGETDATAclass> _datain = widget.data ?? [];
    // print(_datain);
    List<Map<String, dynamic>> _convertData(
        List<P03PROGRESSGETDATAclass> data) {
      return data.map((item) {
        return {
          'month': item.MONTH,
          'achieved': double.tryParse(item.ACHIEVED.toString()) ?? 0.0,
        };
      }).toList();
    }

    List<Map<String, dynamic>> transformedData = _convertData(_datain);

    return Stack(
      children: [
        // Positioned(
        //   top: 10,
        //   left: 10,
        //   child: IconButton(
        //     icon: Icon(Icons.arrow_back_ios_new_rounded, size: 30),
        //     onPressed: () {
        //       CuPage = Page10();
        //       MainBodyContext.read<ChangePage_Bloc>()
        //           .add(ChangePage_nodrower());
        //     },
        //   ),
        // ),
        // Positioned(
        //   top: 10,
        //   right: 50,
        //   child: Column(
        //     children: [
        //       ElevatedButton(
        //         onPressed: () {
        //           context
        //               .read<P03PROGRESSGETDATA_Bloc>()
        //               .add(P03PROGRESSGETDATA_GET());
        //         },
        //         style: ElevatedButton.styleFrom(
        //           shape: const CircleBorder(),
        //           padding: const EdgeInsets.all(10),
        //           backgroundColor: Colors.black,
        //         ),
        //         child: const Icon(
        //           Icons.refresh_rounded,
        //           color: Colors.white,
        //           size: 30,
        //         ),
        //       ),
        //       SizedBox(height: 5),
        //       Text(
        //         'Refresh',
        //         style: TextStyle(
        //             fontSize: 10,
        //             color: Colors.black,
        //             fontWeight: FontWeight.bold),
        //       )
        //     ],
        //   ),
        // ),
        SingleChildScrollView(
          child: Column(
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
                      'SAR : Report Performance',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '% Achieved Customer Group A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: 800,
                  ),
                  Positioned(
                    top: 50,
                    right: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          'Target : 100%',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              SizedBox(height: 20),
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FixedColumnWidth(120),
                  1: FixedColumnWidth(55),
                  2: FixedColumnWidth(55),
                  3: FixedColumnWidth(55),
                  4: FixedColumnWidth(55),
                  5: FixedColumnWidth(55),
                  6: FixedColumnWidth(55),
                  7: FixedColumnWidth(55),
                  8: FixedColumnWidth(55),
                  9: FixedColumnWidth(55),
                  10: FixedColumnWidth(55),
                  11: FixedColumnWidth(55),
                  12: FixedColumnWidth(55),
                  13: FixedColumnWidth(55),
                  14: FixedColumnWidth(55),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Month',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                      ...transformedData.map((data) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data['month'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          )),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('% Achieved Customer',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                      ...transformedData.map(
                        (data) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['achieved'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
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
