import 'package:flutter/material.dart';
import 'package:c_ui/c_ui.dart';
import 'package:hms/locator.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationPanelView.dart';

class NotificationPanelModel extends BaseModel {

  late UserModel userModel;

  NotificationService _notificationService = locator<NotificationService>();

  List? get notifications => _notificationService.notifications;

  int? get totalNotification=> notifications?.length;

  int? get newMessages => notifications
      ?.where((element) => element.typeId == NotificationService.UNREAD_MESSAGES).length;

  int? get appointmentBooked => notifications
      ?.where((element) => element.typeId == NotificationService.APPOINTMENT_BOOKED).length;

  int? get appointmentCancelled => notifications
      ?.where((element) => element.typeId == NotificationService.APPOINTMENT_CANCELLED).length;

  void openNotificationListDisplayPopper(int filter) {

    _notificationService.filter = filter;

    userModel.openNotificationListDisplayPopper().then((value) {
      _notificationService.filter = NotificationService.FILTER_NONE;
      notifyListeners();
    });

  }

}