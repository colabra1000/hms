import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/AppointmentAndChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';
import 'package:c_input/c_input.dart';


class ChatPanel extends StatefulWidget{

  final void Function(ChatModel model,) exposeModel;


  const ChatPanel({Key? key, required this.exposeModel,}) : super(key: key);

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> with AutomaticKeepAliveClientMixin<ChatPanel>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<ChatModel>(

      onModelReady: (model){
        model.chatBox = _chatMessageBox(model);
        widget.exposeModel(model);
        model.displayChatMessageBox = true;
      },

      builder: (_, model){

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

                        if(i == model.chatMessages.length - 1)
                          return Column(
                            children: [
                              _messageBoardBox(chatMessage: model.chatMessages[i], context: context),
                              SizedBox(height: model.chatMessageBoxHeight,)
                            ],
                          );


                        return _messageBoardBox(chatMessage: model.chatMessages[i], context: context);

                      },

                      itemCount: model.chatMessages.length,


                    ),


                  ),
                ),

                // _chatBox(model),

                SizedBox(height: 20,)

              ]
          )
      );

    });
  }


  Widget _chatMessageBox(ChatModel model){
    return Container(
      decoration: BoxDecoration(
        color: SharedUi.getColor(ColorType.light),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 1,
            color: SharedUi.getColor(ColorType.secondary),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CTextField(

              model.messageInputController, radius: 30,

              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),

              fontSize: 20,

              minLines: 2,

              suffixIcon:  ButtonAnimator2(
                onTap: (){
                  FocusScope.of(context).unfocus();
                  model.processChat(context: context);
                },

                child: Icon(Icons.send, size: 35, color: SharedUi.getColor(ColorType.success),)
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }


  Widget _messageBoardBox({required ChatMessage chatMessage, required BuildContext context}){

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
              width: MediaQuery.of(context).size.width * .5,
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
