import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/recorditem.dart';


class RecordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('User not logged in.'));
    }

    CollectionReference recordsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('routes');

    return StreamBuilder<QuerySnapshot>(
      stream: recordsRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Kayıtlı rotanız bulunmamaktadır.',style: TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 18)));
        }

        List<Widget> recordWidgets = snapshot.data!.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          List<LatLng> path = (data['path'] as List)
              .map((point) => LatLng(point['latitude'], point['longitude']))
              .toList();

          String distance = data['distance'];
          String duration = data['duration'];
          String ts = data['ts'];
          String te = data['te'];
          String day = data['day'];
          String date = data['date'];
          String recordId = doc.id;

          return RecordItem(
            path: path,
            distance: distance,
            duration: duration,
            ts: ts,
            te: te,
            day: day,
            date: date,
            recordId: recordId,
          );
        }).toList();

        return ListView(children: recordWidgets);
      },
    );
  }
}