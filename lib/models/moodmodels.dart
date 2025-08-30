



class MoodModels {
  final int?id;
  final String name;
  final String work;
  final String image;

  const MoodModels({
    required this.name,
    required this.work,
    required this.image,
    this.id
});

  MoodModels.fromJson(Map<String,dynamic>json):
      name = json["name"],
  work = json["work"],
  image = json["image"],
  id = json["id"];

  MoodModels.fromMap(Map<String,dynamic>map):
      name = map["name"],
  work=  map["work"],
  image = map["image"],
  id = map["id"];

  Map<String,dynamic>toMap(){
    return {
      "name":name,
      "image":image,
      "work":work,
      "id":id
    };
  }
}