import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LayoutBasic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LayoutBasics(),
    );
  }
}

class LayoutBasics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentando aprender layout"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: TextField(
          onChanged: (String str) {
            String txt = str;
          },
          onSubmitted: print,
        ),
      ),
    );D
  }
}
