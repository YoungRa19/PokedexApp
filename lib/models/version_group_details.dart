//Estos datos pertenecen a move


class VersionGroupDetails {
  int? level_learned_at;

  VersionGroupDetails({
    this.level_learned_at});

  factory VersionGroupDetails.fromMap(Map<String, dynamic> map) {
    return VersionGroupDetails(
      level_learned_at: map["level_learned_at"],);
  }
}