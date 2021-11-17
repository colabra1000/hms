import 'package:hms/locator.dart';
import 'package:hms/models/Organisation.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class OrganisationService {


  ApiFetcherInterface _api = locator<ApiFetcherInterface>();

  late Organisation organisation;
  List? _organisations;

  List? get organisations => _organisations;

  set organisations(List? value) {
    _organisations = value;
  }

  // should not return error;
  // should keep trying to fetch until value is gotten.
  // once the calling baseModel is unmounted
  // should stop running irrespective.
  Future<bool> fetchOrganisations(BaseModel model) async {

    await _fetch(model);
    return true;
  }


  // recursively fetching indefinitely until doctors is returned
  _fetch(BaseModel model){

    return _api.fetchOrganisations(
        onSuccess: (result){
          organisations = Organisation().toList(result);
        }, onError: (e)async{
      if(!model.mounted){
        return false;
      }
      await Future.delayed(Duration(seconds: 2));
      await _fetch(model);
    });
  }

}