class HeldItems {
  String? name;
  String? url;

  List<VersionDetails>? versiondetails = [];

  HeldItems({
    this.name,
    this.versiondetails,
    this.url,});

  factory HeldItems.fromMap(Map<String, dynamic> map) {
    return HeldItems(
      name: map["name"],
      versiondetails: (["versiondetails"] as List).map((a) => VersionDetails.fromMap(a["version"])).toList(),
      url: map["url"],
    );
  }
}

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