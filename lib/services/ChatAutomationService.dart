import 'package:hms/enums.dart';
import 'package:hms/models/ChatMessage.dart';
import 'package:hms/uiAndPages/documents/AutomatedChatDocument.dart';

class ChatAutomationService{

  bool writing = false;

  Future generateAutoMessage(List chatMessages) async {
    if(writing) return;
      writing = true;
      print("writing");

      await Future.delayed(Duration(seconds: 7));
      ChatMessage chatMessage = ChatMessage();
      chatMessage.message = AutomatedChatDocument.automatedMessage;
      chatMessage.time = DateTime.now().toString();
      chatMessage.chatOwner = ChatOwner.doctor;
      chatMessages.add(chatMessage);
      writing = false;
      print("submited");
  }


}