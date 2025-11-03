import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Center(
          child: 
            Text(
              "Second page!"
          ),
        )
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); //pop does not need as much info as push
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