import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mine pakker'),
      ),
      body: Center(
        child: Center(
          child: Text("Ingen pakker endnu.")
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Tilføj pakke',
        child: const Icon(Icons.add),
      ),
    );
  }
}
