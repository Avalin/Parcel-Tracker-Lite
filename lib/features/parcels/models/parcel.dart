import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';

class Parcel {
  final String id;
  final String trackingNumber;
  final String postCode;
  final ParcelStatus parcelStatus;

  const Parcel({
    required this.id,
    required this.trackingNumber,
    required this.postCode,
    required this.parcelStatus,
  });
}