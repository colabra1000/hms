import 'package:hms/models/LoginRequest.dart';

abstract class ApiFetcherInterface{

  Future<bool> login({required LoginRequest loginRequest, required Function(dynamic) onError, required Function(dynamic) onSuccess});

  Future<bool> fetchOrganisations({required Function(dynamic) onError, required Function(dynamic) onSuccess});

  Future<bool> fetchMessages({required Function(dynamic) onError, required Function(dynamic) onSuccess});


}