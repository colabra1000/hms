import 'package:hms/models/LoginRequest.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';

class ApiFetcher implements ApiFetcherInterface{

  @override
  // TODO: implement userId
  int get userId => throw UnimplementedError();

  @override
  Future<bool> login({required LoginRequest loginRequest, required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> fetchOrganisations({required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement fetchDoctors
    throw UnimplementedError();
  }


  @override
  Future<bool> fetchMessages({required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement fetchDoctors
    throw UnimplementedError();
  }

  // @override
  // Future<bool> fetchNotifications({required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
  //   throw UnimplementedError();
  // }

  @override
  Future<bool> fetchSingleMessage({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement fetchDoctors
    throw UnimplementedError();
  }

  @override
  Future<bool> fetchSingleAppointment({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement fetchDoctors
    throw UnimplementedError();
  }

  @override
  Future<bool> removeAppointment({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement fetchDoctors
    throw UnimplementedError();
  }


  @override
  Future<bool> saveAppointment({required Map payload, required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement fetchDoctors
    throw UnimplementedError();
  }


  @override
  Future<bool> cancelAppointment({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess}) {
    // TODO: implement fetchDoctors
    throw UnimplementedError();
  }








}