
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty/screens/router_screen.dart';
import 'data/state_manager.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => StateManager(),
      child:  const MaterialApp(
        title: 'Smart Recipe',
        home: RootApp(),
      ),
    );

  }
}






