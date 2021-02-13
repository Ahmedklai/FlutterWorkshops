import 'package:flutter/material.dart';
import './pong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pong Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/4b/95/55/4b95557350df01945b919e3d1e3779f6.jpg'),
                  fit: BoxFit.cover)),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(child: Pong())),
        ));
  }
}
