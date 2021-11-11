
import 'package:hms/locator.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class AppointmentAndMessagePanelModel extends BaseModel{

  MessageService _messageService = locator<MessageService>();



  List? get messages {
    if(_messageService.messages == null){

      _messageService.fetchMessages(this).then((value){

        if(mounted) notifyListeners();
      });

    }

    return _messageService.messages;
  }




  String get unReadMessage{
      String qty = messages?.where((message) => message.readStatus == "UNREAD").length.toString() ?? "..";
      if(qty.toString().length > 2)
        return "∞";
      else return qty;
  }

  String get unSeenMessage {


    String qty = messages?.where((message) {
      return message.readStatus == "UNSEEN";
    }).length.toString() ?? "..";

    if(qty.toString().length > 2)

      return "∞";

    else return qty;

  }






}