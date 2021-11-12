class Message{

  int? id;
  String? title;
  String? body;
  String? time;


  Message.fromJson(Map json){
    id = json['id'];
    title = json['title'];
    body = json['body'];
    time = json['time'];

  }

  Message();

  List<Message> toList(List jsonData){
    return jsonData.map((e) => Message.fromJson(e)).toList();
  }

}