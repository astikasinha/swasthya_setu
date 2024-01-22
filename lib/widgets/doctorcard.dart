import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swasthya_setu/pages/bookingpage.dart';
import 'package:swasthya_setu/utils/colours.dart';
import 'package:swasthya_setu/utils/gettime.dart';
import 'package:swasthya_setu/widgets/textwidget.dart';



Widget doctorCard(Size size, DocumentSnapshot document, BuildContext context) {
  Map<String, dynamic> doctorInfo = document.data() as Map<String, dynamic>;

  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppointmentBookingPage(
                    size: size,
                    name: doctorInfo['name'],
                    pfpLink: doctorInfo['photoURL'],
                    address: doctorInfo['address'],
                    mail: doctorInfo['email'],
                    phoneNumber: doctorInfo['number'],
                    bio: doctorInfo['bio'],
                    exp: doctorInfo['age'],
                    close: getDateTimeText(
                        (doctorInfo['close'] as Timestamp).toDate()),
                    specialization: doctorInfo['specialization'],
                    open: getDateTimeText(
                        (doctorInfo['open'] as Timestamp).toDate()),
                    qualification: doctorInfo['qualification'],
                    doctorUID: doctorInfo['uid'],
                    doctorInfo: doctorInfo,
                  )));
        },
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: maingreen,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    doctorInfo['name'],
                    style: TextStyle(
                        fontSize: size.width / 20,
                        fontWeight: FontWeight.bold,
                    fontFamily: 'Dosis-Bold',
                    color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white),
                      child: Text(
                        doctorInfo['age'] + "yr Exp.",
                        style: TextStyle(fontSize: size.width / 30),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        "Specializations : ",
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.w500,
                        fontFamily: 'Dosis-Regular',),
                      )),
                  Text(doctorInfo['specialization'].toString(),
                      style: TextStyle(
                          fontSize: size.width / 25,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        "Address : ",
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.w500),
                      )),
                  Column(
                    children: [
                      DoctorAddress(
                          address: doctorInfo['address'].toString(), size: size),
                    
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: mainwhite,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                  
                          child: Row(
                            children: [
                          
                              Text(
                                "OPEN:  ",
                                style: TextStyle(
                                    fontSize: size.width / 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              DoctorAddress(
                                  address: getDateTimeText(
                                      (doctorInfo['open'] as Timestamp).toDate()),
                                  size: size),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              //DoctorAddress(address: "CLOSE :   ", size: size),
                              Text(
                                "CLOSE:  ",
                                style: TextStyle(
                                    fontSize: size.width / 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              DoctorAddress(
                                  address: getDateTimeText(
                                      (doctorInfo['close'] as Timestamp).toDate()),
                                  size: size),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: size.height * 0.02,
      )
    ],
  );
}
