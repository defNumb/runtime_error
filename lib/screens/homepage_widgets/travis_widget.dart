import 'package:flutter/material.dart';

class TravisWidget extends StatelessWidget {
  const TravisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
      child: Center(
        child: Text('Travis Widget'),
        //Get 5 random pets from the list of pets and pull up a picture every time
        //they come back to the home page, showcasing "popular" animals
      ),
    );
  }
}
