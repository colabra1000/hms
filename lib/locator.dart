


import 'package:hms/data/variables/VariableGetterInterface.dart';
import 'package:hms/enums.dart';
import 'package:hms/environment.dart';
import 'package:hms/logger.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/ChatAutomationService.dart';
import 'package:hms/services/NotificationService.dart';
import 'package:hms/services/OrganisationService.dart';
import 'package:hms/services/ErrorService.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/services/NavigationService.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/services/ValidationService.dart';
import 'package:hms/services/api/ApiFetcher.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/services/api/MockApiFetcher.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/AppointmentAndChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/appointment/AppointmentModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/appointmentAndChat/appointment/viewAppointment/ViewAppointmentModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/landing/LandingPageModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/login/LoginDisplayModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/message/MessageModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/AppointmentAndMessagePanelModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/MessageListDisplay/MessageListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/OrganisationListDisplay/OrganisationListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationListDisplay/NotificationListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/notification/NotificationPanelModel.dart';
import 'package:hms/data/variables/LiveVariables.dart';
import 'package:hms/data/variables/TestVariables.dart';
import 'package:get_it/get_it.dart';



GetIt locator = GetIt.instance;


void setupLocator() {

  Logger _log = getLogger("setUpLocator");

  //my new experimental feature

  // locator.registerLazySingleton(() => NK());

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ValidationService());
  locator.registerLazySingleton(() => ErrorService());
  locator.registerLazySingleton(() => OrganisationService());
  locator.registerLazySingleton(() => MessageService());
  locator.registerLazySingleton(() => ChatAutomationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => AppointmentService());


  locator.registerLazySingleton<ApiFetcherInterface>((){

    if (Environment.environmentType == EnvironmentType.live){
      _log.i("environment Type is live!");
      return ApiFetcher();
    }else {
      _log.i("environment Type is test!");
      return MockApiFetcher();
    }

  });



  locator.registerLazySingleton<VariableGetterInterface>((){
    if (Environment.environmentType == EnvironmentType.live){
      return LiveVariables();
    }else {
      return TestVariables();
    }
  });


  locator.registerFactory(() => LandingPageModel());
  locator.registerFactory(() => LoginDisplayModel());
  locator.registerFactory(() => UserModel());
  locator.registerFactory(() => OrganisationListDisplayPopperModel());
  locator.registerFactory(() => MessageListDisplayPopperModel());
  locator.registerFactory(() => AppointmentAndChatModel());
  locator.registerFactory(() => ChatModel());
  locator.registerFactory(() => AppointmentModel());
  locator.registerFactory(() => AppointmentAndMessagePanelModel());
  locator.registerFactory(() => MessageModel());
  locator.registerFactory(() => NotificationPanelModel());
  locator.registerFactory(() => NotificationListDisplayPopperModel());
  locator.registerFactory(() => ViewAppointmentModel());

}