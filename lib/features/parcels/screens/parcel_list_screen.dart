import 'package:flutter/material.dart';
import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';

class ParcelListScreen extends StatefulWidget {
  const ParcelListScreen({super.key});

  @override
  State<ParcelListScreen> createState() => _ParcelListScreenState();

  Widget _buildBody(List<Parcel> parcels) {
    if (parcels.isEmpty) {
      return const Center(child: Text('Ingen pakker endnu'));
    }

    return const Center(child: Text('To do: Vis liste af pakker her')); // Placeholder for parcel list
  }
}

class _ParcelListScreenState extends State<ParcelListScreen> {
  @override
  Widget build(BuildContext context) {
    // Dummy data (midlertidigt)
    final parcels = [
      Parcel(id: '1', trackingNumber: '123456789', postCode: '1000', parcelStatus: ParcelStatus.inTransit),
      Parcel(id: '2', trackingNumber: '987654321', postCode: '2000', parcelStatus: ParcelStatus.delivered),
    ];

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
