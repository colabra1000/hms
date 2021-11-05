import 'package:hms/models/LoginRequest.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/variables/GlobalData.dart';

class MockApiFetcher implements ApiFetcherInterface{

  @override
  Future<bool> login({required LoginRequest loginRequest, required Function(dynamic) onError, required Function(dynamic) onSuccess}) async {

    await Future.delayed(Duration(seconds: 2));

    await onSuccess(GlobalData.user);
    return true;

  }


  @override
  Future<bool> fetchDoctors({required Function(dynamic) onError, required Function(dynamic) onSuccess}) async {

    // await Future.delayed(Duration(seconds: 3));
    await onSuccess(GlobalData.doctors);
    // await onError("e");
    return true;

  }


}