class Stat {
  String? name;
  int? base_stat;
  int? effort;
  String? url;

  Stat({
    this.name,
    this.base_stat,
    this.effort,
    this.url,});

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      name: map["name"],
      base_stat: map["base_stat"],
      effort: map["effort"],
      url: map["url"],
    );
  }
}