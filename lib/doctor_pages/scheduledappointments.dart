import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swasthya_setu/backend/appointment.dart';
import 'package:swasthya_setu/doctor_pages/patientstile.dart';

class ScheduledAppointments extends StatelessWidget {
  final String docUid;
  final Size size;
  const ScheduledAppointments(
      {super.key, required this.docUid, required this.size});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: scheduledAppointments(docUid),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text("Some Error Occurred , Please try after some time"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading..."),
          );
        } else {
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, int index) {
                  return snapshot.data!.docs
                      .map((document) => scheduledTile(document, size))
                      .toList()[index];
                }),
          );
        }
      },
    );
  }
}
