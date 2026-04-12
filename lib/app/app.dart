import 'package:flutter/material.dart';
import 'package:parcel_tracker_lite/features/parcels/screens/my_home_page.dart';

class ParcelTrackerLite extends StatelessWidget {
  const ParcelTrackerLite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcel Tracker Lite',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}