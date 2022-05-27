import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  double? frequence;
  @override
  Widget build(BuildContext context) {
    int frequence = 0;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(bottom: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("fréquence", style: TextStyle(fontSize: 30)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$frequence Hz",
                    style: const TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
