// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, file_names, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/02-01-P02REPORTOVERKPIGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import '../P6TABLEREPORTOVERDUE/P06TABLEREPORTOVERDUEMAIN.dart';
import 'P02REPORTOVERKPIVAR.dart';

late BuildContext P02REPORTOVERKPIMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P02REPORTOVERKPIMAIN extends StatefulWidget {
  P02REPORTOVERKPIMAIN({
    super.key,
    this.data,
  });
  List<P02REPORTOVERKPIGETDATAclass>? data;

  @override
  State<P02REPORTOVERKPIMAIN> createState() => _P02REPORTOVERKPIMAINState();
}

class _P02REPORTOVERKPIMAINState extends State<P02REPORTOVERKPIMAIN> {
  @override
  void initState() {
    super.initState();
    context
        .read<P02REPORTOVERKPIGETDATA_Bloc>()
        .add(P02REPORTOVERKPIGETDATA_GET());
  }

  @override
  Widget build(BuildContext context) {
    P02REPORTOVERKPIMAINcontext = context;
    List<P02REPORTOVERKPIGETDATAclass> _datain = widget.data ?? [];

    // ตัวแปรสําหรับใช้กับ Dropdown
    final selectedType = (P02REPORTOVERKPIVAR.DropDownType.isNotEmpty)
        ? P02REPORTOVERKPIVAR.DropDownType
        : 'Group A';
    final selectedYear = (P02REPORTOVERKPIVAR.DropDownYear.isNotEmpty)
        ? P02REPORTOVERKPIVAR.DropDownYear
        : P02REPORTOVERKPIVAR.currentYear;
    final selectedMonth = (P02REPORTOVERKPIVAR.DropDownMonth.isNotEmpty)
        ? P02REPORTOVERKPIVAR.DropDownMonth
        : P02REPORTOVERKPIVAR.currentMonth2;
    // แปลง MM เป็น MMM
    final selectedMonthMMM = P02REPORTOVERKPIVAR
        .convertMonthToMMM(P02REPORTOVERKPIVAR.DropDownMonth);

    // Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupTargetDaysMap = {
      'Group A': P02REPORTOVERKPIVAR.GroupATargetDays,
      'Group B': P02REPORTOVERKPIVAR.GroupBTargetDays,
    };

    // เลือก Group A,B ตาม selectedType
    final GroupTargetDays = groupTargetDaysMap[selectedType] ??
        P02REPORTOVERKPIVAR.GroupATargetDays;

    // Map สำหรับจับคู่ระหว่าง selectedType กับ GroupTargetDays
    final groupSampleTimeMap = {
      'Group A': P02REPORTOVERKPIVAR.GroupAsampleTime,
      'Group B': P02REPORTOVERKPIVAR.GroupBsampleTime,
    };

    // เลือก Group A,B ตาม selectedType
    final groupSampleTime = groupSampleTimeMap[selectedType] ??
        P02REPORTOVERKPIVAR.GroupAsampleTime;

    // กำหนด Period ตาม selectedType
    final typeValue = (selectedType == 'A')
        ? 12
        : (selectedType == 'B')
            ? 10
            : 0;

    // กรองข้อมูลด้วย Type ,YEAR ,MONTH
    List<P02REPORTOVERKPIGETDATAclass> filteredData = _datain.where((data) {
      return data.TYPE == selectedType;
    }).toList();

    print(filteredData.length);

    //แยกข้อมูล week 1-4
    List<Map<String, String>> newData = [];
    for (var data in filteredData) {
      if (data.REPDAYS1.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          P02REPORTOVERKPIVAR.extractYear(data.REPDUE1) == selectedYear &&
          P02REPORTOVERKPIVAR.extractMonth(data.REPDUE1) == selectedMonth &&
          int.tryParse(data.REPDAYS1)! > int.tryParse(data.KPIPERIOD)!) {
        List<double> bdReviseValues1 = [
          data.BDREVISE1_1,
          data.BDREVISE1_2,
          data.BDREVISE1_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdSubLeadValues1 = [
          data.BDSUBLEAD1,
          data.BDSUBLEAD1_1,
          data.BDSUBLEAD1_2,
          data.BDSUBLEAD1_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdGLValues1 = [
          data.BDGL1,
          data.BDGL1_1,
          data.BDGL1_2,
          data.BDGL1_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdMGRValues1 = [
          data.BDMGR1,
          data.BDMGR1_1,
          data.BDMGR1_2,
          data.BDMGR1_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdJPValues1 = [
          data.BDJP1,
          data.BDJP1_1,
          data.BDJP1_2,
          data.BDJP1_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        double bdrevise1 = bdReviseValues1.isNotEmpty
            ? bdReviseValues1.reduce((a, b) => a + b) / bdReviseValues1.length
            : 0;
        double bdsublead1 = bdSubLeadValues1.isNotEmpty
            ? bdSubLeadValues1.reduce((a, b) => a + b) / bdSubLeadValues1.length
            : 0;
        double bdgl1 = bdGLValues1.isNotEmpty
            ? bdGLValues1.reduce((a, b) => a + b) / bdGLValues1.length
            : 0;
        double bdmgr1 = bdMGRValues1.isNotEmpty
            ? bdMGRValues1.reduce((a, b) => a + b) / bdMGRValues1.length
            : 0;
        double bdjp1 = bdJPValues1.isNotEmpty
            ? bdJPValues1.reduce((a, b) => a + b) / bdJPValues1.length
            : 0;

        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'month': data.MONTH,
          'year': data.YEAR,
          'bdprepare': data.BDPREPARE1,
          'bdttc': data.BDTTC1,
          'bdissue': data.BDISSUE1,
          'bdrevise': bdrevise1.toString(),
          'bdsublead': bdsublead1.toString(),
          'bdgl': bdgl1.toString(),
          'bdmgr': bdmgr1.toString(),
          'bdjp': bdjp1.toString(),
          'bdsent': data.BDSENT1,
        };
        newData.add(transformedData1);
      }

      if (data.REPDAYS2.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          P02REPORTOVERKPIVAR.extractYear(data.REPDUE2) == selectedYear &&
          P02REPORTOVERKPIVAR.extractMonth(data.REPDUE2) == selectedMonth &&
          int.tryParse(data.REPDAYS2)! > int.tryParse(data.KPIPERIOD)!) {
        List<double> bdReviseValues2 = [
          data.BDREVISE2_1,
          data.BDREVISE2_2,
          data.BDREVISE2_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdSubLeadValues2 = [
          data.BDSUBLEAD2,
          data.BDSUBLEAD2_1,
          data.BDSUBLEAD2_2,
          data.BDSUBLEAD2_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdGLValues2 = [
          data.BDGL2,
          data.BDGL2_1,
          data.BDGL2_2,
          data.BDGL2_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdMGRValues2 = [
          data.BDMGR2,
          data.BDMGR2_1,
          data.BDMGR2_2,
          data.BDMGR2_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdJPValues2 = [
          data.BDJP2,
          data.BDJP2_1,
          data.BDJP2_2,
          data.BDJP2_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        double bdrevise2 = bdReviseValues2.isNotEmpty
            ? bdReviseValues2.reduce((a, b) => a + b) / bdReviseValues2.length
            : 0;
        double bdsublead2 = bdSubLeadValues2.isNotEmpty
            ? bdSubLeadValues2.reduce((a, b) => a + b) / bdSubLeadValues2.length
            : 0;
        double bdgl2 = bdGLValues2.isNotEmpty
            ? bdGLValues2.reduce((a, b) => a + b) / bdGLValues2.length
            : 0;
        double bdmgr2 = bdMGRValues2.isNotEmpty
            ? bdMGRValues2.reduce((a, b) => a + b) / bdMGRValues2.length
            : 0;
        double bdjp2 = bdJPValues2.isNotEmpty
            ? bdJPValues2.reduce((a, b) => a + b) / bdJPValues2.length
            : 0;

        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'month': data.MONTH,
          'year': data.YEAR,
          'bdprepare': data.BDPREPARE2,
          'bdttc': data.BDTTC2,
          'bdissue': data.BDISSUE2,
          'bdrevise': bdrevise2.toString(),
          'bdsublead': bdsublead2.toString(),
          'bdgl': bdgl2.toString(),
          'bdmgr': bdmgr2.toString(),
          'bdjp': bdjp2.toString(),
          'bdsent': data.BDSENT2,
        };
        newData.add(transformedData1);
      }

      if (data.REPDAYS3.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          P02REPORTOVERKPIVAR.extractYear(data.REPDUE3) == selectedYear &&
          P02REPORTOVERKPIVAR.extractMonth(data.REPDUE3) == selectedMonth &&
          int.tryParse(data.REPDAYS3)! > int.tryParse(data.KPIPERIOD)!) {
        List<double> bdReviseValues3 = [
          data.BDREVISE3_1,
          data.BDREVISE3_2,
          data.BDREVISE3_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdSubLeadValues3 = [
          data.BDSUBLEAD3,
          data.BDSUBLEAD3_1,
          data.BDSUBLEAD3_2,
          data.BDSUBLEAD3_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdGLValues3 = [
          data.BDGL3,
          data.BDGL3_1,
          data.BDGL3_2,
          data.BDGL3_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdMGRValues3 = [
          data.BDMGR3,
          data.BDMGR3_1,
          data.BDMGR3_2,
          data.BDMGR3_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdJPValues3 = [
          data.BDJP3,
          data.BDJP3_1,
          data.BDJP3_2,
          data.BDJP3_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        double bdrevise3 = bdReviseValues3.isNotEmpty
            ? bdReviseValues3.reduce((a, b) => a + b) / bdReviseValues3.length
            : 0;
        double bdsublead3 = bdSubLeadValues3.isNotEmpty
            ? bdSubLeadValues3.reduce((a, b) => a + b) / bdSubLeadValues3.length
            : 0;
        double bdgl3 = bdGLValues3.isNotEmpty
            ? bdGLValues3.reduce((a, b) => a + b) / bdGLValues3.length
            : 0;
        double bdmgr3 = bdMGRValues3.isNotEmpty
            ? bdMGRValues3.reduce((a, b) => a + b) / bdMGRValues3.length
            : 0;
        double bdjp3 = bdJPValues3.isNotEmpty
            ? bdJPValues3.reduce((a, b) => a + b) / bdJPValues3.length
            : 0;

        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'month': data.MONTH,
          'year': data.YEAR,
          'bdprepare': data.BDPREPARE3,
          'bdttc': data.BDTTC3,
          'bdissue': data.BDISSUE3,
          'bdrevise': bdrevise3.toString(),
          'bdsublead': bdsublead3.toString(),
          'bdgl': bdgl3.toString(),
          'bdmgr': bdmgr3.toString(),
          'bdjp': bdjp3.toString(),
          'bdsent': data.BDSENT3,
        };
        newData.add(transformedData1);
      }

      if (data.REPDAYS4.isNotEmpty &&
          data.KPIPERIOD.isNotEmpty &&
          P02REPORTOVERKPIVAR.extractYear(data.REPDUE4) == selectedYear &&
          P02REPORTOVERKPIVAR.extractMonth(data.REPDUE4) == selectedMonth &&
          int.tryParse(data.REPDAYS4)! > int.tryParse(data.KPIPERIOD)!) {
        // ตรวจสอบค่าที่ไม่ใช่ null หรือ empty สำหรับ bdrevise
        List<double> bdReviseValues4 = [
          data.BDREVISE4_1,
          data.BDREVISE4_2,
          data.BDREVISE4_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!) // ใช้ map เพื่อให้แน่ใจว่าทุกค่าคือ double
            .toList();

        List<double> bdSubLeadValues4 = [
          data.BDSUBLEAD4,
          data.BDSUBLEAD4_1,
          data.BDSUBLEAD4_2,
          data.BDSUBLEAD4_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdGLValues4 = [
          data.BDGL4,
          data.BDGL4_1,
          data.BDGL4_2,
          data.BDGL4_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdMGRValues4 = [
          data.BDMGR4,
          data.BDMGR4_1,
          data.BDMGR4_2,
          data.BDMGR4_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        List<double> bdJPValues4 = [
          data.BDJP4,
          data.BDJP4_1,
          data.BDJP4_2,
          data.BDJP4_3
        ]
            .map((value) =>
                value != null ? double.tryParse(value.toString()) : null)
            .where((value) => value != null)
            .map((value) => value!)
            .toList();

        double bdrevise4 = bdReviseValues4.isNotEmpty
            ? bdReviseValues4.reduce((a, b) => a + b) / bdReviseValues4.length
            : 0;
        double bdsublead4 = bdSubLeadValues4.isNotEmpty
            ? bdSubLeadValues4.reduce((a, b) => a + b) / bdSubLeadValues4.length
            : 0;
        double bdgl4 = bdGLValues4.isNotEmpty
            ? bdGLValues4.reduce((a, b) => a + b) / bdGLValues4.length
            : 0;
        double bdmgr4 = bdMGRValues4.isNotEmpty
            ? bdMGRValues4.reduce((a, b) => a + b) / bdMGRValues4.length
            : 0;
        double bdjp4 = bdJPValues4.isNotEmpty
            ? bdJPValues4.reduce((a, b) => a + b) / bdJPValues4.length
            : 0;

        Map<String, String> transformedData1 = {
          'type': data.TYPE,
          'month': data.MONTH,
          'year': data.YEAR,
          'bdprepare': data.BDPREPARE4,
          'bdttc': data.BDTTC4,
          'bdissue': data.BDISSUE4,
          'bdrevise': bdrevise4.toString(),
          'bdsublead': bdsublead4.toString(),
          'bdgl': bdgl4.toString(),
          'bdmgr': bdmgr4.toString(),
          'bdjp': bdjp4.toString(),
          'bdsent': data.BDSENT4,
        };
        newData.add(transformedData1);
      }
    }
    print("newData: $newData");

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
      print("sumList: $sumList");
      // หา Avg ของ sumList
      if (sumList.isNotEmpty) {
        double avgTotal = sumList.reduce((a, b) => a + b) / sumList.length;
        avgTotal = double.parse(avgTotal.toStringAsFixed(2));

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
              // .where((item) =>
              //     item['type'] == selectedType &&
              //     item['month'] == P02REPORTOVERKPIVAR.DropDownMonth &&
              //     item['year'] == selectedYear)
              .toList();

          if (filteredItems.isNotEmpty) {
            double AvgBreakdown = filteredItems
                    .map((item) =>
                        (double.tryParse(item[breakdown] ?? '0.0') ?? 0.0))
                    .fold(0.0, (sum, freq) => sum + freq) /
                filteredItems.length;

            AvgBreakdown = double.parse(AvgBreakdown.toStringAsFixed(2));
            avgAllBreakdown.add(AvgBreakdown);
          }
        }
      } else {
        print("sumList is empty.");
      }
    } else {}
    print("avgAllBreakdown: $avgAllBreakdown");
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
                    'Report Over KPI: Customer $selectedType (Target ≤ $typeValue days) ($selectedMonthMMM $selectedYear)',
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
                              groupSampleTime,
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
                                if (P02REPORTOVERKPIVAR.DropDownType.isNotEmpty ||
                                    P02REPORTOVERKPIVAR
                                        .DropDownYear.isNotEmpty ||
                                    P02REPORTOVERKPIVAR
                                        .DropDownMonth.isNotEmpty)
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
                                    // MapEntry("TYPE", ""),
                                    MapEntry("Group A", "A"),
                                    MapEntry("Group B", "B"),
                                  ],
                                  onChangeinside: (d, k) {
                                    setState(() {
                                      P02REPORTOVERKPIVAR.DropDownType = d;
                                      // context
                                      //     .read<P02REPORTOVERKPIGETDATA_Bloc>()
                                      //     .add(P02REPORTOVERKPIGETDATA_GET());
                                    });
                                  },
                                  value: P02REPORTOVERKPIVAR.DropDownType,
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
                                if (P02REPORTOVERKPIVAR.DropDownType.isNotEmpty ||
                                    P02REPORTOVERKPIVAR
                                        .DropDownYear.isNotEmpty ||
                                    P02REPORTOVERKPIVAR
                                        .DropDownMonth.isNotEmpty)
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
                                    // MapEntry("YEAR", ""),
                                    MapEntry("2023", "2023"),
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
                                      P02REPORTOVERKPIVAR.DropDownYear = d;
                                      // context
                                      //     .read<P02REPORTOVERKPIGETDATA_Bloc>()
                                      //     .add(P02REPORTOVERKPIGETDATA_GET());
                                    });
                                  },
                                  value: P02REPORTOVERKPIVAR.DropDownYear,
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
                                if (P02REPORTOVERKPIVAR.DropDownType.isNotEmpty ||
                                    P02REPORTOVERKPIVAR
                                        .DropDownYear.isNotEmpty ||
                                    P02REPORTOVERKPIVAR
                                        .DropDownMonth.isNotEmpty)
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
                                    // MapEntry("MONTH", ""),
                                    MapEntry("Jan", "01"),
                                    MapEntry("Feb", "02"),
                                    MapEntry("Mar", "03"),
                                    MapEntry("Apr", "04"),
                                    MapEntry("May", "05"),
                                    MapEntry("Jun", "06"),
                                    MapEntry("Jul", "07"),
                                    MapEntry("Aug", "08"),
                                    MapEntry("Sep", "09"),
                                    MapEntry("Oct", "10"),
                                    MapEntry("Nov", "11"),
                                    MapEntry("Dec", "12"),
                                  ],
                                  onChangeinside: (d, k) {
                                    setState(() {
                                      P02REPORTOVERKPIVAR.DropDownMonth = d;
                                      // context
                                      //     .read<P02REPORTOVERKPIGETDATA_Bloc>()
                                      //     .add(P02REPORTOVERKPIGETDATA_GET());
                                    });
                                  },
                                  value: P02REPORTOVERKPIVAR.DropDownMonth,
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
          ),
        ),
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
  final selectedYear = (P02REPORTOVERKPIVAR.DropDownYear.isNotEmpty)
      ? P02REPORTOVERKPIVAR.DropDownYear
      : P02REPORTOVERKPIVAR.currentYear;

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
        TargetText = GroupTargetDays[i].toStringAsFixed(2);

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
        ActualText = avgAllBreakdown[i].toStringAsFixed(2);

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

      monthText = P02REPORTOVERKPIVAR.breakdown[i];

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
