// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/01-01-P01PROGRESSGETDATA.dart';
import 'P1PROGRESS/P01PROGRESSMAIN.dart';

//---------------------------------------------------------

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page1blockget();
  }
}

class Page1blockget extends StatelessWidget {
  const Page1blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P01PROGRESSGETDATA_Bloc(),
        child:
            BlocBuilder<P01PROGRESSGETDATA_Bloc, List<P01PROGRESSGETDATAclass>>(
          builder: (context, data) {
            return Page1Body(
              data: data,
            );
          },
        ));
  }
}

class Page1Body extends StatelessWidget {
  Page1Body({
    super.key,
    this.data,
  });
  List<P01PROGRESSGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P01PROGRESSMAIN(
      data: data,
    );
  }
}
