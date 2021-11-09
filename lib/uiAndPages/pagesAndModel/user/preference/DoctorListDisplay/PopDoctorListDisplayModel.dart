import 'package:c_input/src/CInputController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Doctor.dart';
import 'package:hms/services/DoctorService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class PopDoctorListDisplayModel extends BaseModel{


  ApiFetcherInterface _api = locator<ApiFetcherInterface>();
  DoctorService _doctorService = locator<DoctorService>();

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }


  late List doctors;

  CInputController searchInputController = CInputController();


  void navigateToAppointmentAndChatPage(BuildContext context, {required Doctor doctor}) {
    _doctorService.doctor = doctor;
    navigationService.navigateToAppointmentAndChatPage(context);
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


