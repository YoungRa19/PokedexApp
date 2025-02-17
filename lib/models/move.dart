class Move {
  String? name;
  String? url;

  List<VersionGroupDetails>? versiongroupdetails = [];

  Move({
    this.name,
    this.versiongroupdetails,
    this.url,});

  factory Move.fromMap(Map<String, dynamic> map) {
    return Move(
      name: map["name"],
      versiongroupdetails: (["versiongroupdetails"] as List).map((a) => VersionGroupDetails.fromMap(a["version_group_details"])).toList(),
      url: map["url"],
    );
  }
}

class VersionGroupDetails {
  int? level_learned_at;

  List<MoveLearnMethod>? movelearnmethod = [];
  List<VersionGroup>? versiongroup = [];

  VersionGroupDetails({
    this.level_learned_at,
    this.versiongroup,
    this.movelearnmethod,});

  factory VersionGroupDetails.fromMap(Map<String, dynamic> map) {
    return VersionGroupDetails(
      level_learned_at: map["level_learned_at"],
      versiongroup: (["versiongroup"] as List).map((a) => VersionGroup.fromMap(a["version_group"])).toList(),
      movelearnmethod: (["movelearnmethod"] as List).map((a) => MoveLearnMethod.fromMap(a["move_learn_method"])).toList(),
    );
  }
}

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