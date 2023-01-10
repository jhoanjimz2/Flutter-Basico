import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fontSize30 = const TextStyle(fontSize: 30);
    int counter = 0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Home Screen'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Número de clicks',
          style: fontSize30,
        ),
        Text(
          '$counter',
          style: fontSize30,
        ),
      ])),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          counter++;
          print('Hola mundo $counter');
        },
      ),
    );
  }
}
