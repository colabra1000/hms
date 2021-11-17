class Message{

  int? id;
  int? organisationId;
  String? organisationName;
  int? readStatus;
  String? subject;
  String? message;
  String? time;

  Message.fromJson(Map json){
    id = json['id'];
    organisationId = json['organisationId'];
    organisationName = json['organisationName'];
    readStatus = json['readStatus'];
    subject = json['subject'];
    message = json['message'];
    time = json['time'];
  }

  Message();

  List<Message> toList(List jsonData){
    return jsonData.map((e) => Message.fromJson(e)).toList();
  }

}