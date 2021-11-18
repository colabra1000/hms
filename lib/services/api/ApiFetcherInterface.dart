import 'package:hms/models/LoginRequest.dart';

abstract class ApiFetcherInterface{

  int get userId;

  Future<bool> login({required LoginRequest loginRequest, required Function(dynamic) onError, required Function(dynamic) onSuccess});

  Future<bool> fetchOrganisations({required Function(dynamic) onError, required Function(dynamic) onSuccess});

  Future<bool> fetchMessages({required Function(dynamic) onError, required Function(dynamic) onSuccess});

  // Future<bool> fetchNotifications({required Function(dynamic) onError, required Function(dynamic) onSuccess});

  Future<bool> fetchSingleMessage({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess});

  Future<bool> fetchSingleAppointment({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess});

  Future<bool> removeAppointment({required int id, required Function(dynamic) onSuccess, required Function(dynamic) onError});

  Future<bool> saveAppointment({required Map payload, required Function(dynamic) onSuccess, required Function(dynamic) onError});

  Future<bool> cancelAppointment({required int id, required Function(dynamic) onSuccess, required Function(dynamic) onError});


}