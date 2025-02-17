class Forms {
  String? name;
  String? url;

  Forms({
    this.name,
    this.url,});

  factory Forms.fromMap(Map<String, dynamic> map) {
    return Forms(
      name: map["name"],
      url: map["url"],
    );
  }
}