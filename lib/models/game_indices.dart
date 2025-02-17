class GameIndices {
  String? name;
  int? game_index;
  String? url;

  GameIndices({
    this.name,
    this.game_index,
    this.url,});

  factory GameIndices.fromMap(Map<String, dynamic> map) {
    return GameIndices(
      name: map["name"],
      game_index: map["game_index"],
      url: map["url"],
    );
  }
}