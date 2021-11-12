import 'package:c_input/c_input.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Organisation.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/MessageListDisplay/MessageListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationListDisplay/NotificationListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';
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
          // model.onOpen = ()=>onOpen(model);
          widget.exposeModel(model);

        },


        builder: (context, model){



          return Selector(

            selector: (_, NotificationListDisplayPopperModel model)=>model.loading,

            builder: (_, bool value, __)=>AnimatedSwitcher(
                duration: Duration(milliseconds: 800),
                child: model.loading ? _displayLoadingIndicator() :
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
    return  ListView.builder(
      itemBuilder: (_, int i){
        if(i == model.messages.length - 1){
          return Column(
            children: [
              _notificationListItemDisplay(message : model.messages[i], context: context),
              SizedBox(height: 20,)
            ],
          );
        }

        return _notificationListItemDisplay(message : model.messages[i], context: context);
      },
      itemCount: model.messages.length,

    );
  }

  Widget _searchBar(){

    return CTextField(model.searchInputController,
      prefixIcon: Icon(Icons.search_rounded,
        size: 35, color:SharedUi.getColor(ColorType.info),),
      hintText: "Search...",
    );
  }

  Widget _notificationListItemDisplay({required Message message, required BuildContext context}){
    return ButtonAnimator1(

      onTap2: (){
        // model.navigateToMessagePage(context, message: message);
      },

      child: Container(

        padding: const EdgeInsets.symmetric(horizontal:10, vertical: 15),

        margin: const EdgeInsets.symmetric(vertical: 10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),

        child: Row(
          children: [

            SharedWidgets.profileBox(),

            SizedBox(width: 10,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SharedUi.mediumText("${message.organisationName ?? ""}" , colorType: ColorType.dark,),
                  SharedUi.smallText(message.subject ?? "", colorType: ColorType.secondary,),
                ],
              ),
            ),

           SharedWidgets.readStatus(message.readStatus ?? ""),
            
            
          ],
        ),
      ),
    );
  }







}
