import 'dart:convert';

import 'package:parcel_tracker_lite/features/parcels/models/parcel.dart';
import 'package:parcel_tracker_lite/features/parcels/services/enums/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

// We use Shared Preferences here instead of Hive or Drift in this case, because limited time :D
class ParcelStorageService {
  Future<List<Parcel>> loadParcels() async {
    final preferences = await SharedPreferences.getInstance();
    final parcelStrings = preferences.getStringList(StorageKey.parcels.name);

    if (parcelStrings == null || parcelStrings.isEmpty) {
      return [];
    }

    return parcelStrings
        .map((parcelString) => Parcel.fromJson(jsonDecode(parcelString) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveParcels(List<Parcel> parcels) async {
    final preferences = await SharedPreferences.getInstance();

    final parcelStrings = parcels
        .map((parcel) => jsonEncode(parcel.toJson()))
        .toList();

    await preferences.setStringList(StorageKey.parcels.name, parcelStrings);
  }
}