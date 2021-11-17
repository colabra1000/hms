import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/models/Notification.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';

class NotificationService {

  static const int UNREAD_MESSAGES = 0;
  static const int APPOINTMENT_BOOKED = 1;
  static const int APPOINTMENT_CANCELLED = 2;




  static ColorType getNotificationColorType(int? type){
    switch (type){
      case NotificationService.UNREAD_MESSAGES :
        return ColorType.success;
      case NotificationService.APPOINTMENT_BOOKED :
        return ColorType.outlier;
      case NotificationService.APPOINTMENT_CANCELLED :
        return ColorType.danger;
      default :
        return ColorType.secondary;
    }

  }

  ApiFetcherInterface _api = locator<ApiFetcherInterface>();

  Notification? notification;

  List? _notifications;

  List? get notifications => _notifications;

  // the object notification points to.
  dynamic object;

  _sortNotifications(){
    _notifications?.sort((a,b){
      try{
        return DateTime.parse(a.time).isAfter(DateTime.parse(b.time)) ? -1 : 1;
      }catch(e){
        return 1;
      }
    });
  }


  // void removeNotification() {
  //      notifications?.remove(notification);
  // }

  // should not return error;
  // should keep trying to fetch until value is gotten.
  // once the calling baseModel is unmounted
  // should stop running irrespective.
  Future<bool> fetchNotifications(BaseModel model) async {

    await _fetch(model);
    return true;
  }


  // recursively fetching indefinitely until doctors is returned
  _fetch(BaseModel model){

    return _api.fetchNotifications(
        onSuccess: (result){
          _notifications = Notification().toList(result);
          _sortNotifications();

        }, onError: (e)async{
      if(!model.mounted){
        return false;
      }
      await Future.delayed(Duration(seconds: 2));
      await _fetch(model);
    });
  }

  void filterNotifications(dynamic object) {

    if(object is Message && object.readStatus == MessageService.READ){
      print(notifications?.length);
      notifications?.removeWhere((element) {
        return element.payloadId == object.id && element.typeId == UNREAD_MESSAGES;
      });
    }

    if(object is Appointment && object.status == AppointmentService.REMOVED){
      notifications?.removeWhere((element) => element.payloadId == object.id &&
          (element.typeId == APPOINTMENT_CANCELLED || element.typeId == APPOINTMENT_BOOKED)
      );
    }

  }




}