import 'dart:math';

import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';

class TrackingService {
  final Random _random = Random();

  Future<ParcelStatus> fetchStatus({
    required String trackingNumber,
    required int postcode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final statuses = [
      ParcelStatus.created,
      ParcelStatus.inTransit,
      ParcelStatus.outForDelivery,
      ParcelStatus.delivered,
      ParcelStatus.delayed,
      ParcelStatus.lost,
    ];

    return statuses[_random.nextInt(statuses.length)];
  }
}