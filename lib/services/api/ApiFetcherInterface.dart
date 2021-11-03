import 'package:hms/models/LoginRequest.dart';

abstract class ApiFetcherInterface{

  Future<bool> login({required LoginRequest loginRequest, required Function(dynamic) onError, required Function(dynamic) onSuccess});

}