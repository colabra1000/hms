class Organisation{

  int? id;
  String? name;
  String? city;
  List? specialization = List.empty();

  Organisation.fromJson(Map json){
    id = json['id'];
    name = json['name'];
    city = json['city'];
    specialization = json['specialization'];
  }

  Organisation();

  List<Organisation> toList(List jsonData){
    return jsonData.map((e) => Organisation.fromJson(e)).toList();
  }

}