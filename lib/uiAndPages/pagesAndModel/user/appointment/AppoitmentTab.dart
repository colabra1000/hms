import 'package:flutter/material.dart';
import 'package:c_ui/c_ui.dart';


class AppointmentTab extends StatelessWidget {
  const AppointmentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CText("appointments")
    );
  }
}