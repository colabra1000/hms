import 'package:hms/models/LoginRequest.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';

class MockApiFetcher implements ApiFetcherInterface{

  @override
  Future<bool> login({required LoginRequest loginRequest, required Function(dynamic) onError, required Function(dynamic) onSuccess}) async {

    await Future.delayed(Duration(seconds: 2));
    await onSuccess(null);
    return true;

  }


}