// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/01-01-P01CUSSERVICEGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import 'P01CUSSERVICEVAR.dart';

late BuildContext P01CUSSERVICEMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P01CUSSERVICEMAIN extends StatefulWidget {
  P01CUSSERVICEMAIN({
    super.key,
    this.data,
  });
  List<P01CUSSERVICEGETDATAclass>? data;

  @override
  State<P01CUSSERVICEMAIN> createState() => _P01CUSSERVICEMAINState();
}

class _P01CUSSERVICEMAINState extends State<P01CUSSERVICEMAIN> {
  @override
  void initState() {
    super.initState();
    context.read<P01CUSSERVICEGETDATA_Bloc>().add(P01CUSSERVICEGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P01CUSSERVICEMAINcontext = context;
    List<P01CUSSERVICEGETDATAclass> _datain = widget.data ?? [];

    // ตัวแปรสําหรับใช้กับ Dropdown
    final selectedYear = (P01CUSSERVICEVAR.DropDownYear.isNotEmpty)
        ? P01CUSSERVICEVAR.DropDownYear
        : P01CUSSERVICEVAR.currentYear;

    // กรองข้อมูลด้วยปีและเดือน
    List<P01CUSSERVICEGETDATAclass> filteredData = _datain.where((data) {
      return data.YEAR == selectedYear;
    }).toList();

    //แปลงข้อมูลจาก List<P01CUSSERVICEGETDATAclass> เป็น List<Map<String, dynamic>>
    List<Map<String, dynamic>> convertData(
        List<P01CUSSERVICEGETDATAclass> data) {
      return data.map((item) {
        return {
          'type': item.TYPE,
          'mktgroup': item.MKTGROUP,
          'group': item.GROUP,
          'customer': item.CUSTOMER,
          'frequency': item.FREQUENCY,
          'incharge': item.INCHARGE,
          'kpi serv': item.KPISERV,
          'kpi period': item.KPIPERIOD,
          'repitems': item.REPITEM,
          'month': item.MONTH,
          'year': item.YEAR,
          'freq1': item.FREQ1,
          'plan sam1': item.PLANSAM1,
          'act sam1': item.ACTSAM1,
          'rep due1': item.REPDUE1,
          'sent rep1': item.SENTREP1,
          'rep days1': item.REPDAYS1,
          'freq2': item.FREQ2,
          'plan sam2': item.PLANSAM2,
          'act sam2': item.ACTSAM2,
          'rep due2': item.REPDUE2,
          'sent rep2': item.SENTREP2,
          'rep days2': item.REPDAYS2,
          'freq3': item.FREQ3,
          'plan sam3': item.PLANSAM3,
          'act sam3': item.ACTSAM3,
          'rep due3': item.REPDUE3,
          'sent rep3': item.SENTREP3,
          'rep days3': item.REPDAYS3,
          'freq4': item.FREQ4,
          'plan sam4': item.PLANSAM4,
          'act sam4': item.ACTSAM4,
          'rep due4': item.REPDUE4,
          'sent rep4': item.SENTREP4,
          'rep days4': item.REPDAYS4,
        };
      }).toList();
    }

    List<Map<String, dynamic>> transformedData = convertData(filteredData);
    List<Map<String, dynamic>> UseforPreviousYear = convertData(_datain);

    // KAC Sum visit plan monthly previous year
    int KACVisitPlanSumYear = UseforPreviousYear.where((item) =>
            item['group'] == 'KAC' &&
            item['year'] == '${int.parse(selectedYear) - 1}')
        .map((item) =>
            (int.tryParse(item['freq1'] ?? '0') ?? 0) +
            (int.tryParse(item['freq2'] ?? '0') ?? 0) +
            (int.tryParse(item['freq3'] ?? '0') ?? 0) +
            (int.tryParse(item['freq4'] ?? '0') ?? 0))
        .fold(0, (sum, freq) => sum + freq);

    // KAC Sum visit actual monthly previous year
    int KACVisitActualCountYear = UseforPreviousYear.where((item) =>
        item['group'] == 'KAC' &&
        item['year'] == '${int.parse(selectedYear) - 1}').map((item) {
      int count = 0;
      if (item['act sam1']?.isNotEmpty ?? false) count++;
      if (item['act sam2']?.isNotEmpty ?? false) count++;
      if (item['act sam3']?.isNotEmpty ?? false) count++;
      if (item['act sam4']?.isNotEmpty ?? false) count++;
      return count;
    }).fold(0, (sum, count) => sum + count);

    // %Visit KAC previous year
    double KACavgVisitPercent =
        (KACVisitActualCountYear / KACVisitPlanSumYear) * 100;

    // MEDIUM Sum visit plan monthly previous year
    int MEDIUMVisitPlanSumYear = UseforPreviousYear.where((item) =>
            item['group'] == 'MEDIUM' &&
            item['year'] == '${int.parse(selectedYear) - 1}')
        .map((item) =>
            (int.tryParse(item['freq1'] ?? '0') ?? 0) +
            (int.tryParse(item['freq2'] ?? '0') ?? 0) +
            (int.tryParse(item['freq3'] ?? '0') ?? 0) +
            (int.tryParse(item['freq4'] ?? '0') ?? 0))
        .fold(0, (sum, freq) => sum + freq);

    // MEDIUM Sum visit actual monthly previous year
    int MEDIUMVisitActualCountYear = UseforPreviousYear.where((item) =>
        item['group'] == 'MEDIUM' &&
        item['year'] == '${int.parse(selectedYear) - 1}').map((item) {
      int count = 0;
      if (item['act sam1']?.isNotEmpty ?? false) count++;
      if (item['act sam2']?.isNotEmpty ?? false) count++;
      if (item['act sam3']?.isNotEmpty ?? false) count++;
      if (item['act sam4']?.isNotEmpty ?? false) count++;
      return count;
    }).fold(0, (sum, count) => sum + count);

    // %Visit MEDIUM previous year
    double MEDIUMavgVisitPercent =
        (MEDIUMVisitActualCountYear / MEDIUMVisitPlanSumYear) * 100;

    // ตัวแปรสําหรับเก็บข้อมูลแต่ละเดือนของ KAC
    Map<String, int> kacVisitPlanSums = {};
    Map<String, int> kacVisitActualCounts = {};
    List<double> kacVisitPercents = [];

    // ตรวจสอบว่า KACavgVisitPercent เป็น NaN หรือไม่
    if (KACavgVisitPercent.isNaN) {
      kacVisitPercents.add(0.0);
    } else {
      kacVisitPercents.add(KACavgVisitPercent);
    }

    for (String month in [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]) {
      // นับจำนวณ KAC Sum visit plan monthly
      int kacVisitPlanSum = transformedData
          .where((item) =>
              item['group'] == 'KAC' &&
              item['month'] == month &&
              item['year'] == selectedYear)
          .map((item) =>
              (int.tryParse(item['freq1'] ?? '0') ?? 0) +
              (int.tryParse(item['freq2'] ?? '0') ?? 0) +
              (int.tryParse(item['freq3'] ?? '0') ?? 0) +
              (int.tryParse(item['freq4'] ?? '0') ?? 0))
          .fold(0, (sum, freq) => sum + freq);

      kacVisitPlanSums[month] = kacVisitPlanSum;

      // นับจำนวณ KAC Sum visit actual monthly
      int kacVisitActualCount = transformedData
          .where((item) =>
              item['group'] == 'KAC' &&
              item['month'] == month &&
              item['year'] == selectedYear)
          .map((item) {
        int count = 0;
        if (item['act sam1']?.isNotEmpty ?? false) count++;
        if (item['act sam2']?.isNotEmpty ?? false) count++;
        if (item['act sam3']?.isNotEmpty ?? false) count++;
        if (item['act sam4']?.isNotEmpty ?? false) count++;
        return count;
      }).fold(0, (sum, count) => sum + count);

      kacVisitActualCounts[month] = kacVisitActualCount;

      // หา %Visit KAC ของแต่ละเดือน
      double kacVisitPercent = kacVisitPlanSum > 0
          ? (kacVisitActualCount / kacVisitPlanSum) * 100
          : 0;
      kacVisitPercents.add(kacVisitPercent);
    }

    // ตัวแปรสําหรับเก็บข้อมูลแต่ละเดือนของ MEDIUM
    Map<String, int> mediumVisitPlanSums = {};
    Map<String, int> mediumVisitActualCounts = {};
    List<double> mediumVisitPercents = [];

    // ตรวจสอบว่า MEDIUMavgVisitPercent เป็น NaN หรือไม่
    if (MEDIUMavgVisitPercent.isNaN) {
      mediumVisitPercents.add(0.0);
    } else {
      mediumVisitPercents.add(MEDIUMavgVisitPercent);
    }

    for (String month in [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]) {
      // นับจำนวณ MEDIUM Sum visit plan monthly
      int mediumVisitPlanSum = transformedData
          .where((item) =>
              item['group'] == 'MEDIUM' &&
              item['month'] == month &&
              item['year'] == selectedYear)
          .map((item) =>
              (int.tryParse(item['freq1'] ?? '0') ?? 0) +
              (int.tryParse(item['freq2'] ?? '0') ?? 0) +
              (int.tryParse(item['freq3'] ?? '0') ?? 0) +
              (int.tryParse(item['freq4'] ?? '0') ?? 0))
          .fold(0, (sum, freq) => sum + freq);

      mediumVisitPlanSums[month] = mediumVisitPlanSum;

      // นับจำนวณ MEDIUM Sum visit actual monthly
      int mediumVisitActualCount = transformedData
          .where((item) =>
              item['group'] == 'MEDIUM' &&
              item['month'] == month &&
              item['year'] == selectedYear)
          .map((item) {
        int count = 0;
        if (item['act sam1']?.isNotEmpty ?? false) count++;
        if (item['act sam2']?.isNotEmpty ?? false) count++;
        if (item['act sam3']?.isNotEmpty ?? false) count++;
        if (item['act sam4']?.isNotEmpty ?? false) count++;
        return count;
      }).fold(0, (sum, count) => sum + count);

      mediumVisitActualCounts[month] = mediumVisitActualCount;

      // หา %Visit MEDIUM ของแต่ละเดือน
      double mediumVisitPercent = mediumVisitPlanSum > 0
          ? (mediumVisitActualCount / mediumVisitPlanSum) * 100
          : 0;
      mediumVisitPercents.add(mediumVisitPercent);
    }

    return Scrollbar(
      controller: _controllerIN01,
      thumbVisibility: true,
      interactive: true,
      thickness: 10,
      radius: Radius.circular(20),
      child: Center(
        child: SingleChildScrollView(
          controller: _controllerIN01,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                    'Customer Service Performance Yr.$selectedYear',
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
                      color: Colors.blue.shade900,
                    ),
                    Text(' % Performance KAC'),
                    SizedBox(width: 20),
                    Container(
                      height: 10,
                      width: 10,
                      color: Colors.deepOrange,
                    ),
                    Text(' % Performance MEDIUM Customer (Day)'),
                  ],
                ),
                SizedBox(
                  height: 380,
                  width: 1100,
                  child: Stack(
                    children: [
                      Center(
                        child: CustomBarChart(
                          kacVisitPercents: kacVisitPercents,
                          mediumVisitPercents: mediumVisitPercents,
                          maxY: 140,
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 70,
                        child: Transform.rotate(
                          angle: -90 * (3.14159 / 180),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '% Performance',
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
                          children: [
                            if (P01CUSSERVICEVAR.DropDownYear.isNotEmpty) ...[
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'YEAR',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
                                  P01CUSSERVICEVAR.DropDownYear = d;
                                });
                              },
                              value: P01CUSSERVICEVAR.DropDownYear,
                              height: 30,
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 85,
                        right: 0,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_back_rounded,
                                    size: 20, color: Colors.blue.shade900),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue.shade900,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Key Account Customer Top 50th + Automobile KPI: 100% Service',
                                      style: TextStyle(
                                        fontSize: 8.0,
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
                                    size: 20, color: Colors.deepOrange),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
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
                                      'KPI: more than 95% Service',
                                      style: TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// คลาสสำหรับสร้างกราฟ
class CustomBarChart extends StatelessWidget {
  final List<double> kacVisitPercents;
  final List<double> mediumVisitPercents;
  final double maxY;

  const CustomBarChart({
    super.key,
    required this.kacVisitPercents,
    required this.mediumVisitPercents,
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
          kacVisitPercents: kacVisitPercents,
          mediumVisitPercents: mediumVisitPercents,
          maxY: maxY,
        ),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<double> kacVisitPercents;
  final List<double> mediumVisitPercents;
  final double maxY;
  final selectedYear = (P01CUSSERVICEVAR.DropDownYear.isNotEmpty)
      ? P01CUSSERVICEVAR.DropDownYear
      : P01CUSSERVICEVAR.currentYear;

  BarChartPainter({
    required this.kacVisitPercents,
    required this.mediumVisitPercents,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // สีของแท่งกราฟ KAC
    final paintKAC = Paint()
      ..color = Colors.blue.shade900
      ..style = PaintingStyle.fill;

    // สีของแท่งกราฟ Medium
    final paintMedium = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.fill;

    // เส้นประ 1
    final paintDashed1 = Paint()
      ..color = Colors.blue.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // เส้นประ 2
    final paintDashed2 = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // ตำแหน่งความสูงของเส้นประทั้ง 2 เส้น
    double ySetpoint100 = size.height - (100 / maxY) * size.height;
    double ySetpoint95 = size.height - (95 / maxY) * size.height;

    // วาดเส้นประ 1
    drawDashedLine(canvas, paintDashed1, Offset(0, ySetpoint100),
        Offset(size.width + 30, ySetpoint100));

    // วาดเส้นประ 2
    drawDashedLine(canvas, paintDashed2, Offset(0, ySetpoint95),
        Offset(size.width + 30, ySetpoint95));

    final barWidth =
        (size.width / (kacVisitPercents.length * 2)) * 0.5; // ความกว้างของแท่ง
    const spaceBetweenBars = 5.0; // ระยะห่างระหว่างแท่งที่ชิดกัน
    const spaceBetweenMonths = 25.0; // ระยะห่างระหว่างเดือน
    const startXOffset = 20.0; // จุดเริ่มต้นของกราฟแท่ง

    for (int i = 0; i < kacVisitPercents.length; i++) {
      // คำนวณตำแหน่งของแท่งกราฟ KAC
      final leftKAC = startXOffset +
          i * (barWidth * 2 + spaceBetweenBars) +
          (i * spaceBetweenMonths);
      // คำนวณความสูงของแท่งกราฟ KAC
      final topKAC = size.height - (kacVisitPercents[i] / maxY) * size.height;
      // สร้างสี่เหลี่ยมพื้นผ้าของ KAC (ตำแหน่งแกน X, ตำแหน่งแกน Y, ความกว้าง, ความสูง)
      final rectKAC =
          Rect.fromLTWH(leftKAC, topKAC, barWidth, size.height - topKAC);

      // วาดแท่งกราฟ KAC
      canvas.drawRect(rectKAC, paintKAC);

      // วาดตัวเลขบนแท่งกราฟ KAC
      String kacText = '';

      if (kacVisitPercents[i] != 0) {
        kacText = kacVisitPercents[i].toStringAsFixed(1);

        // ตรวจสอบว่าหมายเลขเป็นจำนวนเต็มหรือไม่
        if (kacVisitPercents[i] % 1 == 0) {
          kacText = kacVisitPercents[i].toInt().toString();
        }
      }

      // ตรวจสอบว่า kacText มีค่าหรือไม่
      if (kacText.isNotEmpty) {
        // สร้าง TextPainter สำหรับ KAC
        final textPainterKAC = TextPainter(
          text: TextSpan(
            text: kacText,
            style: TextStyle(color: Colors.black, fontSize: 7),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainterKAC.layout();
        // หาตำแหน่งแกน X ของค่า KAC
        final textXPositionKAC =
            leftKAC + (barWidth / 2) - (textPainterKAC.width / 2);
        // หาตำแหน่งแกน Y ของค่า KAC
        final textYPositionKAC = topKAC - 15;
        // วาดตัวเลขบนแท่งกราฟ KAC (แกน X, แกน Y)
        textPainterKAC.paint(
            canvas, Offset(textXPositionKAC, textYPositionKAC));
      }

      // คำนวณตำแหน่งของแท่งกราฟ MEDIUM
      final leftMedium = leftKAC + barWidth + spaceBetweenBars;
      // คำนวณความสูงของแท่งกราฟ MEDIUM
      final topMedium =
          size.height - (mediumVisitPercents[i] / maxY) * size.height;
      // สร้างสี่เหลี่ยมพื้นผ้าของ MEDIUM (ตำแหน่งแกน X, ตำแหน่งแกน Y, ความกว้าง, ความสูง)
      final rectMedium = Rect.fromLTWH(
          leftMedium, topMedium, barWidth, size.height - topMedium);

      // วาดแท่งกราฟ Medium
      canvas.drawRect(rectMedium, paintMedium);

      // วาดตัวเลขบนแท่งกราฟ Medium
      String mediumText = '';

      if (mediumVisitPercents[i] != 0) {
        mediumText = mediumVisitPercents[i].toStringAsFixed(1);

        // ตรวจสอบว่าหมายเลขเป็นจำนวนเต็มหรือไม่
        if (mediumVisitPercents[i] % 1 == 0) {
          mediumText = mediumVisitPercents[i].toInt().toString();
        }
      }

      // ตรวจสอบว่า mediumText มีค่าหรือไม่
      if (mediumText.isNotEmpty) {
        // สร้าง TextPainter สำหรับ Medium
        final textPainterMedium = TextPainter(
          text: TextSpan(
            text: mediumText,
            style: TextStyle(color: Colors.black, fontSize: 7),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainterMedium.layout();
        // หาตำแหน่งแกน X ของค่า MEDIUM
        final textXPositionMedium =
            leftMedium + (barWidth / 2) - (textPainterMedium.width / 2);
        // หาตำแหน่งแกน Y ของค่า MEDIUM
        final textYPositionMedium = topMedium - 15;
        // วาดตัวเลขบนแท่งกราฟ MEDIUM (แกน X, แกน Y)
        textPainterMedium.paint(
            canvas, Offset(textXPositionMedium, textYPositionMedium));
      }
    }

    // กำหนดสี ,ความหนาของเส้นแกน X และ Y
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // เส้นแกน Y
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);

    // เส้นแกน X
    canvas.drawLine(Offset(0, size.height),
        Offset(size.width + 30, size.height), axisPaint);

    // วาดตัวเลขบนแกน Y
    final textStyle = TextStyle(color: Colors.black, fontSize: 10);
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i <= maxY; i += 10) {
      textPainter.text = TextSpan(
        text: '$i',
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-20, size.height - (i / maxY) * size.height - 6));
    }

    // วาดชื่อเดือนบนแกน X
    for (int i = 0; i < kacVisitPercents.length; i++) {
      String monthText;

      // ตรวจสอบว่าเป็นชื่อแรก (Avg)
      if (i == 0) {
        // ถ้าเป็นเดือนแรกให้ใช้ "Avg" และลบปีไป 1
        monthText =
            '${P01CUSSERVICEVAR.months[i]} ${(int.parse(selectedYear) - 1).toString().substring(2)}';
      } else {
        // เดือนอื่นๆ ใช้ชื่อเดือนตามปกติ
        monthText =
            '${P01CUSSERVICEVAR.months[i]} ${selectedYear.toString().substring(2)}';
      }

      textPainter.text = TextSpan(
        text: monthText,
        style: textStyle,
      );

      textPainter.layout();

      // คำนวณตำแหน่งกลางระหว่างแท่ง KAC และ Medium พร้อมเลื่อนตำแหน่งจากแกน Y ด้วย startXOffset
      final xPosition = startXOffset +
          i * (barWidth * 2 + spaceBetweenBars + spaceBetweenMonths) +
          (barWidth + spaceBetweenBars / 2) - // ใช้ค่า barWidth เพื่ออยู่กลาง
          (textPainter.width / 2); // วางให้ตรงกลางแท่ง

      textPainter.paint(canvas, Offset(xPosition, size.height + 5));
    }
  }

// ฟังก์ชั่นสำหรับวาดเส้นแกน X และ Y
  void drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;

    double distance = (end - start).distance;
    double dashCount = distance / (dashWidth + dashSpace);

    for (int i = 0; i < dashCount.floor(); i++) {
      double startX = start.dx + (i * (dashWidth + dashSpace));
      double endX = startX + dashWidth;
      canvas.drawLine(
        Offset(startX, start.dy),
        Offset(endX, start.dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // รีเพนท์ทุกครั้งเมื่อมีการเปลี่ยนแปลงข้อมูล
  }
}
