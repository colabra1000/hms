import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/experimental/MyPaint.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/myPlan/MyPlanPanelModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationPanelModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';

class MyPlanPanelView extends StatefulWidget {

  final UserModel userModel;
  // final Function(NotificationPanelModel) expose;

  const MyPlanPanelView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<MyPlanPanelView> createState() => _MyPlanPanelViewState();
}

class _MyPlanPanelViewState extends State<MyPlanPanelView> with SingleTickerProviderStateMixin{


  late MyPlanPanelModel model;

  @override
  void initState() {

     super.initState();


  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BaseView<MyPlanPanelModel>(

        onModelReady: (model){
          this.model = model;
          model.userModel = widget.userModel;
        },

        builder: (_, model) {
          return Container(
            
            padding : EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green.withOpacity(.2),
            ),
            
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SharedUi.smallText("your current plan is",
                            alignment: TextAlign.center, colorType: ColorType.dark, maxLine: 200),

                        SharedUi.smallText("100% coverage",
                            alignment: TextAlign.center, colorType: ColorType.dark, maxLine: 200),

                        Row(
                          children: [
                            SharedUi.smallText("Active : ",
                                alignment: TextAlign.center, colorType: ColorType.dark, maxLine: 200),

                            SharedUi.smallText("Yes",
                                alignment: TextAlign.center, colorType: ColorType.danger, bold: true, maxLine: 200),

                          ],
                        ),



                      ],
                    ),
                  ),
                ),
                
                SizedBox(width: 10,),

                Expanded(
                  flex: 3,
                  child: ButtonAnimator2(
                    onTap2: (){
                      model.openMyPlanListDisplayPopper();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.withOpacity(.2),
                            Colors.blue.withOpacity(.2),
                            Colors.blue.shade50.withOpacity(0)
                          ]
                        )
                      ),
                      child: Column(
                        children: [
                          SharedUi.mediumText("Avalon"),
                          Expanded(
                            child: FittedBox(
                                // fit: BoxFit.fitHeight,
                                child: Icon(Icons.add_moderator_outlined, size: 900, color: SharedUi.getColor(ColorType.dark),)),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }

    );

  }

}