// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/03-01-P03ACHIEVEDCUSGETDATA.dart';
import 'P3ACHIEVEDCUS/P03ACHIEVEDCUSMAIN.dart';

//---------------------------------------------------------

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page3blockget();
  }
}

class Page3blockget extends StatelessWidget {
  const Page3blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P03ACHIEVEDCUSGETDATA_Bloc(),
        child: BlocBuilder<P03ACHIEVEDCUSGETDATA_Bloc,
            List<P03ACHIEVEDCUSGETDATAclass>>(
          builder: (context, data) {
            return Page3Body(
              data: data,
            );
          },
        ));
  }
}

class Page3Body extends StatelessWidget {
  Page3Body({
    super.key,
    this.data,
  });
  List<P03ACHIEVEDCUSGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P03ACHIEVEDCUSMAIN(
      data: data,
    );
  }
}
