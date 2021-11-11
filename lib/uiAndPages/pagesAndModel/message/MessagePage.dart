import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/message/MessageModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MessageModel>(
        builder: (_, model) => Scaffold(
          backgroundColor: SharedUi.getColor(ColorType.light2),
            body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SharedUi.mediumText("Messages"),
                              SharedUi.mButton(
                                height: 3,
                                prepend: Icon(CupertinoIcons.back, size: 15,),
                                edgePads: 20,
                                buttonColorType: ColorType.infoLight,
                                textColorType: ColorType.dark,
                                label: "back",
                                onTap: (){
                                  model.navigateBack(context);
                                }
                              ),
                            ],
                          ),
                        ),
                      ),





                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal : 20, vertical: 30),
                            decoration: BoxDecoration(
                              color: SharedUi.getColor(ColorType.light),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [

                                Row(
                                  children: [
                                    SharedWidgets.profileBox(),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SharedUi.smallText(model.message.organisationName ?? "", colorType: ColorType.info),
                                        SharedUi.smallText(model.message.subject ?? "", bold: true),

                                      ],
                                    ),
                                    Spacer(),
                                    SharedWidgets.readStatus(model.message.readStatus ?? ""),
                                  ],
                                ),

                                SizedBox(height: 20,),

                                SharedUi.mediumText(model.message.message ?? "", maxLine: 200, letterSpacing: 1, wordSpacing: 3, height: 2, colorType: ColorType.dark),
                                SizedBox(height: 40,)
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                )
            )
        )
    );
  }
}
