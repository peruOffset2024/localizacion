import 'package:coffee_aplication/screens/menu.dart';


import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     
     
      home: const Menu(),
    );
  }
}