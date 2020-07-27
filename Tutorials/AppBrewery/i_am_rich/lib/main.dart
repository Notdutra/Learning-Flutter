import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red[900],
        appBar: AppBar(
          title: Text("I Am Rich"),
          backgroundColor: Colors.red[900],
          centerTitle: true,
        ),
        body: Center(
          child: Image(
            image: NetworkImage('https://assets.entrepreneur.com/content/3x2/2000/20160305000536-diamond.jpeg')
          ),
        ),
      ),
    ),
  );
}
