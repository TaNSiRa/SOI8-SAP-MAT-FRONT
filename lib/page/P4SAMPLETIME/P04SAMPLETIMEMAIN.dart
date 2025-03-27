// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/BlocEvent/04-01-P04SAMPLETIMEGETDATA.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/Loading.dart';
import '../../widget/function/helper.dart';
import '../../widget/piechart/chart_values_options.dart';
import '../../widget/piechart/legend_options.dart';
import '../../widget/piechart/pie_chart.dart';
import 'P04SAMPLETIMEVAR.dart';
import 'package:qr_flutter/qr_flutter.dart';

late BuildContext P04SAMPLETIMEMAINcontext;
ScrollController _controllerIN01 = ScrollController();

class P04SAMPLETIMEMAIN extends StatefulWidget {
  P04SAMPLETIMEMAIN({
    super.key,
    this.data,
  });
  List<P04SAMPLETIMEGETDATAclass>? data;

  @override
  State<P04SAMPLETIMEMAIN> createState() => _P04SAMPLETIMEMAINState();
}

class _P04SAMPLETIMEMAINState extends State<P04SAMPLETIMEMAIN> {
  @override
  void initState() {
    super.initState();
    // context.read<P04SAMPLETIMEGETDATA_Bloc>().add(P04SAMPLETIMEGETDATA_GET());
  }

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    P04SAMPLETIMEMAINcontext = context;
    // List<P04SAMPLETIMEGETDATAclass> _datain = widget.data ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: Center(
              child: Container(
                width: 250,
                height: 380,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue.shade900,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 5,
                              left: 0,
                              child: Text(
                                "Remain product",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Image.asset(
                                'assets/images/logo_tpk.png',
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: QrImageView(
                        data: "1010000055|2504012|LN-5223|SM|1500KG",
                        size: 150,
                        version: QrVersions.auto,
                      ),
                    ),
                    SizedBox(height: 10),
                    buildInfoRow("Order", "1010000055"),
                    buildInfoRow("Lot", "2504012"),
                    buildInfoRow("Mat", "LN-5223 | SM"),
                    buildInfoRow("Remain", "1500 KG"),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              FreeLoadingTan(P04SAMPLETIMEMAINcontext);
              Future.delayed(const Duration(milliseconds: 1000), () {
                capture(
                  _globalKey,
                  "ReportPDFCommonvar",
                ).then((value) {
                  Navigator.pop(P04SAMPLETIMEMAINcontext);
                });
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.blue),
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: const [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'Export to PDF',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    ),
  );
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 10);

    var firstControlPoint = Offset(size.width * 0.25, size.height);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 10);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.75, size.height - 20);
    var secondEndPoint = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
