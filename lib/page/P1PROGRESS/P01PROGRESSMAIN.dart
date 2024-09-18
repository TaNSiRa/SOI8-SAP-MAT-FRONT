// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/01-01-P01PROGRESSGETDATA.dart';

late BuildContext P01PROGRESSMAINcontext;

class P01PROGRESSMAIN extends StatefulWidget {
  P01PROGRESSMAIN({
    super.key,
    this.data,
  });
  List<P01PROGRESSGETDATAclass>? data;

  @override
  State<P01PROGRESSMAIN> createState() => _P01PROGRESSMAINState();
}

class _P01PROGRESSMAINState extends State<P01PROGRESSMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P01PROGRESSGETDATA_Bloc>().add(P01PROGRESSGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P01PROGRESSMAINcontext = context;
    List<P01PROGRESSGETDATAclass> _datain = widget.data ?? [];
    List<Map<String, dynamic>> _convertData(
        List<P01PROGRESSGETDATAclass> data) {
      return data.map((item) {
        return {
          'month': item.MONTH,
          'kac': double.tryParse(item.KAC.toString()) ?? 0.0,
          'medium': double.tryParse(item.MEDIUM.toString()) ?? 0.0,
        };
      }).toList();
    }

    List<Map<String, dynamic>> transformedData = _convertData(_datain);

    return SingleChildScrollView(
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
                  'SAR : Service Performance',
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
              'Customer Service Performance Yr.2024',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 800,
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back_rounded,
                          size: 30, color: Colors.blue),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            'Key Account Customer Top 50th + Automobile KPI: 100% Service',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_back_rounded,
                          size: 30, color: Colors.deepOrange),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepOrange,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            'Medium customer \n'
                            'KPI: more than 90% Service',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
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
          SizedBox(height: 20),
          Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FixedColumnWidth(200),
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
                    child: Text('% Performance KAC',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10)),
                  ),
                  ...transformedData.map(
                    (data) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['kac'].toString(),
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
                    child: Text('% Performance Medium Customer (Day)',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10)),
                  ),
                  ...transformedData.map(
                    (data) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['medium'].toString(),
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
    );
  }
}
