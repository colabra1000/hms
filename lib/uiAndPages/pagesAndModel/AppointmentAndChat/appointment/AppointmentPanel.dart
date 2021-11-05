import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/appointment/AppointmentModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:c_ui/c_ui.dart';


class AppointmentPanel extends StatefulWidget{
  const AppointmentPanel({Key? key}) : super(key: key);

  @override
  State<AppointmentPanel> createState() => _AppointmentPanelState();
}

class _AppointmentPanelState extends State<AppointmentPanel> with AutomaticKeepAliveClientMixin<AppointmentPanel>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<AppointmentModel>(
        builder: (_, model){
          return Center(
        child: CText("Appointment"),
      );
        }
    );
  }

}
