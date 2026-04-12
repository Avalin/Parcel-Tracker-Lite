import 'package:flutter/foundation.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';
import 'package:parcel_tracker_lite/features/parcels/services/parcel_storage_service.dart';
import 'package:parcel_tracker_lite/features/parcels/services/tracking_service.dart';

class ParcelsController extends ChangeNotifier {
  ParcelsController({
    ParcelStorageService? storageService,
    TrackingService? trackingService,
  }) : _storageService = storageService ?? ParcelStorageService(),
       _trackingService = trackingService ?? TrackingService();

  final ParcelStorageService _storageService;
  final TrackingService _trackingService;

  final List<Parcel> _parcels = [];

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
      final storedParcels = await _storageService.loadParcels();
      _parcels
        ..clear()
        ..addAll(storedParcels);
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
      final fetchedStatus = await _trackingService.fetchStatus(
        trackingNumber: trimmedTrackingNumber,
        postcode: postCode,
      );

      final parcel = Parcel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        trackingNumber: trimmedTrackingNumber,
        postCode: postCode,
        parcelStatus: fetchedStatus
      );

      _parcels.insert(0, parcel);
      await _storageService.saveParcels(_parcels);
    } catch (error) {
      _errorMessage = 'Kunne ikke tilføje pakke.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}