import 'package:flutter/material.dart';
import 'package:parcel_tracker_lite/features/parcels/controllers/parcels_controller.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';
import 'package:parcel_tracker_lite/features/parcels/widgets/parcel_list_item.dart';

class ParcelListScreen extends StatefulWidget {
  const ParcelListScreen({super.key});

  @override
  State<ParcelListScreen> createState() => _ParcelListScreenState();

  Widget _buildBody(List<Parcel> parcels) {
    if (parcels.isEmpty) {
      return const Center(child: Text('Ingen pakker endnu'));
    }

    return ListView.builder(
      itemCount: parcels.length,
      itemBuilder: (context, index) {
        final parcel = parcels[index];
        return ParcelListItem(
          parcel: parcel,
          onTap: () {
            // Navigate to parcel details screen her
          },
        );
      },
    );
  }
}

class _ParcelListScreenState extends State<ParcelListScreen> {
  late final ParcelsController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = ParcelsController();
    _controller.addListener(_onControllerChanged);
    _controller.loadParcels();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final parcels = _controller.parcels;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mine pakker'),
      ),
      body: widget._buildBody(parcels),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add parcel flow her
        },
        tooltip: 'Tilføj pakke',
        child: const Icon(Icons.add),
      ),
    );
  }
}
