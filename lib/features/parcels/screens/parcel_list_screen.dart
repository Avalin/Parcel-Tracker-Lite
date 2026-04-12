import 'package:flutter/material.dart';
import 'package:parcel_tracker_lite/features/parcels/controllers/parcels_controller.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';
import 'package:parcel_tracker_lite/features/parcels/screens/parcel_details_screen.dart';
import 'package:parcel_tracker_lite/features/parcels/widgets/add_parcel_dialog.dart';
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ParcelDetailScreen(parcel: parcel),
              ),
            );
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
        onPressed: _openAddParcelDialog,
        tooltip: 'Tilføj pakke',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openAddParcelDialog() async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return AddParcelDialog(
          onAddParcel: ({
            required String trackingNumber,
            required int postcode,
          }) async {
            await _controller.addParcel(
              trackingNumber: trackingNumber,
              postCode: postcode,
            );

            return _controller.errorMessage;
          },
        );
      },
    );
  }
}