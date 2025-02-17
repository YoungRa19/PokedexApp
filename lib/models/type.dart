class Type {
  String? name;
  String? url;

  Type({
    this.name,
    this.url,});

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      name: map["name"],
      url: map["url"],
    );
  }
}