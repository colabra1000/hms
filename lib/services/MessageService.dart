import 'package:hms/locator.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class MessageService {

  static const int UNSEEN = 0;
  static const int UNREAD = 1;
  static const int READ = 2;


  ApiFetcherInterface _api = locator<ApiFetcherInterface>();

  Message? message;
  List? _messages;

  int? messageId;

  List? get messages => _messages;

  set messages(List? value) {
    _messages = value;
  }

  seeAllMessages(){
    messages = messages?.map((e){
      if(e.readStatus == UNSEEN){
        e.readStatus = UNREAD;
      }
      return e;
    }).toList();
  }

  sortMessages(){
    List messages = List.from(this._messages ?? []);

    messages.sort((a,b){
      return a.readStatus == UNSEEN ? -1 : 1;
    });

    messages.sort((a,b){
      return a.readStatus == READ ? 1 : -1;
    });

    this.messages = messages;
  }

  // should not return error;
  // should keep trying to fetch until value is gotten.
  // once the calling baseModel is unmounted
  // should stop running irrespective.
  Future<bool> fetchMessages(BaseModel model) async {

    await _fetch(model);
    return true;
  }


  // recursively fetching indefinitely until doctors is returned
  _fetch(BaseModel model){

    return _api.fetchMessages(
        onSuccess: (result){
          messages = Message().toList(result);
          sortMessages();

        }, onError: (e)async{
      if(!model.mounted){
        return false;
      }
      await Future.delayed(Duration(seconds: 2));
      await _fetch(model);
    });
  }





  Future<bool> fetchSingleMessage(int id, BaseModel model) async {

    await _fetch2(id, model);
    return true;
  }


  // recursively fetching indefinitely until doctors is returned
  _fetch2(int id, BaseModel model){

    return _api.fetchSingleMessage(
        id: id,
        onSuccess: (result){
          message = Message.fromJson(result);
          // _sortMessages();

        }, onError: (e)async{
      if(!model.mounted){
        return false;
      }
      await Future.delayed(Duration(seconds: 2));
      await _fetch2(id, model);
    });
  }

}