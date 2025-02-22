//Estos datos pertenecen a VersionGroupDetails

class VersionGroup {
  String? name;
  String? url;

  VersionGroup({
    this.name,
    this.url,});

  factory VersionGroup.fromMap(Map<String, dynamic> map) {
    return VersionGroup(
      name: map["name"],
      url: map["url"],
    );
  }
}