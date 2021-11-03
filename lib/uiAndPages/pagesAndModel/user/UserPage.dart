import 'dart:math';

import 'package:c_modal/c_modal.dart';
import 'package:c_popper/c_popper.dart';
import 'package:c_ui/c_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/decorations/PageBackgroundDecorator.dart';
import 'package:hms/uiAndPages/documents/UserPageDocument.dart';
import 'package:hms/uiAndPages/pagesAndModel/Base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/appointment/AppoitmentTab.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationTab.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/preference/PreferenceTab.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimation2.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return BaseView<UserModel>(

      onModelReady: (model){
        model.tabController = TabController(initialIndex: 0, vsync: this, length: 3);
      },

        builder: (context, model)=> CModal(
            controller: model.cModalController,

            builder:(_, CModalState state){

              if(state == CModalState.custom1){
                return PopperPanel(
                    child: Container(),
                    popperOpened: model.popperOpened,
                    onOpen: (){},
                    onClose: (){
                      model.cModalController.changeModalState = CModalStateChanger(
                        state: CModalState.none,
                      );
                    }
                );
              }

              if(state == CModalState.custom2){
                return PopperPanel(
                    child: Container(),
                    popperOpened: model.popperOpened,
                    onOpen: (){},
                    onClose: (){
                      model.cModalController.changeModalState = CModalStateChanger(
                        state: CModalState.none,
                      );
                    }
                );
              }



            },

            child: SafeArea(
              child: Scaffold(
                  // pageTitle: "User",
                  body:PageBackGroundDecorator(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [

                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: (){

                                      model.navigateToLandingPage(context);

                                    },
                                    child: Row(
                                      children: [
                                        SharedUi.smallText("logout", bold: true),
                                        Icon(Icons.logout),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Align(
                                alignment: Alignment.centerLeft,
                                child: UserPageDocument.greetings
                            ),

                            _section1(context, model),

                            SizedBox(
                              height: 30,
                            ),

                            _section2(context, model),

                            SharedUi.vFooterSpace()

                          ],
                        ),
                      ),
                    ),
                  ),
              ),
            ),
          ),
    );
  }



  Widget _section1(BuildContext context, UserModel model){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade50),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(.2)
      ),

      constraints: BoxConstraints(
          minHeight: 300,
          minWidth: double.infinity
      ),

      height: MediaQuery.of(context).size.height * .5,
      child: Column(
        children: [
          Expanded(child: SharedUi.femaleAvatar()),
          SharedUi.normalText("Dr Nebular S."),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InfoBox(label: "appointments", icon: Icon(Icons.calendar_today_sharp, color: Colors.grey, size: 40,), onTap: (){
                    model.tabController.animateTo(0);
                  }),
                ),

                Expanded(
                  child: InfoBox(label: "Preference", icon: Icon(CupertinoIcons.gear, color: Colors.blue, size: 40,), onTap: (){
                    model.tabController.animateTo(1);
                  }),
                ),

                Expanded(
                  child: InfoBox(label: "Notification", icon: Icon(Icons.notification_important, color: Colors.red, size: 40,), onTap: (){
                    model.tabController.animateTo(2);
                  }),
                ),
              ],
            ),
          )

        ],
      ),

    );
  }

  Widget _section2(BuildContext context, UserModel model){

    return Container(

      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade50),
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue.withOpacity(.3),
      ),

      constraints: BoxConstraints(
          minHeight: 600,
          minWidth: double.infinity
      ),

      height: MediaQuery.of(context).size.height * .7,

      child: TabBarView(
        controller: model.tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          AppointmentTab(),
          PreferenceTab(model: model,),
          NotificationTab()
        ],
      ),


    );

  }

}




class InfoBox extends StatelessWidget {
  final String label;
  final Icon icon;
  final Function()? onTap;

  const InfoBox({Key? key, this.onTap, required this.label, required this.icon}) : super(key: key);


  @override
  Widget build(BuildContext context) {

      return ButtonAnimation2(
          onTap: onTap,
          child: Container(

            height: MediaQuery.of(context).size.width * .25,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade50),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade50.withOpacity(.3)
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Column(
                children: [
                  Expanded(child: icon),
                  Expanded(child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SharedUi.smallText(label, maxLine: 2),
                    ),
                  )),
                ],
              ),
            ),
          ),
      );

  }
}






