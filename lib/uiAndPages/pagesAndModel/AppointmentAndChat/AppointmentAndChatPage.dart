import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/decorations/BasePageScaffold.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/AppointmentAndChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/appointment/AppointmentPanel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatPanel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimation2.dart';
import 'package:provider/provider.dart';
import 'package:c_input/c_input.dart';

class AppointmentAndChatPage extends StatefulWidget {
  const AppointmentAndChatPage({Key? key}) : super(key: key);

  @override
  State<AppointmentAndChatPage> createState() => _AppointmentAndChatPageState();
}

class _AppointmentAndChatPageState extends State<AppointmentAndChatPage> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return BaseView<AppointmentAndChatModel>(

        onModelReady: (model){
          model.tabController = TabController(length: 2, vsync: this);

        },

        builder: (_, model)=>
            BasePageScaffold(
              pageTitle: "Book Appointment",
                pageIcon: Icon(Icons.supervisor_account),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SharedUi.vHeaderSpace(),

                      Selector(

                        selector: (_, AppointmentAndChatModel model)=> model.selectedTab,
                        builder: (_, AppointmentChatTab value, __)=> Row(
                          children: [
                            _tabButton("appointment", selected: value == AppointmentChatTab.appointment,
                              onTap: (){
                                model.selectedTab = AppointmentChatTab.appointment;
                                model.tabController.animateTo(1);
                              }
                            ),
                            SizedBox(width: 30,),
                            _tabButton("chat", selected: value == AppointmentChatTab.chat,
                                onTap: (){
                                  model.selectedTab = AppointmentChatTab.chat;
                                  model.tabController.animateTo(0);

                                }
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      Expanded(
                          child: TabBarView(
                            controller: model.tabController,
                            children: [
                              ChatPanel(),
                              AppointmentPanel(),
                            ],
                          )
                      )
                    ],
                  ),
                )
            ),
    );
  }

  Widget _tabButton(String label, {required bool selected, required Function() onTap}){
    return  ButtonAnimation2(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: selected ? Colors.blue.shade500 :Colors.grey.shade200,
            border: Border.all(color: SharedUi.getColor(ColorType.divergent)),
            borderRadius: BorderRadius.circular(20)
        ),
        child: SharedUi.smallText(label, colorType:
        selected ? ColorType.divergent:ColorType.outlier
        ),
      ),
    );
  }
}