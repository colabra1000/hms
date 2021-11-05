import 'package:flutter/cupertino.dart';
import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/services/ChatAutomationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:c_input/src/CInputController.dart';



class ChatModel extends BaseModel{

  ChatAutomationService _chatAutomationService = locator<ChatAutomationService>();

  List<ChatMessage> chatMessages = [];
  int chatIndex = 0;

  CInputController messageInputController = CInputController();
  ScrollController scrollController = ScrollController();



  bool _validateChatMessage(){
    if(!(messageInputController.selectedValue is String) && messageInputController.selectedValue.trim() == ""){
      return false;
    }

    return true;
  }

  processChat({required BuildContext context}) async {

    if(!_validateChatMessage()){
      return;
    }

    ChatMessage chatMessage = ChatMessage();
    chatMessage.chatIndex = chatIndex ++;
    chatMessage.message = messageInputController.selectedValue;
    chatMessage.chatOwner = ChatOwner.me;
    chatMessage.time = DateTime.now().toString();
    chatMessages.add(chatMessage);
    messageInputController.setSelectedValue("");
    notifyListeners();
    scrollController.jumpTo(scrollController.position.maxScrollExtent);

    await _chatAutomationService.generateAutoMessage(chatMessages);
    if(mounted){
      notifyListeners();
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }


  }


}