//Estos datos pertenecen a move
import 'package:pokedexapp/models/move_learn_method.dart';
import 'package:pokedexapp/models/version_group.dart';

class VersionGroupDetails {
  int? level_learned_at;
  List<MoveLearnMethod>? movelearnmethods = [];
  List<VersionGroup>? versiongroups = [];

  VersionGroupDetails({
    this.level_learned_at,
    this.movelearnmethods,
    this.versiongroups});

  factory VersionGroupDetails.fromMap(Map<String, dynamic> map) {
    return VersionGroupDetails(
      level_learned_at: map["level_learned_at"],
      movelearnmethods: (["movelearnmethods"] as List).map((a) => MoveLearnMethod.fromMap(a["move_learn_method"])).toList(),
      versiongroups: (["versiongroups"] as List).map((a) => VersionGroup.fromMap(a["version_group"])).toList(),);
  }
}