
import 'package:flutter/material.dart';
import 'package:hms/locator.dart';
import 'package:hms/models/User.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/services/UserService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:c_input/c_input.dart';


class UserInformationModel extends BaseModel {

  UserService _userService = locator<UserService>();

  User get user => _userService.user;

  List get countries =>
      [
        'Nigeria', 'Australia', 'Namibia',
        'Zamunda', 'Italy', 'Spain',
        'Napoli', 'Europa'
      ];

  List get genderList =>
      [
        "Male", "Female"
      ];

  List get bloodGroupList =>
      [
        "O+", "O-", "A+", "B+",
        "A-", "B-"
      ];

  List get genotypeList =>
      [
        "AA", "SS", "AS",
      ];

  static const String FULL_NAME = "full name";
  static const String COUNTRY = "country";
  static const String DOB = "date of birth";
  static const String EMAIL = "email";
  static const String GENDER = "gender";
  static const String BLOOD_GROUP = "blood group";
  static const String GENOTYPE = "genotype";

  late Map entityMap;
  late Map editFlag;

  initialize() {

    entityMap = {
      FULL_NAME: 0,
      COUNTRY: 1,
      DOB: 2,
      EMAIL: 3,
      GENDER: 4,
      BLOOD_GROUP: 5,
      GENOTYPE: 6,
    };

    editFlag = Map();

    entityMap.entries.forEach((element) {

      editFlag[element.key] = false;

      switch (element.key) {
        case FULL_NAME:

          firstNameInputController =
              CInputController(initialValue: user.firstName);
          lastNameInputController =
              CInputController(initialValue: user.lastName);

          defaultFirstName = firstName = firstNameInputController.selectedValue;
          defaultLastName = lastName = lastNameInputController.selectedValue;
          defaultFullName = fullName = "${firstNameInputController.selectedValue} ${lastNameInputController.selectedValue}";



          break;

        case COUNTRY:
          countryInputController = CInputController(initialValue: user.country);
          defaultCountry = country = countries[countryInputController.selectedValue];

          break;

        case DOB:
          dobInputController = CInputController(initialValue: user.dateOfBirth);
          defaultDateOfBirth = dateOfBirth = HelperService.formatToDate(dobInputController.selectedValue);

          break;

        case EMAIL:
          emailInputController = CInputController(initialValue: user.email);
          defaultEmail = email = emailInputController.selectedValue;

          break;

        case GENDER:
          genderInputController = CInputController(initialValue: user.gender);
          defaultGender = gender = genderList[genderInputController.selectedValue];

          break;

        case GENOTYPE:
          genotypeInputController = CInputController(initialValue: user.genotype);
          defaultGenotype = genotype = genotypeList[genotypeInputController.selectedValue];

          break;

        case BLOOD_GROUP:

          bloodGroupInputController = CInputController(initialValue: user.bloodGroup);
          defaultBloodGroup = bloodGroup = bloodGroupList[bloodGroupInputController.selectedValue];

          break;
      }
    });

  }


  doAction({required int id, required ActionType actionType}) {

    String name;
    entityMap.forEach((key, value) {
      if(value == id){
        name = key;
      };
    });

    name = entityMap.entries.firstWhere((element) => element.value == id).key;


    switch (name) {
      case FULL_NAME:
        if (actionType == ActionType.editField){

          editFlag[FULL_NAME] = !editFlag[FULL_NAME];

        }else if(actionType == ActionType.confirmSetField){

          _setFullName(newValueIsSet: true);

        }else if(actionType == ActionType.cancelSetField){

          _setFullName(newValueIsSet: false);

        }else if(actionType == ActionType.checkIfValueHasChanged){
          return fullName != defaultFullName;

        }else if(actionType == ActionType.revertChange){
          fullName = defaultFullName;
          firstName = defaultFirstName;
          lastName = defaultLastName;
          firstNameInputController.setSelectedValue(firstName);
          lastNameInputController.setSelectedValue(lastName);
        }


        break;

      case COUNTRY:
        if (actionType == ActionType.editField){

          editFlag[COUNTRY] = !editFlag[COUNTRY];

        }else if(actionType == ActionType.confirmSetField){

          _setCountryOfResident(newValueIsSet: true);

        }else if(actionType == ActionType.cancelSetField){

          _setCountryOfResident(newValueIsSet: false);

        }else if(actionType == ActionType.checkIfValueHasChanged){
          return country != defaultCountry;

        }else if(actionType == ActionType.revertChange){
          country = defaultCountry;
          countryInputController.setSelectedValue(country);
        }



        break;

      case DOB:
        if (actionType == ActionType.editField){

          editFlag[DOB] = !editFlag[DOB];

        }else if(actionType == ActionType.confirmSetField){

          _setDateOfBirth(newValueIsSet: true);

        }else if(actionType == ActionType.cancelSetField){

          _setDateOfBirth(newValueIsSet: false);

        }else if(actionType == ActionType.checkIfValueHasChanged){
          return dateOfBirth != defaultDateOfBirth;

        }else if(actionType == ActionType.revertChange){
          dateOfBirth = defaultDateOfBirth;
          dobInputController.setSelectedValue(dateOfBirth);
        }



        break;

      case EMAIL:
        if (actionType == ActionType.editField){

          editFlag[EMAIL] = !editFlag[EMAIL];

        }else if(actionType == ActionType.confirmSetField){

          _setEmail(newValueIsSet: true);

        }else if(actionType == ActionType.cancelSetField){

          _setEmail(newValueIsSet: false);

        }else if(actionType == ActionType.checkIfValueHasChanged){
          return email != defaultEmail;

        }else if(actionType == ActionType.revertChange){
          email = defaultEmail;
          emailInputController.setSelectedValue(email);
        }



        break;

      case GENDER:
        if (actionType == ActionType.editField){

          editFlag[GENDER] = !editFlag[GENDER];

        }else if(actionType == ActionType.confirmSetField){

          _setGender(newValueIsSet: true);

        }else if(actionType == ActionType.cancelSetField){

          _setGender(newValueIsSet: false);

        }else if(actionType == ActionType.checkIfValueHasChanged){
          return gender != defaultGender;

        }else if(actionType == ActionType.revertChange){
          gender = defaultGender;
          genderInputController.setSelectedValue(gender);
        }



        break;

      case GENOTYPE:
        if (actionType == ActionType.editField){

          editFlag[GENOTYPE] = !editFlag[GENOTYPE];

        }else if(actionType == ActionType.confirmSetField){

          _setGenotype(newValueIsSet: true);

        }else if(actionType == ActionType.cancelSetField){

          _setGenotype(newValueIsSet: false);

        }else if(actionType == ActionType.checkIfValueHasChanged){
          return genotype != defaultGenotype;

        }else if(actionType == ActionType.revertChange){
          genotype = defaultGenotype;
          genotypeInputController.setSelectedValue(genotype);
        }



        break;

      case BLOOD_GROUP:
        if (actionType == ActionType.editField){

          editFlag[BLOOD_GROUP] = !editFlag[BLOOD_GROUP];

        }else if(actionType == ActionType.confirmSetField){

          _setBloodGroup(newValueIsSet: true);

        }else if(actionType == ActionType.cancelSetField){

          _setBloodGroup(newValueIsSet: false);

        }else if(actionType == ActionType.checkIfValueHasChanged){
          return bloodGroup != defaultBloodGroup;

        }else if(actionType == ActionType.revertChange){
          bloodGroup = defaultBloodGroup;
          bloodGroupInputController.setSelectedValue(bloodGroup);

        }


        break;
    }

    actionType = ActionType.none;
    notifyListeners();

  }

  _setFullName({newValueIsSet: false}) {
    if (newValueIsSet == true) {
      firstName = firstNameInputController.selectedValue;
      lastName = lastNameInputController.selectedValue;
      fullName = "${firstName} ${lastName}";
    } else {
      firstNameInputController.setSelectedValue(firstName);
      lastNameInputController.setSelectedValue(lastName);
    }
  }

  _setCountryOfResident({newValueIsSet: false}) {
    if (newValueIsSet == true) {
      country = countryInputController.selectedValue;
    } else {
      countryInputController.setSelectedValue(country);
    }
  }

  _setDateOfBirth({newValueIsSet: false}) {
    if (newValueIsSet == true) {
      dateOfBirth = dobInputController.selectedValue;
    } else {
      dobInputController.setSelectedValue(dateOfBirth);
    }
  }

  _setEmail({newValueIsSet: false}) {
    if (newValueIsSet == true) {
      email = emailInputController.selectedValue;
    } else {
      emailInputController.setSelectedValue(email);
    }
  }

  _setGender({newValueIsSet: false}) {
    if (newValueIsSet == true) {
      gender = genderInputController.selectedValue;
    } else {
      genderInputController.setSelectedValue(gender);
    }
  }

  _setBloodGroup({newValueIsSet: false}) {
    if (newValueIsSet == true) {
      bloodGroup = bloodGroupInputController.selectedValue;
    } else {
      bloodGroupInputController.setSelectedValue(bloodGroup);
    }
  }

  _setGenotype({newValueIsSet: false}) {
    if (newValueIsSet == true) {
      genotype = genotypeInputController.selectedValue;
    } else {
      genotypeInputController.setSelectedValue(genotype);
    }
  }


  late String firstName, lastName, fullName,
      country, gender, dateOfBirth, email, bloodGroup, genotype;

  late String defaultFirstName, defaultLastName, defaultFullName,
      defaultCountry, defaultGender, defaultDateOfBirth, defaultEmail,
      defaultBloodGroup, defaultGenotype;

  late CInputController firstNameInputController, lastNameInputController,
      countryInputController, dobInputController, emailInputController,
      genderInputController, bloodGroupInputController, genotypeInputController;



  List<bool> editing = List.generate(8, (index) => false);


  bool get isLoading => false;


  editField(int i,) {
    editing[i] = !editing[i];
  }

  checkValueHasChanged({required int id}) {
    if (id == 0)
      return defaultFullName != fullName;
    if (id == 1)
      return defaultCountry != country;
    if (id == 2)
      return defaultDateOfBirth != defaultDateOfBirth;
    if (id == 3)
      return defaultEmail != email;
    if (id == 4)
      return defaultGender != gender;
    if (id == 5)
      return defaultBloodGroup != bloodGroup;
    if (id == 6)
      return defaultGenotype != genotype;
  }

  setField({required int id, bool newValueIsSet: false}) {
    if (id == 0)
      _setFullName(newValueIsSet: newValueIsSet);
    if (id == 1)
      _setCountryOfResident(newValueIsSet: newValueIsSet);
    if (id == 2)
      _setDateOfBirth(newValueIsSet: newValueIsSet);
    if (id == 3)
      _setEmail(newValueIsSet: newValueIsSet);
    if (id == 4)
      _setGender(newValueIsSet: newValueIsSet);
    if (id == 5)
      _setBloodGroup(newValueIsSet: newValueIsSet);
    if (id == 6)
      _setGenotype(newValueIsSet: newValueIsSet);
  }

  revertField({required int id}) {
    if (id == 0)
      fullName = defaultFullName;
    if (id == 1)
      country = defaultCountry;
    if (id == 2)
      dateOfBirth = defaultDateOfBirth;
    if (id == 3)
      email = defaultEmail;
    if (id == 4)
      gender = defaultGender;
    if (id == 5)
      bloodGroup = defaultBloodGroup;
    if (id == 6)
      genotype = defaultGenotype;

    notifyListeners();
  }

  navigateBack(BuildContext context){
    Navigator.of(context).pop();
  }


}



enum ActionType{
  editField,
  confirmSetField,
  cancelSetField,
  checkIfValueHasChanged,
  revertChange,
  none
}



