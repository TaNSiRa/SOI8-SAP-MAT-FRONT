// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/05-02-P05_1PICKINGLISTDETAILGETDATA.dart';
import 'package:newmaster/page/P5_1PICKINGLISTDETAIL/P05_1PICKINGLISTDETAILMAIN.dart';

//---------------------------------------------------------

class Page5_1 extends StatelessWidget {
  const Page5_1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page5_1blockget();
  }
}

class Page5_1blockget extends StatelessWidget {
  const Page5_1blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P05_1PICKINGLISTDETAILGETDATA_Bloc(),
        child: BlocBuilder<P05_1PICKINGLISTDETAILGETDATA_Bloc,
            List<P05_1PICKINGLISTDETAILGETDATAclass>>(
          builder: (context, data) {
            return Page5_1Body(
              data: data,
            );
          },
        ));
  }
}

class Page5_1Body extends StatelessWidget {
  Page5_1Body({
    super.key,
    this.data,
  });
  List<P05_1PICKINGLISTDETAILGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P05_1PICKINGLISTDETAILMAIN(
      data: data,
    );
  }
}
