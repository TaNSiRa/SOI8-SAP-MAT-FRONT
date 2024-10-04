// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/06-01-P06TABLEREPORTOVERDUEGETDATA.dart';
import 'P6TABLEREPORTOVERDUE/P06TABLEREPORTOVERDUEMAIN.dart';

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
        create: (_) => P06TABLEREPORTOVERDUEGETDATA_Bloc(),
        child: BlocBuilder<P06TABLEREPORTOVERDUEGETDATA_Bloc,
            List<P06TABLEREPORTOVERDUEGETDATAclass>>(
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
  List<P06TABLEREPORTOVERDUEGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P06TABLEREPORTOVERDUEMAIN(
      data: data,
    );
  }
}
