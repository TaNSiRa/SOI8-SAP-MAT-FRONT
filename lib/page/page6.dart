// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/06-01-P06PROGRESSGETDATA.dart';
import 'P6PROGRESS/P06PROGRESSMAIN.dart';

//---------------------------------------------------------

class Page6 extends StatelessWidget {
  const Page6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page6blockget();
  }
}

class Page6blockget extends StatelessWidget {
  const Page6blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P06PROGRESSGETDATA_Bloc(),
        child:
            BlocBuilder<P06PROGRESSGETDATA_Bloc, List<P06PROGRESSGETDATAclass>>(
          builder: (context, data) {
            return Page6Body(
              data: data,
            );
          },
        ));
  }
}

class Page6Body extends StatelessWidget {
  Page6Body({
    super.key,
    this.data,
  });
  List<P06PROGRESSGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P06PROGRESSMAIN(
      data: data,
    );
  }
}
