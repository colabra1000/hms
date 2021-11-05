


import 'package:hms/enums.dart';
import 'package:hms/environment.dart';
import 'package:hms/logger.dart';
import 'package:hms/services/ChatAutomationService.dart';
import 'package:hms/services/DoctorService.dart';
import 'package:hms/services/ErrorService.dart';
import 'package:hms/services/NavigationService.dart';
import 'package:hms/services/ValidationService.dart';
import 'package:hms/services/api/ApiFetcher.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/services/api/MockApiFetcher.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/AppointmentAndChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/appointment/AppointmentModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/chat/ChatModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/landing/LandingPageModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/login/LoginDisplayModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/preference/AccessDoctorListDisplayModel.dart';
import 'package:hms/variables/LiveVariables.dart';
import 'package:hms/variables/TestVariables.dart';
import 'package:hms/variables/VariableGetterInterface.dart';
import 'package:get_it/get_it.dart';



GetIt locator = GetIt.instance;

void setupLocator() {

  Logger _log = getLogger("setUpLocator");

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ValidationService());
  locator.registerLazySingleton(() => ErrorService());
  locator.registerLazySingleton(() => DoctorService());
  locator.registerLazySingleton(() => ChatAutomationService());


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
  locator.registerFactory(() => AccessDoctorListDisplayModel());
  locator.registerFactory(() => AppointmentAndChatModel());
  locator.registerFactory(() => ChatModel());
  locator.registerFactory(() => AppointmentModel());

}