import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';

class Parcel {
  final String id;
  final String trackingNumber;
  final int postCode;
  final ParcelStatus parcelStatus;

  const Parcel({
    required this.id,
    required this.trackingNumber,
    required this.postCode,
    required this.parcelStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trackingNumber': trackingNumber,
      'postcode': postCode,
      'latestStatus': parcelStatus.name
    };
  }

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      id: json['id'] as String,
      trackingNumber: json['trackingNumber'] as String,
      postCode: json['postcode'] as int,
      parcelStatus: ParcelStatus.values.byName(json['latestStatus'] as String),
    );
  }
}