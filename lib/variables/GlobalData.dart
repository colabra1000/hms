library data;

import 'package:hms/variables/DataHelper.dart';
part 'data/Organisations.dart';
part 'data/Messages.dart';
part 'data/Specialization.dart';


class GlobalData{

  static List specialization = _specialization;

  static List doctors = _organisations;

  static List readStatus = [
    {"id": 0, "value": "UNSEEN"},
    {"id": 1, "value": "READ"},
    {"id": 2, "value": "UNREAD"}
  ];

  static List gender = [
    "Male", "Female"
  ];

  static List messages = _messages;

  static Map user = {
    "firstName" : "Aitem",
    "lastName" : "Quancy",
    "appointments" : [
      {
        "organisationId" : 0,
        "organisationName" : DataHelper.getOrganisationName(0, doctors),
        "time" : "2021-20:56:14.592815",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "organisationId" : 1,
        "organisationName" : DataHelper.getOrganisationName(1, doctors),
        "time" : "2021-12-05 20:56:14.592815",
        "accepted" : false,
        "message" : "lorem ipsum"
      },
      {
        "organisationId" : 0,
        "organisationName" : DataHelper.getOrganisationName(0, doctors),
        "time" : "2021-07-20 23:56:14.592815",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "organisationId" : 2,
        "organisationName" : DataHelper.getOrganisationName(2, doctors),
        "time" : "2021-01-07 12:23:14.592815",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "organisationId" : 0,
        "organisationName" : DataHelper.getOrganisationName(0, doctors),
        "time" : "2021-06-07 12:24:14.592815",
        "accepted" : false,
        "message" : "lorem ipsum"
      }

    ],


  };


}