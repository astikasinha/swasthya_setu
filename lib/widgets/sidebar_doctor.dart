import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthya_setu/providers/details.dart';

import 'package:swasthya_setu/utils/colours.dart';
import 'package:swasthya_setu/utils/drawer_item.dart';

import '../doctor_pages/doctor_home_page.dart';
import '../doctor_pages/doctor_profile_page.dart';
import '../user_pages/User_Report_Page.dart';

class SidebarDoctor extends StatefulWidget {
  final Size size;

  const SidebarDoctor({Key? key, required this.size}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<SidebarDoctor> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorDetailsProvider>().getDoctordetails();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userDetailsMap =
        Provider.of<DoctorDetailsProvider>(context, listen: true)
            .getDoctorDetailsMap;

    return Drawer(
      child: Material(
        color: mainwhite,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 30, 24, 0),
          child: Column(
            children: [
              headerWidget(userDetailsMap, widget.size),
              const SizedBox(height: 20),
              const Divider(thickness: 1, height: 2, color: Colors.green),
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

  Widget headerWidget(Map<String, dynamic> userDetailsMap, Size size) {
    return GestureDetector( onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => DoctorProfilePage(
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
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("${userDetailsMap['photoURL']}"),
            radius: size.width * 0.2,
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                "${userDetailsMap['name']}",
                style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 20),
              Text(
                "${userDetailsMap['specialization']}",
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorHomePage(size: widget.size)));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserReportPage()));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorHomePage(size: widget.size)));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }
}
