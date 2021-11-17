
import 'package:c_input/src/CInputController.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hms/enums.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/Notification.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/NavigationService.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:date_format/date_format.dart';

class NotificationListDisplayPopperModel extends BaseModel{


  NotificationService _notificationService = locator<NotificationService>();
  MessageService _messageService = locator<MessageService>();
  AppointmentService _appointmentService = locator<AppointmentService>();
  NavigationService _navigationService = locator<NavigationService>();



  List? get notifications => _notificationService.notifications;

  CInputController searchInputController = CInputController();

  void onOpen() async{

    if(_notificationService.notifications == null){
      await _notificationService.fetchNotifications(this);
    }
    notifyListeners();

  }

  interpretType(int? type) {

    switch (type){
      case NotificationService.UNREAD_MESSAGES :
        return "New message";
      case NotificationService.APPOINTMENT_BOOKED :
        return "Appointment booked";
      case NotificationService.APPOINTMENT_CANCELLED :
        return "Appointment cancelled";

    }
  }



  String getLongAppointmentDateDescription(String? date) {
    if(date == null) return "";
    try{
      return formatDate(DateTime.parse(date) , ['on ', DD," ",d,"'th of ", MM, ", ", yyyy,]);

    }catch(e){
      return "";
    }

  }


  String explainNotification(Notification notification,) {
    switch (notification.typeId){
      case NotificationService.UNREAD_MESSAGES :
        return "${notification.organisationName ?? ""} sent you a new Message 2 minutes ago";
      case NotificationService.APPOINTMENT_BOOKED :
        return "Your appointment has been successfully booked with ${notification.organisationName ?? ""}";
      case NotificationService.APPOINTMENT_CANCELLED :
        return "Your appointment with ${notification.organisationName ?? ""} was cancelled";
      default:
        return "";

    }
  }


  Future<void> _navigateToNotificationObject(BuildContext context, Notification notification) async {
    if(notification.typeId == NotificationService.UNREAD_MESSAGES){
      _messageService.messageId = notification.payloadId;
      _notificationService.notification = notification;
      await _navigationService.navigateToMessagePage(context).then((value) => notifyListeners());
    }

    if(notification.typeId == NotificationService.APPOINTMENT_BOOKED ||
        notification.typeId == NotificationService.APPOINTMENT_CANCELLED
    ){
      _appointmentService.appointmentId = notification.payloadId;
      _notificationService.notification = notification;
      await _navigationService.navigateToViewAppointment(context).then((value) => notifyListeners());
    }
  }

    Future<void> navigateToNotificationObject(BuildContext context, Notification notification) async {

      await _navigateToNotificationObject(context, notification);
      _notificationService.filterNotifications(_notificationService.object);
      notifyListeners();

    }

}


