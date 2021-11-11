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


  ApiFetcherInterface _api = locator<ApiFetcherInterface>();
  MessageService _messageService = locator<MessageService>();

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }


  List get messages => _messageService.messages ?? [];

  CInputController searchInputController = CInputController();



  void onOpen() async{

    if(_messageService.messages == null)
      await _messageService.fetchMessages(this);

    if(mounted){
      loading = false;
    }
  }


  void navigateToMessagePage(BuildContext context, {required Message message}) {
    _messageService.message = message;
    navigationService.navigateToAppointmentAndChatPage(context);
  }






}


