class Appointment{

  int? id;
  int? userId;
  int? organisationId;
  String? organisationName;
  String? time;
  int? status;
  String? message;

  Appointment();

  Appointment.fromJson(Map json){
    id = json["id"];
    userId = json["userId"];
    organisationId = json["organisationId"];
    organisationName = json["organisationName"];
    time = json["time"];
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
      "time" : time,
      "status" : status,
      "message" : message,
    };

  }

}