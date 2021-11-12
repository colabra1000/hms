import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/AppointmentAndMessagePanelModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';


class AppointmentAndMessagePanelView extends StatelessWidget {

  final UserModel userModel;

  AppointmentAndMessagePanelView({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BaseView<AppointmentAndMessagePanelModel>(



       builder:(_, model) => Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child:
              Selector(

                selector:(_, AppointmentAndMessagePanelModel model) => model.messages,

                builder : (_, List? value, __){
               
                  return _lowerButton(context,
                    onTap: (){
                      userModel.openMessageListDisplayPopper();
                    },
                    color: SharedUi.getColor(ColorType.success),
                    icon: Icon(CupertinoIcons.mail, color: SharedUi.getColor(ColorType.light),),
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SharedUi.mediumText("New", colorType: ColorType.secondary),

                            SharedWidgets.badge(model.unSeenMessage, ColorType.error,),
                          ],
                        ),

                        SizedBox(height: 3,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SharedUi.mediumText("Unread", colorType: ColorType.secondary),
                            SizedBox(width: 50,),
                            SharedWidgets.badge(model.unReadMessage, ColorType.secondary)
                          ],
                        ),



                      ],
                    ),
                );
                },
              )
          ),

          SizedBox(width: 20,),

          Expanded(
              child: _lowerButton(
                  context,
                  onTap: (){
                    userModel.openDoctorListDisplayPopper();
                  },
                  color: SharedUi.getColor(ColorType.divergent),
                  icon: Icon(Icons.add_comment_outlined, color: SharedUi.getColor(ColorType.secondary),),
                  label: SharedUi.mediumText(
                      "Book Appointment\nAnd Chat Support\n",
                      maxLine: 5,
                      colorType: ColorType.secondary
                  ),


              )
          ),


        ],
    ),
     );
  }



  Widget _lowerButton(BuildContext context, {required Color color, required Icon icon, required Widget label, Function()? onTap}){

    return ButtonAnimator2(
      onTap2: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: SharedUi.getColor(ColorType.infoLight)),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(.1),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(

                constraints: BoxConstraints(
                  maxHeight: 50,
                  maxWidth: 50
                ),

                height: MediaQuery.of(context).size.width * .2,
                // width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                ),
                child: AspectRatio(
                    aspectRatio: 1,
                    child: icon),
              ),
            ),

            SizedBox(height: 10,),

            Expanded(
              child: FittedBox(
                child: Container(
                  width: (MediaQuery.of(context).size.width / 2) - (30),
                  alignment: Alignment.centerLeft,
                  child: label,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}