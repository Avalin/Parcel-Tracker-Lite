import 'package:flutter/material.dart';

class ParcelListScreen extends StatefulWidget {
  const ParcelListScreen({super.key});

  @override
  State<ParcelListScreen> createState() => _ParcelListScreenState();
}

class _ParcelListScreenState extends State<ParcelListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mine pakker'),
      ),
      body: Center(
        child: Text("Ingen pakker endnu.")
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Tilføj pakke',
        child: const Icon(Icons.add),
      ),
    );
  }
}
