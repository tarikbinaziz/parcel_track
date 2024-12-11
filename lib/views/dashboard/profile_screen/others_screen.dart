import 'package:flutter/material.dart';
import 'package:parcel_track/config/app_text.dart';

class OthersScreen extends StatefulWidget {
  String title;
  OthersScreen({super.key, required this.title});

  @override
  State<OthersScreen> createState() => _OthersScreenState();
}

class _OthersScreenState extends State<OthersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(widget.title, style: AppTextStyle.title),
      ),
      body: const Center(child: Text("No Data Available")),
    );
  }
}
