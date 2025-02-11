class Ability {
  int? ability;
  String? name;
  int? slot;
  bool? is_hidden;
  String? url;

  Ability({
    this.ability,
    this.name,
    this.slot,
    this.is_hidden,
    this.url,});

  factory Ability.fromMap(Map<String, dynamic> map) {
    return Ability(
      name: map["name"],
      slot: map["slot"],
      is_hidden: map["is_hidden"],
      url: map["url"],
    );
  }
}