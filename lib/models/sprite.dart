class Sprite{
  String? back_default;
  String? back_female;
  String? back_shiny;
  String? back_shiny_female;
  String? front_default;
  String? front_female;
  String? front_shiny;
  String? front_shiny_female;

  Sprite({
    this.back_default,
    this.back_female,
    this.back_shiny,
    this.back_shiny_female,
    this.front_default,
    this.front_female,
    this.front_shiny,
    this.front_shiny_female,
  });

  factory Sprite.fromMap(Map<String, dynamic> map) {
    return Sprite(
      back_default: map["back_default"],
      back_female: map["back_female"],
      back_shiny: map["back_shiny"],
      back_shiny_female: map["back_shiny_female"],
      front_default: map["front_default"],
      front_female: map["front_female"],
      front_shiny: map["front_shiny"],
      front_shiny_female: map["front_shiny_female"],
    );
  }
}