class Specialization{

  int? id;
  String? name;

  Specialization.fromJson(Map json){
    id = json['id'];
    name = json['firstName'];
  }

  Specialization();

  List<Specialization> toList(List jsonData){
    return jsonData.map((e) => Specialization.fromJson(e)).toList();
  }

}