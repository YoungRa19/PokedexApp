//Estos datos pertenecen a held_items

class VersionDetails {
  String? name;
  int? rarity;
  String? url;

  VersionDetails({
    this.name,
    this.rarity,
    this.url,});

  factory VersionDetails.fromMap(Map<String, dynamic> map) {
    return VersionDetails(
      name: map["name"],
      rarity: map["rarity"],
      url: map["url"],
    );
  }
}