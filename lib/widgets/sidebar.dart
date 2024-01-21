

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthya_setu/providers/details.dart';

import 'package:swasthya_setu/user_pages/user_home_page.dart';
import 'package:swasthya_setu/user_pages/user_profile.dart';
import 'package:swasthya_setu/utils/colours.dart';
import 'package:swasthya_setu/utils/drawer_item.dart';
import 'package:swasthya_setu/widgets/active_doctors.dart';
import 'package:swasthya_setu/widgets/addresswidget.dart';
import 'package:swasthya_setu/widgets/doctorcard.dart';

import '../pages/historyappointments.dart';
import '../user_pages/User_Report_Page.dart';
import 'appointmenthistorywidget.dart';

class Sidebar extends StatefulWidget {
  final Size size;
  final String userid;

  const Sidebar({Key? key, required this.size,required this.userid}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailsProvider>().getUserdetails();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userDetailsMap =
        Provider.of<UserDetailsProvider>(context, listen: true)
            .getUserDetailsMap;

    return Drawer(
      child: Material(
        color: mainwhite,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 30, 24, 0),
          child: Column(
            children: [
              headerWidget(userDetailsMap),
              const SizedBox(height: 20),
              const Divider(thickness: 1, height: 10, color: Colors.green),
              const SizedBox(height: 20),
              DrawerItem(
                name: 'Dashboard',
                icon: Icons.dashboard_outlined,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Reports',
                icon: Icons.receipt,
                onPressed: () => onItemPressed(context, index: 1),
              ),
              const SizedBox(height: 30),
              DrawerItem(
                name: 'Appointments',
                icon: Icons.calendar_month,
                onPressed: () => onItemPressed(context, index: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget(Map<String, dynamic> userDetailsMap) {
    return Row(
      children: [
        IconButton(
          icon: CircleAvatar(
            backgroundImage: NetworkImage("${userDetailsMap['photoURL']}"),
            radius: 30.0,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => UserProfilePage(
                size: widget.size,
                name: userDetailsMap['name'],
                number: userDetailsMap['number'],
                age: userDetailsMap['age'],
                image: userDetailsMap['photoURL'],
                gender: userDetailsMap['gender'],
                mail: userDetailsMap['email'],
                address: userDetailsMap['address'],
              )),
            ));
          },
        ),
        const SizedBox(width: 20),
        Text(
          "${userDetailsMap['name']}",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserHomePage(size: widget.size)));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserReportPage()));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppointmentHistory(userUid: widget.userid,)));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }
}
