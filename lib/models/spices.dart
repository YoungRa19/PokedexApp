class Species {
  String? name;
  String? url;

  Species({
    this.name,
    this.url,});

  factory Species.fromMap(Map<String, dynamic> map) {
    return Species(
      name: map["name"],
      url: map["url"],
    );
  }
}