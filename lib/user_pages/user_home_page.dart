import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthya_setu/providers/details.dart';
import 'package:swasthya_setu/utils/colours.dart';
import 'package:swasthya_setu/widgets/active_doctors.dart';
import 'package:swasthya_setu/widgets/addresswidget.dart';

import '../widgets/sidebar.dart';

class UserHomePage extends StatefulWidget {
  final Size size;

  const UserHomePage({Key? key, required this.size}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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

    return SafeArea(
      child: Scaffold(
        drawer: Sidebar(size: widget.size, userid: userDetailsMap['uid']),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Home Page",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Dosis',
            ),
          ),
          centerTitle: true,
          backgroundColor: maingreen,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15,
                  ),
                  hintText: "Search Doctors",
                  suffixIcon: const Icon(Icons.search_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
              SizedBox(
                height: widget.size.height * 0.002,
              ),
              const Text(
                "Your Location",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Dosis-Regular',
                ),
              ),
              const AddressText(),
              SizedBox(
                height: widget.size.height * 0.002,
              ),
              Expanded(child: ActiveDoctorList(size: widget.size)),
            ],
          ),
        ),
      ),
    );
  }
}
