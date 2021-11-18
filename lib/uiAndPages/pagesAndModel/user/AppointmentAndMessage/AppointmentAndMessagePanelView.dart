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


class AppointmentAndMessagePanelView extends StatefulWidget {

  final UserModel userModel;

  AppointmentAndMessagePanelView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<AppointmentAndMessagePanelView> createState() => _AppointmentAndMessagePanelViewState();
}

class _AppointmentAndMessagePanelViewState extends State<AppointmentAndMessagePanelView> {
  @override
  Widget build(BuildContext context) {
     return BaseView<AppointmentAndMessagePanelModel>(

       onModelReady: (model){
         model.userModel = widget.userModel;
         model.fetchMessage();
       },


        builder:(_, model)
        => Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: _lowerButton(
                  context,
                  onTap: (){
                    model.openMessageListDisplayPopper();
                  },
                  color: SharedUi.getColor(ColorType.success),
                  icon: Icon(CupertinoIcons.mail, color: SharedUi.getColor(ColorType.light),),
                  child: FittedBox(
                    child: Container(
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Selector(

                            selector: (_, AppointmentAndMessagePanelModel model)=> model.messageUnSee,

                            builder: (_, int? value, __) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SharedUi.mediumText("New", colorType: ColorType.secondary, size: 50),

                                  SharedWidgets.badge(context, model.messageUnSee, ColorType.error,),
                                ],
                              );
                            }
                          ),

                          SizedBox(height: 20,),

                          Selector(

                            selector:(_, AppointmentAndMessagePanelModel model)=>model.totalUnReadMessage,

                            builder: (_, int? value, __) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SharedUi.mediumText("Unread", colorType: ColorType.secondary, size: 50),


                                  SharedWidgets.badge(context, model.totalUnReadMessage, ColorType.error,),
                                ],
                              );
                            }
                          ),



                        ],
                      ),
                    ),
                  ),
                ),
            ),

            SizedBox(width: 20,),

            Expanded(
                child: _lowerButton(
                    context,
                    onTap: (){
                      model.openOrganisationListDisplayPopper();
                    },
                    color: SharedUi.getColor(ColorType.divergent),
                    icon: Icon(Icons.add_comment_outlined, color: SharedUi.getColor(ColorType.secondary),),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SharedUi.mediumText(
                              "Book Appointment",
                              size: 50,
                              maxLine: 1,
                              colorType: ColorType.secondary
                          ),
                          SharedUi.mediumText(
                              "And Chat Support",
                              size: 50,
                              maxLine: 1,
                              colorType: ColorType.secondary
                          ),
                        ],
                      ),
                    ),


                )
            ),

          ],
        ),
     );
  }

  Widget _lowerButton(BuildContext context, {required Color color, required Icon icon, required Widget child, Function()? onTap}){

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



                height: MediaQuery.of(context).size.width * .12,
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
              child: Container(
                // width: (MediaQuery.of(context).size.width / 2) - (30),
                alignment: Alignment.centerLeft,
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}