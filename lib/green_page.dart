import 'package:flutter/material.dart';

class GreenPage extends StatelessWidget {
  const GreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.green,
      body: Center(
        child: Text('This is green page', style: TextStyle(
          fontSize: 20,
          color: Colors.white
        ),),
      ),
    );
  }
}
