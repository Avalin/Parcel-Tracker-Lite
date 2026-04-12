import 'package:flutter/material.dart';
import 'package:parcel_tracker_lite/features/parcels/screens/parcel_list_screen.dart';

class ParcelTrackerLite extends StatelessWidget {
  const ParcelTrackerLite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcel Tracker Lite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const ParcelListScreen(),
    );
  }
}