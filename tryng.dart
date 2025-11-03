import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Squares'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Center(
            child: Text(
              title
            )
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Square(40),
                  Square(20),
                  Square(60),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                        Square(60),
                        Square(40),
                    ],
                   ),
                  Row(
                    children: [
                      Square(70),
                      Square(50),
                    ],
                  ),
                ],
              ),
            ]
            )
        )
    );
  }
}

class Square extends StatelessWidget {
  const Square(this.side, {super.key});

  final double side;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: side,
      height: side,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.orange,
          border: Border.all(width: 3, color: Colors.black)),
    );
  }
}