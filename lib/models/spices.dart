class Spices {
  String? name;
  String? url;

  Spices({
    this.name,
    this.url,});

  factory Spices.fromMap(Map<String, dynamic> map) {
    return Spices(
      name: map["name"],
      url: map["url"],
    );
  }
}