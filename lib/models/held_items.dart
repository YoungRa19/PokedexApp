class HeldItems {
  String? name;
  String? url;

  HeldItems({
    this.name,
    this.url,});

  factory HeldItems.fromMap(Map<String, dynamic> map) {
    return HeldItems(
      name: map["name"],
      url: map["url"],
    );
  }
}
