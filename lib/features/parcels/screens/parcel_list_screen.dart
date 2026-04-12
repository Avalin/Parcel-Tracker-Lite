import 'package:flutter/material.dart';
import 'package:parcel_tracker_lite/features/parcels/controllers/parcels_controller.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';
import 'package:parcel_tracker_lite/features/parcels/widgets/parcel_list_item.dart';

class ParcelListScreen extends StatefulWidget {
  const ParcelListScreen({super.key});

  @override
  State<ParcelListScreen> createState() => _ParcelListScreenState();
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

  Widget _buildBody() {
    if (_controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_controller.errorMessage != null) {
      return Center(
        child: Text(_controller.errorMessage!),
      );
    }

    final parcels = _controller.parcels;

    if (parcels.isEmpty) {
      return const Center(
        child: Text('Ingen pakker endnu'),
      );
    }

    return _buildParcelList(parcels);
  }

  Widget _buildParcelList(List<Parcel> parcels) {
    return ListView.builder(
      itemCount: parcels.length,
      itemBuilder: (context, index) {
        final parcel = parcels[index];
        return ParcelListItem(
          parcel: parcel,
          onTap: () {
            // Navigate to parcel details screen here
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mine pakker'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add parcel flow here
        },
        tooltip: 'Tilføj pakke',
        child: const Icon(Icons.add),
      ),
    );
  }
}