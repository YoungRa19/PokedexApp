class Move {
  String? name;
  String? url;

  Move({
    this.name,
    this.url,});

  factory Move.fromMap(Map<String, dynamic> map) {
    return Move(
      name: map["name"],
      url: map["url"],
    );
  }
}


