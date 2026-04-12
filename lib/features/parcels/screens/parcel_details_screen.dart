import 'package:flutter/material.dart';

class ParcelDetailScreen extends StatefulWidget {
  const ParcelDetailScreen({super.key});

  @override
  State<ParcelDetailScreen> createState() => _ParcelDetailScreenState();
}

class _ParcelDetailScreenState extends State<ParcelDetailScreen> {
  Widget _buildBody() {
    return const Center(
      child: Text('Ingen pakkedetaljer endnu'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pakkedetaljer'),
      ),
      body: _buildBody()
    );
  }
}