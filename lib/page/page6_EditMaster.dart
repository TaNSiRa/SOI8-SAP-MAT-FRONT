// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/06-01-P6EDITMASTERGETDATA.dart';
import 'P6EDITMASTER/P6EDITMASTERMAIN.dart';

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
        create: (_) => P6EDITMASTERGETDATA_Bloc(),
        child: BlocBuilder<P6EDITMASTERGETDATA_Bloc,
            List<P6EDITMASTERGETDATAclass>>(
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
  List<P6EDITMASTERGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P6EDITMASTERMAIN(
      data: data,
    );
  }
}
