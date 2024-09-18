// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../bloc/BlocEvent/04-01-P04PROGRESSGETDATA.dart';
import 'P04PROGRESSVAR.dart';

late BuildContext P04PROGRESSMAINcontext;

class P04PROGRESSMAIN extends StatefulWidget {
  P04PROGRESSMAIN({
    super.key,
    this.data,
  });
  List<P04PROGRESSGETDATAclass>? data;

  @override
  State<P04PROGRESSMAIN> createState() => _P04PROGRESSMAINState();
}

class _P04PROGRESSMAINState extends State<P04PROGRESSMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P04PROGRESSGETDATA_Bloc>().add(P04PROGRESSGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P04PROGRESSMAINcontext = context;
    List<P04PROGRESSGETDATAclass> _datain = widget.data ?? [];
    // print(_datain);
    List<Map<String, dynamic>> _convertData1(
        List<P04PROGRESSGETDATAclass> data) {
      return data
          .map((item) {
            return {
              'issue1': double.tryParse(item.ISSUE1.toString()) ?? 0.0,
            };
          })
          .where((item) => (item['issue1'] as double) > 0)
          .toList();
    }

    List<Map<String, dynamic>> _convertData2(
        List<P04PROGRESSGETDATAclass> data) {
      return data
          .map((item) {
            return {
              'issue2': double.tryParse(item.ISSUE2.toString()) ?? 0.0,
            };
          })
          .where((item) => (item['issue2'] as double) > 0)
          .toList();
    }

    List<Map<String, dynamic>> transformedData1 = _convertData1(_datain);
    List<Map<String, dynamic>> transformedData2 = _convertData2(_datain);
    // print(transformedData1);
    // print(transformedData2);

    Map<String, double> pieData = {
      if (transformedData1.isNotEmpty)
        'Achieved KPI (Iss.)': transformedData1[0]['issue1'] as double,
      if (transformedData1.length > 1)
        'Not Achieved KPI (Iss.)': transformedData1[1]['issue1'] as double,
    };

    Map<String, double> pieData2 = {
      if (transformedData2.isNotEmpty)
        '13-15 Working days': transformedData2[0]['issue2'] as double,
      if (transformedData2.length > 1)
        'Over less than 3 days': transformedData2[1]['issue2'] as double,
    };

    return Stack(
      children: [
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
              Text(
                'Group A\n'
                'Long sample preparation time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(
                            dataMap: pieData,
                            chartRadius: MediaQuery.of(context).size.width / 4,
                            colorList: [
                              Colors.lightGreen,
                              Colors.yellow.shade200
                            ],
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              chartValueBackgroundColor: Colors.white,
                              showChartValues: true,
                              showChartValuesInPercentage:
                                  P04PROGRESSVAR.showPercentage,
                              chartValueStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.bottom,
                              showLegendsInRow: true,
                              legendTextStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            chartType: ChartType.disc,
                            baseChartColor: Colors.grey[300]!,
                            centerText: 'Issues',
                            centerTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            right: 20,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      P04PROGRESSVAR.showPercentage =
                                          !P04PROGRESSVAR.showPercentage;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.black,
                                  ),
                                  child: const Icon(
                                    Icons.swap_horiz_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 35),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Total : ${pieData.values.reduce((a, b) => a + b)} Iss.',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(
                            dataMap: pieData2,
                            chartRadius: MediaQuery.of(context).size.width / 6,
                            colorList: [Colors.yellow.shade200, Colors.red],
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              chartValueBackgroundColor: Colors.white,
                              showChartValues: true,
                              showChartValuesInPercentage:
                                  P04PROGRESSVAR.showPercentage2,
                              chartValueStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.bottom,
                              showLegendsInRow: true,
                              legendTextStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartType: ChartType.disc,
                            baseChartColor: Colors.grey[300]!,
                            centerText: 'Issues',
                            centerTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            right: 20,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      P04PROGRESSVAR.showPercentage2 =
                                          !P04PROGRESSVAR.showPercentage2;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colors.black,
                                  ),
                                  child: const Icon(
                                    Icons.swap_horiz_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
