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
import 'package:hms/uiAndPages/pagesAndModel/user/userSubPages/displayDoctorList/DoctorListDisplayPanel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/userSubPages/updateInformation/UpdateInformationPanel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin{

  Type mState = MState;

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
                    child: UpdateInformationPanel(),
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
                    child: DoctorListDisplayPanel(),
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
          color: Colors.grey.withOpacity(.4),
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

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CText("Appointment"),
    );
  }
}

class PreferenceTab extends StatelessWidget {

  final UserModel model;

  PreferenceTab({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(height: 50,),
          Align(
              alignment: Alignment.centerLeft,
              child: SharedUi.normalText("Preferences", colorType:ColorType.light, bold: true)),
          SizedBox(height: 50,),
          Expanded(
              child: Column(
                children: [
                 _mListTile(context, label: "Change Doctor", icon: Icon(Icons.supervised_user_circle_sharp, size: 25, color: SharedUi.getColor(ColorType.secondary2),),
                     onTap2: (){
                       model.openChangeDoctorPopper();
                     }

                 ),

                  _mListTile(context, label: "Update Information", icon: Icon(Icons.system_update, size: 25, color: SharedUi.getColor(ColorType.secondary2),),
                  onTap2: (){
                     model.openUpdateInformationPopper();
                  }
                 ),
                 _mListTile(context, label: "Update Plan", icon: Icon(Icons.next_plan_outlined, size: 25, color: SharedUi.getColor(ColorType.secondary2))),
                ],
              )
          )
        ],
      ),
    );
  }
  
  Widget _mListTile(BuildContext context, {required String label, required Icon icon, Function()? onTap, Function()? onTap2}){
    
    return ButtonAnimator1(
       onTap: onTap, onTap2: onTap2,
       child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade50.withOpacity(.3),
            borderRadius: BorderRadius.circular(10)
          ),

          width: MediaQuery.of(context).size.width * .8,

          child: Row(
            children: [
            SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
            SizedBox(width: 10,),

            Expanded(child: SharedUi.normalText(label, colorType:ColorType.dark, size: 15, maxLine: 2)),

            ],
          ),
       ),
   );

  }
}
//
// class MListTile extends StatefulWidget {
//   //action immediately when button is pressed.
//   final Function()? onTap;
//
//   //action when button is pressed and animation is finished.
//   final Function()? onTap2;
//
//   final String label;
//   final Icon icon;
//   const MListTile({Key? key, this.onTap2, this.onTap, required this.label, required this.icon,}) : super(key: key);
//
//   @override
//   _MListTileState createState() => _MListTileState();
// }
//
// class _MListTileState extends State<MListTile> with SingleTickerProviderStateMixin{
//
//   late AnimationController animationController;
//   late Animation<Offset> animation;
//
//   @override
//   void initState() {
//
//     Duration halfDuration = Duration(milliseconds: 200);
//
//     animationController = AnimationController(vsync: this, duration: halfDuration);
//
//     animation = Tween<Offset>(begin: Offset(0,0), end: Offset(.05, 0)).animate(CurvedAnimation(
//         parent: animationController, curve: Curves.easeOut));
//
//     animationController.addStatusListener((status) {
//       if(status == AnimationStatus.completed){
//         animationController.animateBack(0, duration: halfDuration, curve: Curves.easeOut);
//         // animationController.reverse();
//       }
//
//       if(status == AnimationStatus.dismissed){
//         widget.onTap2?.call();
//       }
//     });
//
//      super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: animation,
//       child: GestureDetector(
//         onTap: (){
//           animationController.reset();
//           animationController.forward();
//           widget.onTap?.call();
//         },
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 5),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           decoration: BoxDecoration(
//               color: Colors.grey.shade50.withOpacity(.3),
//               borderRadius: BorderRadius.circular(10)
//           ),
//
//           width: MediaQuery.of(context).size.width * .8,
//
//           child: Row(
//             children: [
//               SizedBox(width: 10,),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: widget.icon,
//               ),
//               SizedBox(width: 10,),
//
//               Expanded(child: SharedUi.normalText(widget.label, colorType:ColorType.dark, size: 15, maxLine: 2)),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









class NotificationTab extends StatelessWidget {
  const NotificationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CText("Notifications"),
    );
  }
}


class InfoBox extends StatefulWidget {
  final String label;
  final Icon icon;
  final Function()? onTap;

  const InfoBox({Key? key, this.onTap, required this.label, required this.icon}) : super(key: key);

  @override
  _InfoBoxState createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400), value: 1);

    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animationController,
          curve: CustomCurve(),
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      return ScaleTransition(
        scale: animation,

        child: GestureDetector(
          onTap: (){
            animationController.reset();
            animationController.forward();
            widget.onTap?.call();
          },
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
                  Expanded(child: widget.icon), 
                  Expanded(child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SharedUi.smallText(widget.label, maxLine: 2),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      );

  }
}

class CustomCurve extends Curve{
  @override
  double transformInternal(double t) {

    return .1 * sin(pi*t) + 1;
  }
}

enum MState{
  changeDoctor,
  updateInformation,
  updatePlan
}




