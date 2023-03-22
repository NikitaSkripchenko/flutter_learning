import 'package:flutter/material.dart';

class Cup extends StatelessWidget {
  const Cup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(radius: 30),
    );
  }
}
