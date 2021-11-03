 import 'package:flutter/cupertino.dart';

abstract class InputAssignmentModelInterface{

  Future navigateToNextPage(BuildContext context);

  Future<bool> makeRequest();

  void setInputFields();

  bool validateInputFields();

  void implementInputHooks();



}