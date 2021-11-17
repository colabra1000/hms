import 'package:c_input/src/CInputController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Organisation.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/OrganisationService.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class MessageListDisplayPopperModel extends BaseModel{


  MessageService _messageService = locator<MessageService>();

  List? get messages => _messageService.messages;

  CInputController searchInputController = CInputController();



  void onOpen() async{

    if(_messageService.messages == null){
      await _messageService.fetchMessages(this);
    }

    notifyListeners();

  }


  void navigateToMessagePage(BuildContext context, {required Message message}) {
    _messageService.message = message;
    navigationService.navigateToMessagePage(context).then((value) {
      _messageService.sortMessages();
      notifyListeners();
    });
  }

}


