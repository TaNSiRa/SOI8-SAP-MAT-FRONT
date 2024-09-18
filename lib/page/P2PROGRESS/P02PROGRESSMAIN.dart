// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02PROGRESSGETDATA.dart';

late BuildContext P02PROGRESSMAINcontext;

class P02PROGRESSMAIN extends StatefulWidget {
  P02PROGRESSMAIN({
    super.key,
    this.data,
  });
  List<P02PROGRESSGETDATAclass>? data;

  @override
  State<P02PROGRESSMAIN> createState() => _P02PROGRESSMAINState();
}

class _P02PROGRESSMAINState extends State<P02PROGRESSMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P02PROGRESSGETDATA_Bloc>().add(P02PROGRESSGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P02PROGRESSMAINcontext = context;
    List<P02PROGRESSGETDATAclass> _datain = widget.data ?? [];
    // print(_datain);
    List<Map<String, dynamic>> _convertData(
        List<P02PROGRESSGETDATAclass> data) {
      return data.map((item) {
        return {
          'topic': item.TOPIC,
          'target': double.tryParse(item.TARGET.toString()) ?? 0.0,
          'actual': double.tryParse(item.ACTUAL.toString()) ?? 0.0,
        };
      }).toList();
    }

    List<Map<String, dynamic>> transformedData = _convertData(_datain);
    // print(transformedData);

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
        //               .read<P02PROGRESSGETDATA_Bloc>()
        //               .add(P02PROGRESSGETDATA_GET());
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
                  'Report Over KPI: Customer Group A (Target ≤ 12 days)',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 300,
                width: 800,
              ),
              SizedBox(height: 20),
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FixedColumnWidth(70),
                  1: FixedColumnWidth(100),
                  2: FixedColumnWidth(100),
                  3: FixedColumnWidth(100),
                  4: FixedColumnWidth(100),
                  5: FixedColumnWidth(100),
                  6: FixedColumnWidth(100),
                  7: FixedColumnWidth(100),
                  8: FixedColumnWidth(100),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Topic',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                      ...transformedData.map((data) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data['topic'].toString(),
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
                        child: Text('Target Days',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                      ...transformedData.map(
                        (data) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            double.tryParse(data['target'].toString())
                                    ?.toStringAsFixed(1) ??
                                '0.0',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Actual Days',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                      ...transformedData.map(
                        (data) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            double.tryParse(data['actual'].toString())
                                    ?.toStringAsFixed(1) ??
                                '0.0',
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
