import 'package:c_input/c_input.dart';
import 'package:flutter/material.dart';
import 'package:c_modal/c_modal.dart';
import 'package:hms/locator.dart';
import 'package:hms/logger.dart';
import 'package:hms/models/LoginRequest.dart';
import 'package:hms/models/User.dart';
import 'package:hms/services/ErrorService.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/services/ValidationService.dart';
import 'package:hms/services/api/ApiFetcherInterface.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/master/InputAssignmentModelInterface.dart';

class LoginDisplayModel extends BaseModel implements InputAssignmentModelInterface{

  //logger
  final _log = getLogger("Login Page");
  
  //services
  ApiFetcherInterface _api = locator<ApiFetcherInterface>();
  ErrorService _errorService = locator<ErrorService>();
  UserService _userService = locator<UserService>();

  //service getters
  ValidationService _validationService = locator<ValidationService>();

  //controllers declaration.
  CModalController cModalController = CModalController();

  CInputController userNameInputController = CInputController();
  CInputController passwordInputController = CInputController();



  //payload
  late LoginRequest _loginRequest;

  bool _confirmValidation = true;

  bool get confirmValidation => _confirmValidation;

  late String loginErrorMessage;

  set confirmValidation(bool value) {
    _confirmValidation = value;
    notifyListeners();
  }


  void navigateToUserPage(BuildContext context) {
    // navigationService.navigateToLoginPage(context);
  }

  @override
  void implementInputHooks() {
    // TODO: implement implementInputHooks
  }

  @override
  Future<bool> makeRequest() {
    return _api.login(loginRequest: _loginRequest, onError: (e){

      loginErrorMessage = _errorService.getErrorMessageFrom("Error Logging in");

    }, onSuccess: (result){
      _userService.user = User.fromJson(result);
    });
  }


  @override
  void setInputFields() {
    _loginRequest = LoginRequest();
    _loginRequest.userName = userNameInputController.selectedValue;
    _loginRequest.password = passwordInputController.selectedValue;

  }

  @override
  bool validateInputFields() {
   
    return _validationService.validate([
      userNameInputController.validate(),
      passwordInputController.validate(),
    ]);
    
  }

  @override
  Future navigateToNextPage(BuildContext context) {
    return navigationService.navigateToUserPage(context);
  }


}