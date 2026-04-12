import 'package:flutter/foundation.dart';
import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';

class ParcelsController extends ChangeNotifier {
  
  final _parcels = [
    Parcel(id: '1', trackingNumber: '123456789', postCode: 1000, parcelStatus: ParcelStatus.inTransit),
    Parcel(id: '2', trackingNumber: '987654321', postCode: 2000, parcelStatus: ParcelStatus.delivered),
  ];

  bool _isLoading = false;
  String? _errorMessage;

  List<Parcel> get parcels => List.unmodifiable(_parcels);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadParcels() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (error) {
      _errorMessage = 'Kunne ikke indlæse pakker.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addParcel({
    required String trackingNumber,
    required int postCode,
  }) async {
    _errorMessage = null;

    final trimmedTrackingNumber = trackingNumber.trim();

    if (trimmedTrackingNumber.isEmpty) {
      _errorMessage = 'Trackingnummer må ikke være tomt.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final parcel = Parcel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        trackingNumber: trimmedTrackingNumber,
        postCode: postCode,
        parcelStatus: ParcelStatus.created
      );

      _parcels.insert(0, parcel);
    } catch (error) {
      _errorMessage = 'Kunne ikke tilføje pakke.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}