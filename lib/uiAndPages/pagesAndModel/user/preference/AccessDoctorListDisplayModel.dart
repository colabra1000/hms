import 'package:c_input/src/CInputController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Doctor.dart';
import 'package:hms/services/api/ApiFetcher.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:hms/variables/GlobalData.dart';

class AccessDoctorListDisplayModel extends BaseModel{

  ApiFetcherInterface _api = locator<ApiFetcherInterface>();

  late Widget _pageListToDisplay;

  Widget get panelDisplay => _pageListToDisplay;

  set panelDisplay(Widget value) {
    _pageListToDisplay = value;
    notifyListeners();
  }

  late List doctors;

  CInputController searchInputController = CInputController();

  void navigateToDoctorsPage(BuildContext context, {required Doctor doctor}) {

  }

  //should not return error;
  //should keep trying to fetch until value is gotten.
  Future<bool> fetchDoctors() async {

    await _fetch();
    return true;
  }


  //recursively fetching indefinitely until doctors is returned
  _fetch(){

    return _api.fetchDoctors(
        onSuccess: (result){

          doctors = Doctor().toList(result);

        }, onError: (e)async{
        if(!this.mounted){
          return false;
        }
        await Future.delayed(Duration(seconds: 2));
        await _fetch();
    });
  }

}


