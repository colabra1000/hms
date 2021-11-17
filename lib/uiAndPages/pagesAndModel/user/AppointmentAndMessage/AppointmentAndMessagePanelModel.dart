
import 'package:hms/locator.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';

class AppointmentAndMessagePanelModel extends BaseModel{

  late UserModel userModel;

  MessageService _messageService = locator<MessageService>();



  List? get messages => _messageService.messages;



  fetchMessage() async {
    if(messages == null){
      await _messageService.fetchMessages(this);
    }
    totalUnreadMessage = (messageUnSee ?? 0) + (messageUnRead ?? 0);
    if(mounted) notifyListeners();

  }




  int? get messageUnRead{
      return messages
          ?.where((message) => message.readStatus == MessageService.UNREAD).length;
  }

  int? get messageUnSee {
    return messages
        ?.where((message) => message.readStatus == MessageService.UNSEEN).length;
  }

  int _totalUnreadMessage = 0;

  set totalUnreadMessage(int value) {
    _totalUnreadMessage = value;
    // notifyListeners();
  }

  int get totalUnReadMessage => _totalUnreadMessage;

  Future<void> openMessageListDisplayPopper() {
    return userModel.openMessageListDisplayPopper().then((value){
      _messageService.seeAllMessages();
      totalUnreadMessage = (messageUnSee ?? 0) + (messageUnRead ?? 0);
      notifyListeners();
    });
  }






}