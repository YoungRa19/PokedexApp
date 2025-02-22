//Estos datos pertenecen a VersionGroupDetails

class MoveLearnMethod {
  String? name;
  String? url;

  MoveLearnMethod({
    this.name,
    this.url,});

  factory MoveLearnMethod.fromMap(Map<String, dynamic> map) {
    return MoveLearnMethod(
      name: map["name"],
      url: map["url"],
    );
  }
}
