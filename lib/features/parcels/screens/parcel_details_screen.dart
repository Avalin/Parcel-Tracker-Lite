import 'package:flutter/material.dart';
import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';

class ParcelDetailScreen extends StatelessWidget {
  final Parcel parcel;

  const ParcelDetailScreen({
    super.key,
    required this.parcel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakkedetaljer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ParcelDetailRow(
              label: 'Trackingnummer',
              value: parcel.trackingNumber,
            ),
            const SizedBox(height: 16),
            _ParcelDetailRow(
              label: 'Postnummer',
              value: parcel.postCode.toString(),
            ),
            const SizedBox(height: 16),
            _ParcelDetailRow(
              label: 'Status',
              value: parcel.parcelStatus.label,
              valueColor: parcel.parcelStatus.color,
            ),
          ],
        ),
      ),
    );
  }
}

class _ParcelDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _ParcelDetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    
    return Semantics(
      label: '$label: $value',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}