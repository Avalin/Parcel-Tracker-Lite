import 'package:flutter/material.dart';
import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';

class ParcelListItem extends StatelessWidget {
  final Parcel parcel;
  final VoidCallback? onTap;

  const ParcelListItem({
    super.key,
    required this.parcel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Pakke ${parcel.trackingNumber}, status ${parcel.parcelStatus.label}',
      button: true,
      child: ListTile(
        title: Text(parcel.trackingNumber),
        subtitle: Text(parcel.parcelStatus.label),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}