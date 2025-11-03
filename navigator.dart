import 'package:flutter/material.dart';
import 'second_route.dart';

void main() {
  runApp(const MyApp());
}

const kBaseRoute = '/';               //creating a constant route 
const kSecondRoute = '/second';       // why name them this way?

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: kBaseRoute,
      routes: {
        kBaseRoute: (context) => (FirstRoute()),
        kSecondRoute: (context) => (SecondRoute()),
      },
      title: 'Navigation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Center(
          child: 
            Text(
              "First page!"
          ),
        )
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, kSecondRoute); //when we have named Route, use pushNamed
           },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
              ),
            fixedSize: Size(150, 30),
          ),
          child: 
            Center(
              child: Text(
                "Press me!"
              ),
            ),
          ),
      ),
    );
  }
}
