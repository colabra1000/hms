import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';
import 'package:c_input/c_input.dart';


class ChatPanel extends StatefulWidget{
  const ChatPanel({Key? key}) : super(key: key);

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> with AutomaticKeepAliveClientMixin<ChatPanel>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<ChatModel>(builder: (_, model){

      return Container(
          decoration: BoxDecoration(
              color: SharedUi.getColor(ColorType.divergent),
              borderRadius: BorderRadius.circular(20)
          ),

          child: Column(
              children: [
                Selector(

                  selector: (_, ChatModel model)=> model.chatMessages.length,

                  builder:(_, int value, __)=> Expanded(
                    child: ListView.builder(
                      controller: model.scrollController,
                      itemBuilder: (_, int i){

                        return _messageBox(chatMessage: model.chatMessages[i], context: context);

                      },

                      itemCount: model.chatMessages.length,


                    ),


                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: CTextField(model.messageInputController, minLines: 2,)),

                              SizedBox(width: 20,),

                              ButtonAnimator2(
                                  onTap: (){
                                    FocusScope.of(context).unfocus();
                                    model.processChat(context: context);
                                  },

                                  child:
                                  Container(
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        color: SharedUi.getColor(ColorType.success),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: SharedUi.getColor(ColorType.divergent))
                                    ),

                                    child: Icon(Icons.send, size: 25, color: SharedUi.getColor(ColorType.light),),


                                  )
                              )
                            ],
                          )),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),

              ]
          )
      );

    });
  }

  Widget _messageBox({required ChatMessage chatMessage, required BuildContext context}){

    BorderRadius borderRadius = BorderRadius.circular(10);

    return Row(

      mainAxisAlignment:
      chatMessage.chatOwner == ChatOwner.me ?
      MainAxisAlignment.end : MainAxisAlignment.start,

      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: PhysicalModel(
            elevation: 1,

            color: Colors.black,
            borderRadius: borderRadius,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: MediaQuery.of(context).size.height * .3,
              decoration: BoxDecoration(
                color: SharedUi.getColor(ColorType.light),
                borderRadius: borderRadius,
              ),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedUi.normalText(chatMessage.message!, size: 17, maxLine: 300, colorType: ColorType.dark)),

                  Align(
                    alignment: Alignment.centerRight,
                    child: SharedUi.smallText(
                        HelperService.formatTime(chatMessage.time!),
                        colorType: ColorType.secondary2
                    ),
                  )

                ],
              ),
            ),
          ),
        )
      ],

    );

  }

}
