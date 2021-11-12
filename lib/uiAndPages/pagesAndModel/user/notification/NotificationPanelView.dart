import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/experimental/MyPaint.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationPanelModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';

class NotificationPanelView extends StatefulWidget {

  final UserModel userModel;

  const NotificationPanelView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<NotificationPanelView> createState() => _NotificationPanelViewState();
}

class _NotificationPanelViewState extends State<NotificationPanelView> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<double> animation;

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
          model.userModel = widget.userModel;

          Future.delayed(Duration(milliseconds: 700), (){
            if(mounted)
            animationController.forward();
          });



        },

        builder: (_, model) {
          return  Row(
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

                        Row(
                          children: [
                            SharedUi.smallText("Total Notifications : ", colorType: ColorType.info),
                            SharedWidgets.badge("30", ColorType.info),
                          ],
                        ),
                        SizedBox(width: 25,),
                        Row(
                          children: [
                            SharedUi.smallText("New Messages :", colorType: ColorType.success),
                            SharedWidgets.badge("30", ColorType.success),
                          ],
                        ),
                        SizedBox(width: 25,),
                        Row(
                          children: [
                            SharedUi.smallText("Appointments Pending :", colorType: ColorType.outlier),
                            SharedWidgets.badge("30", ColorType.outlier),
                          ],
                        ),
                        SizedBox(width: 25,),
                        Row(
                          children: [
                            SharedUi.smallText("Appointments Accepted :", colorType: ColorType.dark),
                            SharedWidgets.badge("30", ColorType.dark),
                          ],
                        ),

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
                            totalQuantity: 30,
                            quantity1: 10, quantity2: 5,
                            quantity3: 8, range: value,
                            color1: SharedUi.getColor(ColorType.success),
                            color2: SharedUi.getColor(ColorType.outlier),
                            color3: SharedUi.getColor(ColorType.dark),
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
                          child: SharedUi.normalText("VIEW", bold: true, colorType: ColorType.dark)),
                    )
                  ],
                ),


                // child: Container(
                //
                //   height: double.infinity,
                //   alignment: Alignment.center,
                //
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(color: Colors.blue, width: 10),
                //   ),
                //
                //   child: CText("View", fontWeight: FontWeight.bold,),
                // ),
              ),

              SizedBox(width: 20,)
            ],
          );
        }

    );

  }
}