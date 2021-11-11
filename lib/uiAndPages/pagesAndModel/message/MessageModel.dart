import 'package:flutter/cupertino.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class MessageModel extends BaseModel {

  MessageService _messageService = locator<MessageService>();

  Message get message => _messageService.message;

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }






}