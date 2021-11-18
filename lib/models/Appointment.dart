class Appointment{

  int? id;
  int? userId;
  int? organisationId;
  String? organisationName;
  String? timeDue;
  String? timeBooked;
  int? status;
  String? message;

  Appointment();

  Appointment.fromJson(Map json){
    id = json["id"];
    userId = json["userId"];
    organisationId = json["organisationId"];
    organisationName = json["organisationName"];
    timeDue = json["timeDue"];
    timeBooked = json["timeBooked"];
    status = json["status"];
    message = json["message"];
  }


  List toList(List? jsonList){
    return jsonList?.map((e) => Appointment.fromJson(e)).toList() ?? [];
  }

  Map toJson() {

    return {
      "id" : id,
      "userId" : userId,
      "organisationId" : organisationId,
      "organisationName" : organisationName,
      "time" : timeDue,
      "status" : status,
      "message" : message,
    };

  }

}