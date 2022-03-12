import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('hello'),
    ),
    body: Column( 
      children : [Container(
      decoration: BoxDecoration(color: Colors.red,),
      child: Text('test'),
    ),
      ],
    ));
  }
}

