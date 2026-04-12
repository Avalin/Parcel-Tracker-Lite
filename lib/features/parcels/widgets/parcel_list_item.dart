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

  String _statusText(ParcelStatus status) {
    switch (status) {
      case ParcelStatus.outForDelivery:
        return 'Ude til levering';
      case ParcelStatus.inTransit:
        return 'Undervejs';
      case ParcelStatus.delivered:
        return 'Leveret';
      case ParcelStatus.delayed:
        return 'Forsinket';
      case ParcelStatus.created:
        return 'Oprettet';
      case ParcelStatus.lost:
        return 'Forsvundet';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Pakke ${parcel.trackingNumber}, status ${_statusText(parcel.parcelStatus)}',
      button: true,
      child: ListTile(
        title: Text(parcel.trackingNumber),
        subtitle: Text(_statusText(parcel.parcelStatus)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}