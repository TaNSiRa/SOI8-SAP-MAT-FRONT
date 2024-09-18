// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/04-01-P04PROGRESSGETDATA.dart';
import 'P4PROGRESS/P04PROGRESSMAIN.dart';

//---------------------------------------------------------

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page4blockget();
  }
}

class Page4blockget extends StatelessWidget {
  const Page4blockget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P04PROGRESSGETDATA_Bloc(),
        child:
            BlocBuilder<P04PROGRESSGETDATA_Bloc, List<P04PROGRESSGETDATAclass>>(
          builder: (context, data) {
            return Page4Body(
              data: data,
            );
          },
        ));
  }
}

class Page4Body extends StatelessWidget {
  Page4Body({
    super.key,
    this.data,
  });
  List<P04PROGRESSGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P04PROGRESSMAIN(
      data: data,
    );
  }
}
