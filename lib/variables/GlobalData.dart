library data;

import 'package:hms/models/Doctor.dart';
import 'package:hms/variables/DataHelper.dart';
part 'data/DoctorsData.dart';


class GlobalData{

  static List doctors = _doctorsData;

  static List gender = [
    "Male", "Female"
  ];


  static Map user = {
    "firstName" : "Aitem",
    "lastName" : "Quancy",
    "appointments" : [
      {
        "doctorId" : 0,
        "doctorName" : DataHelper.getDoctorName(0, doctors),
        "time" : "2021-01-06 20:56:14.592815",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "doctorId" : 1,
        "doctorName" : DataHelper.getDoctorName(1, doctors),
        "time" : "2021-12-05 20:56:14.592815",
        "accepted" : false,
        "message" : "lorem ipsum"
      },
      {
        "doctorId" : 0,
        "doctorName" : DataHelper.getDoctorName(0, doctors),
        "time" : "2021-07-20 23:56:14.592815",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "doctorId" : 2,
        "doctorName" : DataHelper.getDoctorName(2, doctors),
        "time" : "2021-01-07 12:23:14.592815",
        "accepted" : true,
        "message" : "lorem ipsum"
      },
      {
        "doctorId" : 0,
        "doctorName" : DataHelper.getDoctorName(0, doctors),
        "time" : "2021-06-07 12:24:14.592815",
        "accepted" : false,
        "message" : "lorem ipsum"
      }

    ],


  };


}