import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/decorations/BasePageScaffold.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/AppointmentAndChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/appointment/AppointmentPanel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatPanel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';
import 'package:c_modal/c_modal.dart';

class AppointmentAndChatPage extends StatefulWidget {
  const AppointmentAndChatPage({Key? key}) : super(key: key);

  @override
  State<AppointmentAndChatPage> createState() => _AppointmentAndChatPageState();
}

class _AppointmentAndChatPageState extends State<AppointmentAndChatPage> with SingleTickerProviderStateMixin {

  late AppointmentAndChatModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView<AppointmentAndChatModel>(

        onModelReady: (model){
          this.model  = model;
          model.tabController = TabController(length: 2, vsync: this, initialIndex: 0);

          model.tabController.addListener(() {
            model.chatModel?.displayChatMessageBox =  model.tabController.index == 0;
          });

          WidgetsBinding.instance!.addPostFrameCallback((timeStep){
            setState(() {});
          });

        },

        builder: (_, model)=>
            BasePageScaffold(
              pageTitle: "Book Appointment",
                pageIcon: Icon(Icons.supervisor_account),
                child: CModal(
                  controller : model.cModalController,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [

                      //background
                      Container(
                        color: Colors.green,
                        child: Center(
                          child: SharedUi.mediumText("mt"),
                        ),
                      ),


                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          // height: ,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: SharedUi.getColor(ColorType.faint),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [

                                          SharedUi.mediumText("Dr ${model.organisationName}", colorType: ColorType.outlier, bold: true),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.medical_services_outlined, color: SharedUi.getColor(ColorType.secondary),
                                            size: 19,
                                          ),
                                          SizedBox(width: 5,),
                                          SharedUi.smallText(model.doctorJobDescription, colorType: ColorType.secondary),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),


                              Selector(

                                selector: (_, AppointmentAndChatModel model)=> model.selectedTab,
                                builder: (_, AppointmentChatTab value, __){



                                  return Row(
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
                                            // print(model.chatModel);

                                          }
                                      ),
                                    ],
                                  );
                                },
                              ),

                            ],
                          ),
                        )
                      ),



                      Column(
                        children: [
                          SizedBox(height: 140,),
                          Expanded(
                             child: Container(

                                 child: TabBarView(

                                   controller: model.tabController,
                                   children: [
                                     ChatPanel(exposeModel: (ChatModel model){
                                       this.model.chatModel = model;
                                       this.model.chatModel?.displayChatMessageBox = true;

                                     },),

                                     AppointmentPanel(model.cModalController),
                                   ],
                                 )
                             ),
                          )
                        ],
                      ),


                      Selector(

                        selector: (_, AppointmentAndChatModel model)=>model.chatModel?.displayChatMessageBox,
                        //
                        builder: (_, bool? value, __){


                          double wHeight = model.chatModel?.chatMessageBoxHeight ?? MediaQuery.of(context).size.height;


                          return AnimatedPositioned(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            bottom: value == true ? 0 : -wHeight,
                              height: wHeight,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                                height: wHeight,
                                child: model.chatModel?.chatBox ?? Container()
                            )
                          );

                        }
                      ),


                    ],
                  ),
                )
            ),
    );
  }






  Widget _tabButton(String label, {required bool selected, required Function() onTap}){
    return  ButtonAnimator2(
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
        selected ? ColorType.light:ColorType.secondary
        ),
      ),
    );
  }
}
