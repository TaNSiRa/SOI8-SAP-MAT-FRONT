// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/07-01-P07ASSEMBLEGRAPHGETDATA.dart';
import '../bloc/BlocEvent/07-02-P07ASSEMBLEGRAPHGETDATA1.dart';
import 'P7ASSEMBLEGRAPH/P07ASSEMBLEGRAPHMAIN.dart';

//---------------------------------------------------------

class Page7 extends StatelessWidget {
  const Page7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page7blockget();
  }
}

class Page7blockget extends StatelessWidget {
  const Page7blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P07ASSEMBLEGRAPHGETDATA_Bloc(),
        child: BlocBuilder<P07ASSEMBLEGRAPHGETDATA_Bloc,
            List<P07ASSEMBLEGRAPHGETDATAclass>>(
          builder: (context, data) {
            return Page7blockget1(
              data: data,
            );
          },
        ));
  }
}

class Page7blockget1 extends StatelessWidget {
  Page7blockget1({
    super.key,
    this.data,
  });
  List<P07ASSEMBLEGRAPHGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P07ASSEMBLEGRAPHGETDATA1_Bloc(),
        child: BlocBuilder<P07ASSEMBLEGRAPHGETDATA1_Bloc,
            List<P07ASSEMBLEGRAPHGETDATA1class>>(
          builder: (context, data1) {
            return Page7Body(
              data: data,
              data1: data1,
            );
          },
        ));
  }
}

class Page7Body extends StatelessWidget {
  Page7Body({
    super.key,
    this.data,
    this.data1,
  });
  List<P07ASSEMBLEGRAPHGETDATAclass>? data;
  List<P07ASSEMBLEGRAPHGETDATA1class>? data1;
  @override
  Widget build(BuildContext context) {
    return P07ASSEMBLEGRAPHMAIN(
      data: data,
      data1: data1,
    );
  }
}
