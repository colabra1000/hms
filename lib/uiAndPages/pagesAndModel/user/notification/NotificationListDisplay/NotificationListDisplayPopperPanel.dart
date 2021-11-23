import 'package:c_input/c_input.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:hms/enums.dart';
import 'package:hms/models/Notification.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationListDisplay/NotificationListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';



class NotificationListDisplayPopperPanel extends StatefulWidget {

  final void Function(NotificationListDisplayPopperModel model) exposeModel;


  NotificationListDisplayPopperPanel(this.exposeModel, {Key? key}) : super(key: key);

  @override
  State<NotificationListDisplayPopperPanel> createState() => _NotificationListDisplayPopperPanelState();
}

class _NotificationListDisplayPopperPanelState extends State<NotificationListDisplayPopperPanel> {


  late NotificationListDisplayPopperModel model;


  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationListDisplayPopperModel>(

        onModelReady: (model){

          this.model = model;
          widget.exposeModel(model);
          model.sortNotifications();

        },


        builder: (context, model){

          return Selector(

            selector: (_, NotificationListDisplayPopperModel model)=>model.notifications,

            builder: (_, List? value, __)=>AnimatedSwitcher(
                duration: Duration(milliseconds: 800),
                child: value == null ? _displayLoadingIndicator() :
                    _body(model),
            ),
          );
        },
    );
  }




  Widget _body(NotificationListDisplayPopperModel model){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,),
            child: _searchBar(),
          ),

          Expanded(child: _notificationListPanel(model)),

        ],
      ),
    );
  }

  Widget _displayLoadingIndicator(){
    return CircularProgressIndicator();
  }

  Widget _notificationListPanel(NotificationListDisplayPopperModel model){
    return  Selector(
      selector: (_, NotificationListDisplayPopperModel model)=>model.notifications!.length,
      builder: (_, int value, __) {
        return value == 0 ?
          Center(child: SharedUi.mediumText("You have no new Notification", maxLine: 4, bold: true)):
          ListView.builder(
          itemBuilder: (_, int i){




            return Column(
              children: [



                if(model.filter == NotificationService.FILTER_MESSAGE
                    && model.notifications![i].typeId == NotificationService.UNREAD_MESSAGES)
                   _notificationListItem(i),

                if (model.filter == NotificationService.FILTER_BOOKED_NOTIFICATIONS
                    && model.notifications![i].typeId == NotificationService.APPOINTMENT_BOOKED)
                    _notificationListItem(i),


                if(model.filter == NotificationService.FILTER_CANCELLED_NOTIFICATIONS
                && model.notifications![i].typeId == NotificationService.APPOINTMENT_CANCELLED)
                    _notificationListItem(i),


                if(model.filter == NotificationService.FILTER_NONE)
                    _notificationListItem(i),

                if(i == model.notifications!.length - 1)
                  SizedBox(height: 50,),


              ],
            );


          },

          itemCount: model.notifications!.length,

        );
      }
    );
  }

  Widget _searchBar(){

    return CTextField(model.searchInputController,
      prefixIcon: Icon(Icons.search_rounded,
        size: 35, color:SharedUi.getColor(ColorType.info),),
      hintText: "Search...",
    );
  }



  Widget _notificationListItem(int i){

    Notification notification = model.notifications![i];

    return ButtonAnimator1(
      onTap2: ()=> model.navigateToNotificationObject(context, notification),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          padding: const EdgeInsets.symmetric(horizontal:10, vertical: 15),

          margin: const EdgeInsets.symmetric(vertical: 10),

          // height: 150,

          decoration: BoxDecoration(
            color: SharedUi.getColor(ColorType.light2),
            borderRadius: BorderRadius.circular(15),
          ),

          child: Selector(

            selector: (_, NotificationListDisplayPopperModel model)=>model.notifications![i].typeId as int?,

            builder: (_, int? value, __) {

              String typeName = "";

              switch (notification.typeId){
                case NotificationService.UNREAD_MESSAGES :
                  typeName = "New message";
                  break;
                case NotificationService.APPOINTMENT_BOOKED :
                  typeName = "Appointment booked";
                  break;
                case NotificationService.APPOINTMENT_CANCELLED :
                  typeName = "Appointment cancelled";
                  break;
                default:
                  typeName = "";
              }




              return IntrinsicHeight(
                child: Row(
                  children: [

                    Align(
                        alignment: Alignment.topLeft,
                        child: SharedWidgets.profileBox()),

                    SizedBox(width: 10,),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SharedUi.mediumText(typeName, colorType: NotificationService.getNotificationColorType(notification.typeId),),

                          Expanded(
                            child: SharedUi.smallText("${model.explainNotification(notification)}",),
                          ),

                        Align(
                            alignment: Alignment.centerRight,
                            child: SharedUi.smallText(HelperService.formatToDate(notification.time))
                        ),


                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
