import 'package:hms/models/LoginRequest.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';

class ApiFetcher implements ApiFetcherInterface{
  @override
  Future<bool> login({required LoginRequest loginRequest, required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement login
    throw UnimplementedError();
  }


}