import 'package:flutter/material.dart';

import 'TEST.dart';
import 'page1.dart';
import 'page4.dart';

bool isChecked = false;

class Page0 extends StatelessWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page1();
    // return Page4();
  }
}

class Page0Body extends StatelessWidget {
  const Page0Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Container(
      //     height: 100,
      //     width: 200,
      //     color: Colors.orange,
      //     child: const Center(
      //         child: Text("initial Page \nor do something wrong"))),
      child: FILEpicfunction(),
    );
  }
}
