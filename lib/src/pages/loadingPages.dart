import 'package:flutter/material.dart';

class LoadingPages extends StatelessWidget {
  const LoadingPages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blueGrey[100],
        ),
      ),
    );
  }
}
