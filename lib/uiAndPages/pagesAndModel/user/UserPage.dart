import 'package:hms/enums.dart';
import 'package:c_modal/c_modal.dart';
import 'package:c_popper/c_popper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/uiAndPages/decorations/PageBackgroundDecorator.dart';
import 'package:hms/uiAndPages/documents/UserPageDocument.dart';
import 'package:hms/uiAndPages/pagesAndModel/Base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/AppointmentAndMessagePanelView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/MessageListDisplay/MessageListDisplayPopperPanel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/OrganisationListDisplay/OrganisationiListDisplayPopperPanel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/myPlan/MyPlanTab.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationListDisplay/NotificationListDisplayPopperPanel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationPanelView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin{

  late UserModel model;


  @override
  Widget build(BuildContext context){

    return BaseView<UserModel>(

      onModelReady: (model){
        model.tabController = TabController(initialIndex: 0, vsync: this, length: 3);
        this.model = model;
      },

        builder: (context, model)=> CModal(
            controller: model.cModalController,

            builder:(_, CModalState state){

              if(state == CModalState.custom1){
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PopperPanel(
                      child: OrganisationListDisplayPopperPanel((model)=>this.model.organisationListDisplayPopperModel = model),

                      popperOpened: model.popperOpened,

                      onOpen: ()=>model.organisationListDisplayPopperModel.onOpen(),

                      onClose: model.cModalController.dismissModal,
                    ),
                  ),
                );
              }

              if(state == CModalState.custom2){
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PopperPanel(

                        child: MessageListDisplayPopperPanel((model)=>this.model.messageListDisplayPopperModel = model),

                        popperOpened: model.popperOpened,

                        onOpen: ()=>model.messageListDisplayPopperModel.onOpen(),

                        onClose: model.cModalController.dismissModal,
                    ),
                  ),
                );
              }

              if(state == CModalState.custom3){
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PopperPanel(

                        child: NotificationListDisplayPopperPanel((model)=>this.model.notificationListDisplayPopperModel = model),

                        popperOpened: model.popperOpened,

                        onOpen: ()=>model.messageListDisplayPopperModel.onOpen(),

                        onClose: model.cModalController.dismissModal
                    ),
                  ),
                );
              }

            },

            child: SafeArea(
              child: Scaffold(
                  body:PageBackGroundDecorator(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [

                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _logoutButton((){
                                  model.navigateToLandingPage(context);
                              }),

                              Icon(CupertinoIcons.ellipsis)
                            ],
                          ),

                          _categorySelectors(context, model),

                          SizedBox(
                            height: 30,
                          ),

                          Expanded(child: _tabView()),

                          SizedBox(
                            height: 30,
                          ),

                        ],
                      ),
                    ),
                  ),
              ),
            ),
          ),
    );
  }


  Widget _tabView(){
    return TabBarView(
      controller: model.tabController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        AppointmentAndMessagePanelView(userModel: model),
        NotificationPanelView(userModel: model,),
        MyPlanTab(),

      ],
    );
  }

  Widget _logoutButton(Function() onTap){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onTap,
            child: Row(
              children: [
                SharedUi.smallText("logout", bold: true),
                Icon(Icons.logout),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _categorySelectors(BuildContext context, UserModel model){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: SharedUi.getColor(ColorType.infoLight)),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(.1)

      ),

      constraints: BoxConstraints(
          minHeight: 300,
          minWidth: double.infinity
      ),
      
      padding: EdgeInsets.all(10),

      height: MediaQuery.of(context).size.height * .5,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: UserPageDocument.greetings
          ),
          Expanded(child: SharedUi.femaleAvatar()),
          SharedUi.normalText("${model.nameOfUser}"),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InfoBox(label: "Appointment\n & Messages", icon: Icon(Icons.calendar_today_sharp, color: SharedUi.getColor(ColorType.dark), size: 40,), onTap: (){

                    model.tabController.animateTo(0);
                  }),
                ),

                Expanded(
                  child: InfoBox(label: "Notification", icon: Icon(CupertinoIcons.bell, color: SharedUi.getColor(ColorType.dark), size: 40,), onTap: (){
                    model.tabController.animateTo(1);
                  }),
                ),

                Expanded(
                  child: InfoBox(label: "My Plan", icon: Icon(Icons.align_vertical_bottom, color: SharedUi.getColor(ColorType.dark), size: 40,), onTap: (){
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

}




class InfoBox extends StatelessWidget {
  final String label;
  final Icon icon;
  final Function()? onTap;

  const InfoBox({Key? key, this.onTap, required this.label, required this.icon}) : super(key: key);


  @override
  Widget build(BuildContext context) {

      return ButtonAnimator2(
          onTap: onTap,
          child: Container(

            height: MediaQuery.of(context).size.width * .25,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                // border: Border.all(color: Colors.grey.shade50),
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
                      child: SharedUi.smallText(label, maxLine: 2, colorType: ColorType.secondary),
                    ),
                  )),
                ],
              ),
            ),
          ),
      );

  }
}






// Widget _lowerButton2({required Color color, required Icon icon, required String label, Function()? onTap}){
//
//   return ButtonAnimator2(
//     onTap2: onTap,
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//
//       child: Stack(
//         children: [
//           ColorFiltered(
//             colorFilter: ColorFilter.mode(
//                 color,
//                 BlendMode.srcOut
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 // borderRadius: BorderRadius.circular(20)
//               ),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   margin: const EdgeInsets.all(10),
//                   height: 50,
//                   width: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.blue, // Color does not matter but should not be transparent
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//
//                 ),
//               ),
//             ),
//           ),
//
//           Column(
//             children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   margin: const EdgeInsets.all(10),
//                   height: 50,
//                   width: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: icon,
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: FittedBox(
//                     child: SharedUi.mediumText(
//                         label, maxLine: 5,
//                         colorType: ColorType.outlier
//                     )
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
//
//
//
//
//   // return ButtonAnimator2(
//   //   onTap: (){},
//   //   child: Stack(
//   //     children: [
//   //       Container(
//   //
//   //         padding: EdgeInsets.all(10),
//   //         height: double.infinity,
//   //
//   //         decoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(20),
//   //           color: color,
//   //         ),
//   //
//   //         child: SharedUi.mediumText("BookAppointment And Chat with Doctors", maxLine: 5),
//   //
//   //
//   //       ),
//   //       Align(
//   //         alignment: Alignment.topLeft,
//   //         child: Container(
//   //           width: 50,
//   //           height: 50,
//   //           color: Colors.purple,
//   //         ),
//   //       ),
//   //     ],
//   //   ),
//   // );
// }

