import 'package:hms/locator.dart';
import 'package:hms/models/LoginRequest.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/data/DataHelper.dart';
import 'package:hms/data/GlobalData.dart';

class MockApiFetcher implements ApiFetcherInterface{

  UserService _userService = locator<UserService>();

  @override
  int get userId => _userService.user.id!;

  @override
  Future<bool> login({required LoginRequest loginRequest, required Function(dynamic) onError, required Function(dynamic) onSuccess}) async {

    await Future.delayed(Duration(seconds: 2));

    await onSuccess(GlobalData.user);
    return true;

  }


  @override
  Future<bool> fetchOrganisations({required Function(dynamic) onError, required Function(dynamic) onSuccess}) async {

    await Future.delayed(Duration(seconds: 3));
    await onSuccess(GlobalData.organisations);
    // await onError("e");
    return true;

  }

  @override
  Future<bool> fetchMessages({required Function(dynamic) onError, required Function(dynamic) onSuccess}) async {

    await Future.delayed(Duration(seconds: 3));
    await onSuccess(GlobalData.messages);
    // await onError("e");
    return true;

  }


  // @override
  // Future<bool> fetchNotifications({required Function(dynamic) onError, required Function(dynamic) onSuccess}) async {
  //
  //   await Future.delayed(Duration(seconds: 3));
  //   await onSuccess(GlobalData.notifications);
  //   // await onError("e");
  //   return true;
  //
  // }

  @override
  Future<bool> fetchSingleMessage({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess}) async{

    await Future.delayed(Duration(seconds: 3));
    Map? message = GlobalData.messages.firstWhere((element) => element["id"] == id);
    await onSuccess(message);
    // await onError("e");
    return true;
  }



  @override
  Future<bool> fetchSingleAppointment({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess}) async{

    await Future.delayed(Duration(seconds: 3));
    Map? message = GlobalData.appointments.firstWhere((element) => element["id"] == id && element["userId"] == userId);
    await onSuccess(message);
    // await onError("e");
    return true;
  }

  @override
  Future<bool> removeAppointment({required int id, required Function(dynamic) onSuccess, required Function(dynamic) onError}) async {
    await Future.delayed(Duration(seconds: 3));
    GlobalData.appointments.removeWhere((element) => element["id"] == id);
    await onSuccess("200");

    return true;

  }

  @override
  Future<bool> saveAppointment({required Map payload, required Function(dynamic) onError, required Function(dynamic) onSuccess}) async{


    await Future.delayed(Duration(seconds: 3));

    int id = GlobalData.appointments.last["id"] ?? 0;
    id += 1;

    payload["id"] = id;
    payload["organisationName"] = DataHelper.getOrganisationName(payload["organisationId"], GlobalData.organisations);
    GlobalData.appointments.add(payload);
    onSuccess(payload);
    return true;

  }


  @override
  Future<bool> cancelAppointment({required int id, required Function(dynamic) onError, required Function(dynamic) onSuccess}) async{


    await Future.delayed(Duration(seconds: 3));
    // 2 means cancelled.
    GlobalData.appointments.firstWhere((element) => element["id"] == id)["status"] = 2;
    await onSuccess("200");

    return true;


  }



}