import 'package:flutter/material.dart';

class Splach extends StatelessWidget {
  const Splach({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(211, 251, 179, 97),
        ),
      ),
    );
  }
}
