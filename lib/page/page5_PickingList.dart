// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/05-01-P05PICKINGLISTGETDATA.dart';
import 'P5PICKINGLIST/P05PICKINGLISTMAIN.dart';

//---------------------------------------------------------

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page5blockget();
  }
}

class Page5blockget extends StatelessWidget {
  const Page5blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P05PICKINGLISTGETDATA_Bloc(),
        child: BlocBuilder<P05PICKINGLISTGETDATA_Bloc,
            List<P05PICKINGLISTGETDATAclass>>(
          builder: (context, data) {
            return Page5Body(
              data: data,
            );
          },
        ));
  }
}

class Page5Body extends StatelessWidget {
  Page5Body({
    super.key,
    this.data,
  });
  List<P05PICKINGLISTGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P05PICKINGLISTMAIN(
      data: data,
    );
  }
}
