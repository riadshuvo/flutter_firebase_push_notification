import 'package:flutter/material.dart';

class RedPage extends StatelessWidget {
  const RedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.red,
      body: Center(
        child: Text('This is red page', style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),),
      ),
    );
  }
}
