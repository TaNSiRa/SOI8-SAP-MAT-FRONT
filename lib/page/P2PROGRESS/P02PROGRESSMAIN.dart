// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02PROGRESSGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import 'P02PROGRESSVAR.dart';

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

    // ตัวแปรสําหรับใช้กับ Dropdown
    final selectedType = (P02PROGRESSVAR.DropDownType.isNotEmpty)
        ? P02PROGRESSVAR.DropDownType
        : 'Group A';
    final selectedYear = (P02PROGRESSVAR.DropDownYear.isNotEmpty)
        ? P02PROGRESSVAR.DropDownYear
        : P02PROGRESSVAR.currentYear;
    final selectedMonth = (P02PROGRESSVAR.DropDownMonth.isNotEmpty)
        ? P02PROGRESSVAR.DropDownMonth
        : P02PROGRESSVAR.currentMonth;

    // Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupTargetDaysMap = {
      'Group A': P02PROGRESSVAR.GroupATargetDays,
      'Group B': P02PROGRESSVAR.GroupBTargetDays,
    };

    // เลือก Group A,B ตาม selectedType
    final GroupTargetDays =
        groupTargetDaysMap[selectedType] ?? P02PROGRESSVAR.GroupATargetDays;

    // กำหนด Period ตาม selectedType
    final typeValue = (selectedType == 'Group A')
        ? 12
        : (selectedType == 'Group B')
            ? 10
            : 0;

    // กรองข้อมูลด้วย Type ,YEAR ,MONTH
    List<P02PROGRESSGETDATAclass> filteredData = _datain.where((data) {
      return data.TYPE == selectedType && data.YEAR == selectedYear;
    }).toList();

    //แยกข้อมูล week 1-4
    List<Map<String, String>> newData = [];
    for (var data in filteredData) {
      if (data.REPDAYS1.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS1)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ1,
          'plan sam': data.PLANSAM1,
          'act sam': data.ACTSAM1,
          'rep due': data.REPDUE1,
          'sent rep': data.SENTREP1,
          'rep days': data.REPDAYS1,
          'request': data.REQUEST1,
          'ttcresult': data.TTCRESULT1,
          'issuedate': data.ISSUEDATE1,
          'revise': data.REVISE1,
          'sublead': data.SUBLEAD1,
          'gl': data.GL1,
          'mgr': data.MGR1,
          'jp': data.JP1,
          'bdprepare': data.BDPREPARE1,
          'bdttc': data.BDTTC1,
          'bdissue': data.BDISSUE1,
          'bdrevise': data.BDREVISE1,
          'bdsublead': data.BDSUBLEAD1,
          'bdgl': data.BDGL1,
          'bdmgr': data.BDMGR1,
          'bdjp': data.BDJP1,
          'bdsent': data.BDSENT1,
          'reason': data.REASON1,
          'action': data.ACTION1,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS2.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS2)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ2,
          'plan sam': data.PLANSAM2,
          'act sam': data.ACTSAM2,
          'rep due': data.REPDUE2,
          'sent rep': data.SENTREP2,
          'rep days': data.REPDAYS2,
          'request': data.REQUEST2,
          'ttcresult': data.TTCRESULT2,
          'issuedate': data.ISSUEDATE2,
          'revise': data.REVISE2,
          'sublead': data.SUBLEAD2,
          'gl': data.GL2,
          'mgr': data.MGR2,
          'jp': data.JP2,
          'bdprepare': data.BDPREPARE2,
          'bdttc': data.BDTTC2,
          'bdissue': data.BDISSUE2,
          'bdrevise': data.BDREVISE2,
          'bdsublead': data.BDSUBLEAD2,
          'bdgl': data.BDGL2,
          'bdmgr': data.BDMGR2,
          'bdjp': data.BDJP2,
          'bdsent': data.BDSENT2,
          'reason': data.REASON2,
          'action': data.ACTION2,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS3.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS3)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ3,
          'plan sam': data.PLANSAM3,
          'act sam': data.ACTSAM3,
          'rep due': data.REPDUE3,
          'sent rep': data.SENTREP3,
          'rep days': data.REPDAYS3,
          'request': data.REQUEST3,
          'ttcresult': data.TTCRESULT3,
          'issuedate': data.ISSUEDATE3,
          'revise': data.REVISE3,
          'sublead': data.SUBLEAD3,
          'gl': data.GL3,
          'mgr': data.MGR3,
          'jp': data.JP3,
          'bdprepare': data.BDPREPARE3,
          'bdttc': data.BDTTC3,
          'bdissue': data.BDISSUE3,
          'bdrevise': data.BDREVISE3,
          'bdsublead': data.BDSUBLEAD3,
          'bdgl': data.BDGL3,
          'bdmgr': data.BDMGR3,
          'bdjp': data.BDJP3,
          'bdsent': data.BDSENT3,
          'reason': data.REASON3,
          'action': data.ACTION3,
        };
        newData.add(transformedData1);
      }
      if (data.REPDAYS4.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          int.tryParse(data.REPDAYS4)! > int.tryParse(data.KPIPERIOD)!) {
        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'mktgroup': data.MKTGROUP,
          'group': data.GROUP,
          'customer': data.CUSTOMER,
          'frequency': data.FREQUENCY,
          'incharge': data.INCHARGE,
          'kpi serv': data.KPISERV,
          'kpi period': data.KPIPERIOD,
          'repitems': data.REPITEM,
          'month': data.MONTH,
          'year': data.YEAR,
          'freq': data.FREQ4,
          'plan sam': data.PLANSAM4,
          'act sam': data.ACTSAM4,
          'rep due': data.REPDUE4,
          'sent rep': data.SENTREP4,
          'rep days': data.REPDAYS4,
          'request': data.REQUEST4,
          'ttcresult': data.TTCRESULT4,
          'issuedate': data.ISSUEDATE4,
          'revise': data.REVISE4,
          'sublead': data.SUBLEAD4,
          'gl': data.GL4,
          'mgr': data.MGR4,
          'jp': data.JP4,
          'bdprepare': data.BDPREPARE4,
          'bdttc': data.BDTTC4,
          'bdissue': data.BDISSUE4,
          'bdrevise': data.BDREVISE4,
          'bdsublead': data.BDSUBLEAD4,
          'bdgl': data.BDGL4,
          'bdmgr': data.BDMGR4,
          'bdjp': data.BDJP4,
          'bdsent': data.BDSENT4,
          'reason': data.REASON4,
          'action': data.ACTION4,
        };
        newData.add(transformedData1);
      }
    }

    // Sum ข้อมูลแต่ะชุด
    List<double> avgAllBreakdown = [];

    if (newData.isNotEmpty) {
      List<int> sumList = [];
      sumList = newData.map((item) {
        final int bdprepare =
            int.tryParse(item['bdprepare']?.toString() ?? '0') ?? 0;
        final int bdttc = int.tryParse(item['bdttc']?.toString() ?? '0') ?? 0;
        final int bdissue =
            int.tryParse(item['bdissue']?.toString() ?? '0') ?? 0;
        final int bdrevise =
            int.tryParse(item['bdrevise']?.toString() ?? '0') ?? 0;
        final int bdsublead =
            int.tryParse(item['bdsublead']?.toString() ?? '0') ?? 0;
        final int bdgl = int.tryParse(item['bdgl']?.toString() ?? '0') ?? 0;
        final int bdmgr = int.tryParse(item['bdmgr']?.toString() ?? '0') ?? 0;
        final int bdjp = int.tryParse(item['bdjp']?.toString() ?? '0') ?? 0;
        final int bdsent = int.tryParse(item['bdsent']?.toString() ?? '0') ?? 0;

        final int sumTotalDay = bdprepare +
            bdttc +
            bdissue +
            bdrevise +
            bdsublead +
            bdgl +
            bdmgr +
            bdjp +
            bdsent;

        return sumTotalDay;
      }).toList();

      // หา Avg ของ sumList
      if (sumList.isNotEmpty) {
        double avgTotal = sumList.reduce((a, b) => a + b) / sumList.length;
        avgTotal = double.parse(avgTotal.toStringAsFixed(1));

        // ใส่ avgTotal เป็นตัวแรกใน avgAllBreakdown
        avgAllBreakdown.insert(0, avgTotal);

        // กรองข้อมูลมั้งหมดแล้วนำไปใส่ไว้ใน List avgAllBreakdown
        for (String breakdown in [
          'bdsent',
          'bdjp',
          'bdmgr',
          'bdgl',
          'bdsublead',
          'bdrevise',
          'bdissue',
          'bdttc',
          'bdprepare',
        ]) {
          var filteredItems = newData
              .where((item) =>
                  item['type'] == selectedType &&
                  item['month'] == selectedMonth &&
                  item['year'] == selectedYear)
              .toList();

          if (filteredItems.isNotEmpty) {
            double AvgBreakdown = filteredItems
                    .map((item) => (int.tryParse(item[breakdown] ?? '0') ?? 0))
                    .fold(0, (sum, freq) => sum + freq) /
                filteredItems.length;

            AvgBreakdown = double.parse(AvgBreakdown.toStringAsFixed(1));
            avgAllBreakdown.add(AvgBreakdown);
          }
        }
      } else {
        print("sumList is empty.");
      }
    } else {}

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
                  'SAR : Report Performance ($selectedMonth $selectedYear)',
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
              'Report Over KPI: Customer $selectedType (Target ≤ $typeValue days)',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                color: Colors.yellow.shade600,
              ),
              Text(' Target Days'),
              SizedBox(width: 20),
              Container(
                height: 10,
                width: 10,
                color: Colors.blue.shade900,
              ),
              Text(' Actual Days'),
            ],
          ),
          SizedBox(
            height: 390,
            width: 1100,
            child: Stack(
              children: [
                Center(
                  child: CustomBarChart(
                    GroupTargetDays: GroupTargetDays,
                    avgAllBreakdown: avgAllBreakdown,
                    maxY: 20,
                  ),
                ),
                Positioned(
                  top: 195,
                  left: -50,
                  child: Transform.rotate(
                    angle: -90 * (3.14159 / 180),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'A) Long sample preparation time',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          if (P02PROGRESSVAR.DropDownType.isNotEmpty ||
                              P02PROGRESSVAR.DropDownYear.isNotEmpty ||
                              P02PROGRESSVAR.DropDownMonth.isNotEmpty)
                            SizedBox(
                              width: 100,
                              child: Text(
                                'TYPE',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          AdvanceDropDown(
                            hint: "TYPE",
                            listdropdown: const [
                              MapEntry("TYPE", ""),
                              MapEntry("Group A", "Group A"),
                              MapEntry("Group B", "Group B"),
                            ],
                            onChangeinside: (d, k) {
                              setState(() {
                                P02PROGRESSVAR.DropDownType = d;
                              });
                            },
                            value: P02PROGRESSVAR.DropDownType,
                            height: 30,
                            width: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          if (P02PROGRESSVAR.DropDownType.isNotEmpty ||
                              P02PROGRESSVAR.DropDownYear.isNotEmpty ||
                              P02PROGRESSVAR.DropDownMonth.isNotEmpty)
                            SizedBox(
                              width: 100,
                              child: Text(
                                'YEAR',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          AdvanceDropDown(
                            hint: "YEAR",
                            listdropdown: const [
                              MapEntry("YEAR", ""),
                              MapEntry("2024", "2024"),
                              MapEntry("2025", "2025"),
                              MapEntry("2026", "2026"),
                              MapEntry("2027", "2027"),
                              MapEntry("2028", "2028"),
                              MapEntry("2029", "2029"),
                              MapEntry("2030", "2030"),
                              MapEntry("2031", "2031"),
                              MapEntry("2032", "2032"),
                              MapEntry("2033", "2033"),
                              MapEntry("2034", "2034"),
                              MapEntry("2035", "2035"),
                              MapEntry("2036", "2036"),
                              MapEntry("2037", "2037"),
                              MapEntry("2038", "2038"),
                              MapEntry("2039", "2039"),
                              MapEntry("2040", "2040"),
                            ],
                            onChangeinside: (d, k) {
                              setState(() {
                                P02PROGRESSVAR.DropDownYear = d;
                              });
                            },
                            value: P02PROGRESSVAR.DropDownYear,
                            height: 30,
                            width: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          if (P02PROGRESSVAR.DropDownType.isNotEmpty ||
                              P02PROGRESSVAR.DropDownYear.isNotEmpty ||
                              P02PROGRESSVAR.DropDownMonth.isNotEmpty)
                            SizedBox(
                              width: 100,
                              child: Text(
                                'MONTH',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          AdvanceDropDown(
                            hint: "MONTH",
                            listdropdown: const [
                              MapEntry("MONTH", ""),
                              MapEntry("Jan", "Jan"),
                              MapEntry("Feb", "Feb"),
                              MapEntry("Mar", "Mar"),
                              MapEntry("Apr", "Apr"),
                              MapEntry("May", "May"),
                              MapEntry("Jun", "Jun"),
                              MapEntry("Jul", "Jul"),
                              MapEntry("Aug", "Aug"),
                              MapEntry("Sep", "Sep"),
                              MapEntry("Oct", "Oct"),
                              MapEntry("Nov", "Nov"),
                              MapEntry("Dec", "Dec"),
                            ],
                            onChangeinside: (d, k) {
                              setState(() {
                                P02PROGRESSVAR.DropDownMonth = d;
                              });
                            },
                            value: P02PROGRESSVAR.DropDownMonth,
                            height: 30,
                            width: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

//คลาสสำหรับสร้างกราฟ
class CustomBarChart extends StatelessWidget {
  final List<double> GroupTargetDays;
  final List<double> avgAllBreakdown;
  final double maxY;

  const CustomBarChart({
    super.key,
    required this.GroupTargetDays,
    required this.avgAllBreakdown,
    required this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      width: 800,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomPaint(
        painter: BarChartPainter(
          GroupTargetDays: GroupTargetDays,
          avgAllBreakdown: avgAllBreakdown,
          maxY: maxY,
        ),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<double> GroupTargetDays;
  final List<double> avgAllBreakdown;
  final double maxY;
  final selectedYear = (P02PROGRESSVAR.DropDownYear.isNotEmpty)
      ? P02PROGRESSVAR.DropDownYear
      : P02PROGRESSVAR.currentYear;

  BarChartPainter({
    required this.GroupTargetDays,
    required this.avgAllBreakdown,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // สีของแท่งกราฟ Target
    final paintNextTarget = Paint()
      ..color = Colors.yellow.shade600
      ..style = PaintingStyle.fill;

    // สีของแท่งกราฟ Actual
    final paintNextActual = Paint()
      ..color = Colors.blue.shade900
      ..style = PaintingStyle.fill;

    // สีของแท่งกราฟ Target แรก
    final paintFirstTarget = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // สีของแท่งกราฟ Actual แรก
    final paintFirstActual = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // สีของเส้นไกด์
    final guideLinePaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    final barHeight = (size.height / (GroupTargetDays.length * 2)) *
        0.3; // ความสูงของแท่ง,ความกว้างของแท่ง
    const spaceBetweenBars = 5.0; // ระยะห่างระหว่างแท่งที่ชิดกัน
    const spaceBetweenMonths = 17.5; // ระยะห่างระหว่างเดือน
    const startYOffset = 20.0; // จุดเริ่มต้นของกราฟแท่ง

    // วาดเส้นไกด์แนวตั้งบนแกน X
    for (int i = 0; i <= maxY; i += 2) {
      final xPosition = (i / maxY) * size.width;
      canvas.drawLine(
          Offset(xPosition, 0), Offset(xPosition, size.height), guideLinePaint);
    }

    // เริ่ม Loop สำหรับสร้างแท่งกราฟ
    for (int i = 0; i < GroupTargetDays.length; i++) {
      if (i >= avgAllBreakdown.length) {
        // หยุดการทำงานถ้าข้อมูลไม่เพียงพอ
        break;
      }
      // คำนวณตำแหน่งของแท่งกราฟ Target
      final topTarget = startYOffset +
          i * (barHeight * 2 + spaceBetweenBars) +
          (i * spaceBetweenMonths);
      // คำนวณความกว้างของแท่งกราฟ Target
      final rightTarget = (GroupTargetDays[i] / maxY) * size.width;
      // สร้างสี่เหลี่ยมพื้นผ้าของ Target (ตำแหน่งแกน X, ตำแหน่งแกน Y, ความกว้าง, ความสูง)
      final rectTarget = Rect.fromLTWH(0, topTarget, rightTarget, barHeight);

      // ตรวจสอบว่าเป็นแท่งแรกหรือไม่
      final paintTarget = (i == 0) ? paintFirstTarget : paintNextTarget;

      // วาดแท่งกราฟ Target
      canvas.drawRect(rectTarget, paintTarget);

      // วาดตัวเลขบนแท่งกราฟ Target
      String TargetText = '';

      if (GroupTargetDays[i] != 0) {
        TargetText = GroupTargetDays[i].toStringAsFixed(1);

        // ตรวจสอบว่าหมายเลขเป็นจำนวนเต็มหรือไม่
        if (GroupTargetDays[i] % 1 == 0) {
          TargetText = GroupTargetDays[i].toInt().toString();
        }
      }

      // ตรวจสอบว่า TargetText มีค่าหรือไม่
      if (TargetText.isNotEmpty) {
        // สร้าง TextPainter สำหรับ Target
        final textPainterTarget = TextPainter(
          text: TextSpan(
            text: TargetText,
            style: TextStyle(color: Colors.black, fontSize: 7),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainterTarget.layout();
        // หาตำแหน่งแกน X ของค่า Target
        final textXPositionTarget = rightTarget + 5;
        // หาตำแหน่งแกน Y ของค่า Target
        final textYPositionTarget = topTarget + (barHeight / 2) - 4;
        // วาดตัวเลขบนแท่งกราฟ Target (แกน X, แกน Y)
        textPainterTarget.paint(
            canvas, Offset(textXPositionTarget, textYPositionTarget));
      }

      // คำนวณตำแหน่งของแท่งกราฟ Actual
      final topActual = topTarget + barHeight + spaceBetweenBars;
      // คำนวณความกว้างของแท่งกราฟ Actual
      final rightActual = (avgAllBreakdown[i] / maxY) * size.width;
      // สร้างสี่เหลี่ยมพื้นผ้าของ Actual (ตำแหน่งแกน X, ตำแหน่งแกน Y, ความกว้าง, ความสูง)
      final rectActual = Rect.fromLTWH(0, topActual, rightActual, barHeight);

      // ตรวจสอบว่าเป็นแท่งแรกหรือไม่
      final paintActual = (i == 0) ? paintFirstActual : paintNextActual;

      // วาดแท่งกราฟ Actual
      canvas.drawRect(rectActual, paintActual);

      // วาดตัวเลขบนแท่งกราฟ Actual
      String ActualText = '';

      if (avgAllBreakdown[i] != 0) {
        ActualText = avgAllBreakdown[i].toStringAsFixed(1);

        // ตรวจสอบว่าหมายเลขเป็นจำนวนเต็มหรือไม่
        if (avgAllBreakdown[i] % 1 == 0) {
          ActualText = avgAllBreakdown[i].toInt().toString();
        }
      }

      // ตรวจสอบว่า ActualText มีค่าหรือไม่
      if (ActualText.isNotEmpty) {
        // สร้าง TextPainter สำหรับ Actual
        final textPainterActual = TextPainter(
          text: TextSpan(
            text: ActualText,
            style: TextStyle(color: Colors.black, fontSize: 7),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainterActual.layout();
        // หาตำแหน่งแกน X ของค่า Actual
        final textXPositionActual = rightActual + 5;
        // หาตำแหน่งแกน Y ของค่า Actual
        final textYPositionActual = topActual + (barHeight / 2) - 3;
        // วาดตัวเลขบนแท่งกราฟ Actual (แกน X, แกน Y)
        textPainterActual.paint(
            canvas, Offset(textXPositionActual, textYPositionActual));
      }
    }

    // กำหนดสี ,ความหนาของเส้นแกน X และ Y
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // เส้นแกน Y
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);

    // เส้นแกน X
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);

    // วาดตัวเลขบนแกน X
    final textStyle = TextStyle(color: Colors.black, fontSize: 10);
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i <= maxY; i += 2) {
      textPainter.text = TextSpan(
        text: '$i',
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset((i / maxY) * size.width - textPainter.width / 2,
              size.height + 5));
    }

    // วาดชื่อเดือนบนแกน Y
    for (int i = 0; i < GroupTargetDays.length; i++) {
      String monthText;

      monthText = P02PROGRESSVAR.breakdown[i];

      textPainter.text = TextSpan(
        text: monthText,
        style: textStyle,
      );

      textPainter.layout();

      // คำนวณตำแหน่งกลางระหว่างแท่ง Target และ Actual
      final yPosition = startYOffset +
          i * (barHeight * 2 + spaceBetweenBars) +
          (i * spaceBetweenMonths) +
          barHeight +
          (barHeight + spaceBetweenBars) / 2 -
          textPainter.height / 2;

      textPainter.paint(canvas, Offset(-textPainter.width - 5, yPosition - 3));
    }
  }

  void drawDashedLine(Canvas canvas, Paint paint, Offset p1, Offset p2) {
    const int dashWidth = 4;
    const int dashSpace = 4;
    double startX = p1.dx;
    while (startX < p2.dx) {
      canvas.drawLine(
          Offset(startX, p1.dy), Offset(startX + dashWidth, p1.dy), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
