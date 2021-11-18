import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/models/Notification.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/UserService.dart';

class NotificationService {

  static const int UNREAD_MESSAGES = 0;
  static const int APPOINTMENT_BOOKED = 1;
  static const int APPOINTMENT_CANCELLED = 2;

  static const int FILTER_NONE = 0;
  static const int FILTER_MESSAGE = 1;
  static const int FILTER_BOOKED_NOTIFICATIONS = 2;
  static const int FILTER_CANCELLED_NOTIFICATIONS = 3;

  int filter = FILTER_NONE;

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


  UserService userService = locator<UserService>();

  Notification? notification;

  List? get notifications => userService.user.notifications;

  sortNotifications(){
    notifications?.sort((a,b){
      try{
        return DateTime.parse(a.time).isAfter(DateTime.parse(b.time)) ? -1 : 1;
      }catch(e){
        return 1;
      }
    });
  }

  void _addNewNotification({required int? id, required int? type, required String? organisationName, required int? organisationId, required int? payLoadId, required String? time}){
    Notification notification = Notification();
    notification.typeId = type;
    notification.organisationName = organisationName;
    notification.organisationId = organisationId;
    notification.payloadId = payLoadId;
    notification.time = time;
    notification.id = id;
    notifications?.add(notification);

  }


  void updateNotifications(dynamic object) {

    if(object is Message){

      // if message has been read, then just remove it from notification.
      if(object.readStatus == MessageService.READ){
        notifications?.removeWhere((element) {
          return element.payloadId == object.id && element.typeId == UNREAD_MESSAGES;
        });
      }

      // if message is new, the add new notification.
      if(object.readStatus == MessageService.NEW){

        _addNewNotification(id: notifications?.length,
            type: UNREAD_MESSAGES,
            organisationName: object.organisationName,
            organisationId: object.organisationId,
            payLoadId: object.id,
            time: object.time);

      }
    }


    if(object is Appointment){

      // notification can go from booked to cancelled to removed.
      if(object.status == AppointmentService.REMOVED){
        notifications?.removeWhere((element) => element.payloadId == object.id &&
            (element.typeId == APPOINTMENT_CANCELLED || element.typeId == APPOINTMENT_BOOKED)
        );
      }



      // notification can only go to cancelled from booked.
      if(object.status == AppointmentService.CANCELLED){

        int index = notifications?.indexWhere((element) =>
          (element.typeId == APPOINTMENT_BOOKED && element.payloadId == object.id)) ?? -1;



        if(index != -1){
          (notifications?[index] as Notification?)?.typeId = APPOINTMENT_CANCELLED;
        }else{
          // not found in notification.
          // this happens when notification is still pending and is not in the notification list
          // add new notification.
          _addNewNotification(id: notifications?.length,
              type: APPOINTMENT_CANCELLED,
              organisationName: object.organisationName,
              organisationId: object.organisationId,
              payLoadId: object.id,
              time: object.timeDue);
        }

      }

      // just add a new notification when appointment is accepted.
      if(object.status == AppointmentService.ACCEPTED){
        Notification notification = Notification();
        notification.typeId = APPOINTMENT_BOOKED;
        notification.organisationName = object.organisationName;
        notification.organisationId = object.organisationId;
        notification.payloadId = object.id;
        notification.time = object.timeDue;
        notification.id = notifications?.length;
        notifications?.add(notification);
      }
    }
  }

}