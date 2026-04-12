import 'package:flutter/material.dart';

enum ParcelStatus {
  created,
  inTransit,
  delivered,
  delayed,
  outForDelivery,
  lost,
}

extension ParcelStatusX on ParcelStatus {
  // Skulle nok smides ind i en arb fil i stedet, men for the sake of time og simplicity, så ligger det her lige nu
  String get label {
    switch (this) {
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

  Color get color {
    switch (this) {
      case ParcelStatus.created:
        return Colors.grey.shade700;
      case ParcelStatus.inTransit:
        return Colors.blue.shade700;
      case ParcelStatus.delivered:
        return Colors.green.shade800;
      case ParcelStatus.delayed:
        return Colors.deepOrange.shade900;
      case ParcelStatus.outForDelivery:
        return Colors.brown.shade700;
      case ParcelStatus.lost:
        return Colors.red.shade700;
    }
  }
}