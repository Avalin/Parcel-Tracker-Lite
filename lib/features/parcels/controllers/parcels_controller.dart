import 'package:flutter/foundation.dart';
import 'package:parcel_tracker_lite/features/parcels/enums/parcel_status.dart';
import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';
import 'package:parcel_tracker_lite/features/parcels/services/parcel_storage_service.dart';

class ParcelsController extends ChangeNotifier {
  ParcelsController({
    ParcelStorageService? storageService,
  }) : _storageService = storageService ?? ParcelStorageService();

  final ParcelStorageService _storageService;

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
        
      await _storageService.saveParcels(_parcels);
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
      await _storageService.saveParcels(_parcels);
    } catch (error) {
      _errorMessage = 'Kunne ikke tilføje pakke.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}