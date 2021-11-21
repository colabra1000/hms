import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:hms/enums.dart';
import 'package:hms/services/MyPlanService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/myPlan/myPLanListDisplay/MyPlanListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';



class MyPlanListDisplayPopperPanel extends StatefulWidget {

  final void Function(MyPlanListDisplayPopperModel model) exposeModel;


  MyPlanListDisplayPopperPanel(this.exposeModel, {Key? key}) : super(key: key);

  @override
  State<MyPlanListDisplayPopperPanel> createState() => _MyPlanListDisplayPopperPanelState();
}

class _MyPlanListDisplayPopperPanelState extends State<MyPlanListDisplayPopperPanel> {


  late MyPlanListDisplayPopperModel model;


  @override
  Widget build(BuildContext context) {
    return BaseView<MyPlanListDisplayPopperModel>(

        onModelReady: (model){

          this.model = model;
          widget.exposeModel(model);
          model.currentlySelectedPlan = model.currentPlan;
          // model.sortNotifications();

        },


        builder: (context, model){

          return  Selector(

            selector: (_, MyPlanListDisplayPopperModel model) => model.canDisplay,

            builder: (_, bool value, __) {


              return AnimatedOpacity(

                duration: Duration(milliseconds:300),

                opacity: !value ? 0 : 1,

                child: Stack(
                  children: [
                    _body(model),
                    //todo put in alignment
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: _lowerButton()),
                  ],
                ),
              );
            }
          );
        },
    );
  }




  Widget _body(MyPlanListDisplayPopperModel model){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: _myPlanListPanel(model),
    );
  }

  Widget _myPlanListPanel(MyPlanListDisplayPopperModel model){
    return  Selector(
      selector: (_, MyPlanListDisplayPopperModel model)=>null,
      builder: (_, value, __) {
        return ListView.builder(
          itemBuilder: (_, int i){


            return Column(
              children: [
                _myPlanListItem(i),
                if(i == 3-1)
                  SizedBox(height: 70,)
              ],
            );


          },

          itemCount: 3

        );
      }
    );
  }

  Widget _myPlanListItem(int i){

    String planName = MyPlanService.getPlanName(i);
    List attributes = MyPlanService.getAttributes(i);

    return Selector(

        selector: (_, MyPlanListDisplayPopperModel model) => model.currentlySelectedPlan,
        builder: (_, int? value, __) {
        return ButtonAnimator1(

          onTap2: (){
            model.currentlySelectedPlan = i;
          },

          child: Container(

            margin: const EdgeInsets.symmetric(vertical: 20),

            decoration: BoxDecoration(
              color: SharedUi.getColor(MyPlanService.getPlanColor(i)),
              borderRadius: BorderRadius.circular(15),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SharedUi.smallText(attributes[0], colorType: ColorType.light),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SharedUi.normalText(planName, colorType: ColorType.light, bold: true),
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: SharedUi.getColor(ColorType.light),
                            ),
                            child: IgnorePointer(

                              child: Radio(
                                  activeColor: SharedUi.getColor(ColorType.light),
                                  value: i, groupValue: model.currentlySelectedPlan,
                                  onChanged: (int? i){

                                  }),
                            ),
                          )
                        ],
                      ),

                      ...List.generate(attributes.length, (index){

                        if(index == 0 || index == attributes.length - 1)
                          return Container();

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.arrow_right_circle_fill, color: SharedUi.getColor(ColorType.light),),
                              SizedBox(width: 10,),
                              SharedUi.smallText(attributes[index], colorType: ColorType.light),
                            ],
                          ),
                        );

                      }),


                      Divider(color: SharedUi.getColor(ColorType.light),),

                      Align(
                        alignment: Alignment.centerRight,
                        child: SharedUi.smallText(model.getPrice(i), colorType: ColorType.light),

                      ),
                    ],
                  ),
                ),

                if(i == model.currentPlan)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                    color: SharedUi.getColor(ColorType.successLight)
                  ),
                  child: SharedUi.mediumText("current plan!", colorType: ColorType.light, bold: true),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _lowerButton(){

    return  Selector(
      selector: (_, MyPlanListDisplayPopperModel model) => model.currentlySelectedPlan,

      builder: (_, int? value, __) {


        return AnimatedOpacity(
          opacity: model.currentlySelectedPlan == model.currentPlan ? 0 : 1,
          duration: Duration(milliseconds: 500),
          child: _buttonBox(value),

        );


      }
    );
  }

  Widget _buttonBox(int? value){

    String label = "";
    String planName = MyPlanService.getPlanName(value);
    ColorType iconColorType = MyPlanService.getPlanColor(value);


    if((value ?? 0) > (model.currentPlan ?? -1)){
      label = "Downgrade to $planName Plan";
    }else
    if((value ?? 0) < (model.currentPlan ?? -1)){
      label = "Upgrade to $planName Plan";
    }else{
      label = "";
    }

    return ButtonAnimator2(

      onTap2: (){
        model.navigateToVerifyPlanChangePage(context, value);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,

        decoration: BoxDecoration(
          color: SharedUi.getColor(ColorType.faint),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SharedUi.smallText(label,
                    bold: true, colorType: ColorType.success,
                    alignment: TextAlign.center),
              ),
            ),

            Icon(Icons.add_moderator, color: SharedUi.getColor(iconColorType), size: 30,),

          ],
        ),
      ),
    );
  }


}
