import 'package:pokedexapp/models/version_details.dart';

class HeldItems {
  String? name;
  String? url;

  List<VersionDetails>? versiondetails = [];


  HeldItems({
    this.name,
    this.url,
    this.versiondetails});

  factory HeldItems.fromMap(Map<String, dynamic> map) {
    return HeldItems(
      name: map["name"],
      url: map["url"],
      versiondetails: (["versiondetails"] as List).map((a) => VersionDetails.fromMap(a["version_details"])).toList(),

    );
  }
}
