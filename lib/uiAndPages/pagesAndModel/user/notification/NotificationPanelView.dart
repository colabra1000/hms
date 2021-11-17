import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/experimental/MyPaint.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationPanelModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';

class NotificationPanelView extends StatefulWidget {

  final UserModel userModel;
  final Function(NotificationPanelModel) expose;

  const NotificationPanelView({Key? key, required this.userModel, required this.expose}) : super(key: key);

  @override
  State<NotificationPanelView> createState() => _NotificationPanelViewState();
}

class _NotificationPanelViewState extends State<NotificationPanelView> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<double> animation;
  late NotificationPanelModel model;

  @override
  void initState() {

     super.initState();

     animationController = AnimationController(
         vsync: this, duration: Duration(milliseconds: 1500),
         animationBehavior: AnimationBehavior.normal
     );

     animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOutCubic);

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationPanelModel>(

        onModelReady: (model){
          this.model = model;

          widget.expose(model);

          model.userModel = widget.userModel;

          Future.delayed(Duration(milliseconds: 300), (){

            model.fetchNotifications().then((value){
              if(mounted)
                animationController.forward();
            });

          });

        },

        builder: (_, model) {
          return

            Selector(

                selector: (_, NotificationPanelModel model) => model.notifications?.length,

                builder: (_, int? value, __) => Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.blue.shade300.withOpacity(.3),
                              Colors.yellow.withOpacity(0),
                            ]
                          )
                        ),

                        child: FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [



                              _button1(NotificationService.UNREAD_MESSAGES,),

                              SizedBox(height: 25,),
                              _button1(NotificationService.APPOINTMENT_BOOKED,),

                              SizedBox(height: 25,),
                              _button1(NotificationService.APPOINTMENT_CANCELLED,),

                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [

                          Align(
                            alignment: Alignment.center,
                            child: AnimatedBuilder(
                              animation: animation,
                              builder: (context, _) {
                                double value = animation.value;

                                return MyPaint(
                                  strokeWidth: MediaQuery.of(context).size.width * .03,
                                  totalQuantity: model.totalNotification?.toDouble() ?? 0,
                                  quantity1: model.newMessages?.toDouble() ?? 0,
                                  quantity2: model.appointmentBooked?.toDouble() ?? 0,
                                  quantity3: model.appointmentCancelled?.toDouble() ?? 0,

                                  range: value,
                                  color1: SharedUi.getColor(NotificationService.getNotificationColorType(NotificationService.UNREAD_MESSAGES)),
                                  color2: SharedUi.getColor(NotificationService.getNotificationColorType(NotificationService.APPOINTMENT_BOOKED)),
                                  color3: SharedUi.getColor(NotificationService.getNotificationColorType(NotificationService.APPOINTMENT_CANCELLED)),
                                );
                              },
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: ButtonAnimator2(
                                onTap2: (){
                                  widget.userModel.openNotificationListDisplayPopper();
                                },
                                child: SharedUi.mediumText("VIEW ALL", bold: true, colorType: ColorType.dark),),
                          )
                        ],
                      ),



                    ),

                    SizedBox(width: 20,)
                  ],
                )
            );
        }

    );

  }


  _button1(int type){

    String mLabel;
    int? quantity;

    switch (type){
      case NotificationService.UNREAD_MESSAGES :
        mLabel = "New Message";
        quantity =  model.newMessages;
        break;
      case NotificationService.APPOINTMENT_BOOKED :
        mLabel = "Booked Appointment";
        quantity = model.appointmentBooked;
        break;
      default :
        mLabel = "Cancelled Appointment";
        quantity = model.appointmentCancelled;
    }

    return   ButtonAnimator2(
      child: Row(
        children: [
          SharedWidgets.badge(context, quantity, NotificationService.getNotificationColorType(type)),
          SizedBox(height: 30,),
          SharedUi.smallText(mLabel, colorType: NotificationService.getNotificationColorType(type), size: MediaQuery.of(context).size.width * .15),
        ],
      ),
    );
  }


}