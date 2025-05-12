// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/BlocEvent/04-01-P4ORDERHISTORYGETDATA.dart';
import 'P4ORDERHISTORY/P4ORDERHISTORYMAIN.dart';

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
        create: (_) => P4ORDERHISTORYGETDATA_Bloc(),
        child: BlocBuilder<P4ORDERHISTORYGETDATA_Bloc,
            List<P4ORDERHISTORYGETDATAclass>>(
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
  List<P4ORDERHISTORYGETDATAclass>? data;
  @override
  Widget build(BuildContext context) {
    return P4ORDERHISTORYMAIN(
      data: data,
    );
  }
}
