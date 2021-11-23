import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/message/MessageModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/pageLayouts/pageLayout.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MessageModel>(

        onModelReady: (model) async {
          model.fetchSingleMessage();


        },

        builder: (_, model)
        => PageLayout.layout<MessageModel>(
          onBackPressed: ()=>model.navigateBack(context),
          isLoading: (model)=>model.message == null,
          title: "Message",
          titleIcon: Icon(CupertinoIcons.mail),

          body: Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal : 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: SharedUi?.getColor(ColorType.light),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Column(
                    children: [

                      Row(
                        children: [
                          SharedWidgets.profileBox(),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SharedUi.smallText(model.message!.organisationName ?? "", colorType: ColorType.info),
                                SharedUi.smallText(model.message!.subject ?? "", bold: true, maxLine: 2),

                              ],
                            ),
                          ),
                          // Spacer(),
                          SharedUi.smallText(HelperService.formatToDate(model.message!.time))

                          // SharedWidgets.indicateItemState(context, model.message!.readStatus),
                        ],
                      ),

                      SizedBox(height: 20,),

                      SharedUi.mediumText(model.message!.message ?? "", maxLine: 200, letterSpacing: 1, wordSpacing: 3, height: 2, colorType: ColorType.dark),
                      SizedBox(height: 40,)
                    ],
                  ),
                ),
              );
            }
          ),
        )
    );
  }


  Widget? safe(){
    // return   Selector(
    //
    //
    //     selector: (_, MessageModel model)=>model.message,
    //
    //     builder: (_, Message? value, __) {
    //
    //       return Expanded(
    //         child: AnimatedSwitcher(
    //           duration: Duration(milliseconds: 500),
    //           child: model.message == null ?
    //           _loadingIndicator():
    //           SingleChildScrollView(
    //             child: Container(
    //               padding: EdgeInsets.symmetric(horizontal : 20, vertical: 30),
    //               decoration: BoxDecoration(
    //                 color: SharedUi?.getColor(ColorType.light),
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               child:  Column(
    //                 children: [
    //
    //                   Row(
    //                     children: [
    //                       SharedWidgets.profileBox(),
    //                       SizedBox(width: 20,),
    //                       Expanded(
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             SharedUi.smallText(model.message!.organisationName ?? "", colorType: ColorType.info),
    //                             SharedUi.smallText(model.message!.subject ?? "", bold: true, maxLine: 2),
    //
    //                           ],
    //                         ),
    //                       ),
    //                       // Spacer(),
    //                       SharedUi.smallText(HelperService.timeFormat2(model.message!.time))
    //
    //                       // SharedWidgets.indicateItemState(context, model.message!.readStatus),
    //                     ],
    //                   ),
    //
    //                   SizedBox(height: 20,),
    //
    //                   SharedUi.mediumText(model.message!.message ?? "", maxLine: 200, letterSpacing: 1, wordSpacing: 3, height: 2, colorType: ColorType.dark),
    //                   SizedBox(height: 40,)
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //
    //
    //     }
    // ),
  }


}
