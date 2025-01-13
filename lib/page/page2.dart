// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/02-01-P02REPORTOVERKPIGETDATA.dart';
import 'P2REPORTOVERKPI/P02REPORTOVERKPIMAIN.dart';

//---------------------------------------------------------

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page2blockget();
  }
}

class Page2blockget extends StatelessWidget {
  const Page2blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P02REPORTOVERKPIGETDATA_Bloc(),
        child: BlocBuilder<P02REPORTOVERKPIGETDATA_Bloc,
            List<P02REPORTOVERKPIGETDATAclass>>(
          builder: (context, data) {
            return Page2Body(
              data: data,
            );
          },
        ));
  }
}

class Page2Body extends StatelessWidget {
  Page2Body({
    super.key,
    this.data,
  });
  List<P02REPORTOVERKPIGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P02REPORTOVERKPIMAIN(
      data: data,
    );
  }
}
