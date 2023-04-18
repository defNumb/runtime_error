import 'package:flutter/material.dart';

class SamWidget extends StatelessWidget {
  const SamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
      child: Center(
        child: Text('Sam Widget'),
      ),
    );
  }
}
