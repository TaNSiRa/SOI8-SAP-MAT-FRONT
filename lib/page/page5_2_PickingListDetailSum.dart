// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newmaster/bloc/BlocEvent/05-03-P05_2PICKINGLISTDETAILSUMGETDATA.dart';
import 'package:newmaster/page/P5_2PICKINGLISTDETAILSUM/P05_2PICKINGLISTDETAILSUMMAIN.dart';

//---------------------------------------------------------

class Page5_2 extends StatelessWidget {
  const Page5_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page5_2blockget();
  }
}

class Page5_2blockget extends StatelessWidget {
  const Page5_2blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P05_2PICKINGLISTDETAILSUMGETDATA_Bloc(),
        child: BlocBuilder<P05_2PICKINGLISTDETAILSUMGETDATA_Bloc,
            List<P05_2PICKINGLISTDETAILSUMGETDATAclass>>(
          builder: (context, data) {
            return Page5_2Body(
              data: data,
            );
          },
        ));
  }
}

class Page5_2Body extends StatelessWidget {
  Page5_2Body({
    super.key,
    this.data,
  });
  List<P05_2PICKINGLISTDETAILSUMGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P05_2PICKINGLISTDETAILSUMMAIN(
      data: data,
    );
  }
}
