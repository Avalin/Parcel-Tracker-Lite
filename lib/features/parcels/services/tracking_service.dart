import 'dart:math';

import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';

class TrackingService {
  final Random _random = Random();

  Future<ParcelStatus> fetchStatus({
    required String trackingNumber,
    required int postCode,
  }) async {
    final delay = 500 + _random.nextInt(2500); // i mellem 500 og 3000 ms
    await Future.delayed(Duration(milliseconds: delay));

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