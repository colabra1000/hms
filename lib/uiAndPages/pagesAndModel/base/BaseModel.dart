
import 'package:flutter/cupertino.dart';
import 'package:hms/locator.dart';
import 'package:hms/services/NavigationService.dart';

abstract class BaseModel extends ChangeNotifier {

  NavigationService _navigationService  = locator<NavigationService>();
  NavigationService get navigationService {
    // It is expected that when navigation Service is called
    // Navigation To another page happens.
    // Therefore mounted should be set to false.
    _mounted = false;
    return _navigationService.injectModel(this);
  }



  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }




  //is true when page is current scope and false otherwise.
  bool _mounted = true;
  bool get mounted => _mounted;



  notifyListeners1(){
    if(mounted == true){
      notifyListeners();
    }
  }





  void disMount() {
    print("dismount");
    _mounted = false;
  }


  void reMount(){
    print("remount");
    _mounted = true;
  }

}