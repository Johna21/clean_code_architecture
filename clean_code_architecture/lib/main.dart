import 'package:flutter/material.dart';

import 'features/number_trivia/presentation/widget/injection_container.dart' as di;
void main() async{
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      // home: ,
    );
  }
}

