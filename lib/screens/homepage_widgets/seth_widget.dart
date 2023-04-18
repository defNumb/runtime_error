import 'package:flutter/material.dart';

class SethWidget extends StatelessWidget {
  const SethWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.red,
      child: Center(
        child: Text('Seth Widget'),
        // this is what i want my widget to do
      ),
    );
  }
}
