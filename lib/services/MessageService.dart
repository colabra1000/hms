import 'package:hms/locator.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class MessageService {

  ApiFetcherInterface _api = locator<ApiFetcherInterface>();

  late Message message;
  List? _messages;

  List? get messages => _messages;


  _sortMessages(){
    _messages?.sort((a,b){
      return a.readStatus == "UNSEEN" ? -1 : 1;
    });

    _messages?.sort((a,b){
      return a.readStatus == "READ" ? 1 : 0;
    });
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
          _messages = Message().toList(result);
          _sortMessages();

        }, onError: (e)async{
      if(!model.mounted){
        return false;
      }
      await Future.delayed(Duration(seconds: 2));
      await _fetch(model);
    });
  }


}