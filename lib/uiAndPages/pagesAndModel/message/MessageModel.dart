import 'package:flutter/cupertino.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';


class MessageModel extends BaseModel {

  // service locators.
  MessageService _messageService = locator<MessageService>();
  NotificationService _notificationService = locator<NotificationService>();

  // service getters.
  Message? get message => _messageService.message;
  int? get _messageId => _messageService.messageId;

  readMessage(){
    message!.readStatus = MessageService.READ;
  }


  fetchSingleMessage() async {

    if(message == null && _messageId != null){
      await _messageService.fetchSingleMessage(_messageService.messageId!, this);
    }
    if(mounted){
      readMessage();
      notifyListeners();
    }

  }


  void navigateBack(BuildContext context) {
    // _notificationService.object = message;
    _notificationService.updateNotifications(message);
    _messageService.message = null;
    Navigator.of(context).pop();
  }

}