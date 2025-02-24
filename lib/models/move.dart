import 'package:pokedexapp/models/version_group_details.dart';

class Move {
  String? name;
  String? url;

  List<VersionGroupDetails>? versiongroupdetails = [];


  Move({
    this.name,
    this.url,
    this.versiongroupdetails,});

  factory Move.fromMap(Map<String, dynamic> map) {
    return Move(
      name: map["name"],
      url: map["url"],
      versiongroupdetails: (["versiongroupdetails"] as List).map((a) => VersionGroupDetails.fromMap(a["version_group_details"])).toList(),
    );
  }
}


