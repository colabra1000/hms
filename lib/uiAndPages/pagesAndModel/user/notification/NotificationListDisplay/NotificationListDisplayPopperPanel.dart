import 'package:c_input/c_input.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:hms/enums.dart';
import 'package:hms/models/Notification.dart';
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

          Expanded(child: _displayNotificationList(model)),

        ],
      ),
    );
  }

  Widget _displayLoadingIndicator(){
    return CircularProgressIndicator();
  }

  Widget _displayNotificationList(NotificationListDisplayPopperModel model){
    return  Selector(
      selector: (_, NotificationListDisplayPopperModel model)=>model.notifications!.length,
      builder: (_, int value, __) {
        return value == 0 ?
          Center(child: SharedUi.mediumText("You have no new Notification", maxLine: 4, bold: true)):
          ListView.builder(
          itemBuilder: (_, int i){
            return i == model.notifications!.length - 1 ?
                Column(
                  children: [
                    _notificationListItemDisplay(notification : model.notifications![i], context: context),
                    SizedBox(height: 20,)
                  ],
                ) :
                _notificationListItemDisplay(notification : model.notifications![i], context: context);
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



  Widget _notificationListItemDisplay({required Notification notification, required BuildContext context}){
    return ButtonAnimator1(

      onTap2: (){
        model.navigateToNotificationObject(context, notification);

        },

      child: Container(

        padding: const EdgeInsets.symmetric(horizontal:10, vertical: 15),

        margin: const EdgeInsets.symmetric(vertical: 10),

        height: 150,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Row(
          children: [

            Align(
                alignment: Alignment.topLeft,
                child: SharedWidgets.profileBox()),

            SizedBox(width: 10,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SharedUi.mediumText("${model.interpretType(notification.typeId)}", colorType: NotificationService.getNotificationColorType(notification.typeId),),
                  SharedUi.smallText("${model.explainNotification(notification)}", maxLine: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonAnimator2(child: SharedUi.mediumText("view", colorType: NotificationService.getNotificationColorType(notification.typeId))),

                      // ButtonAnimator2(child: SharedUi.mediumText("dismiss", colorType: ColorType.warning,), onTap2: (){
                      //   model.removeNotification(notification);
                      // },),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
