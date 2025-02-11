import 'package:dio/dio.dart';
import 'package:pokedexapp/models/ability.dart';

class Pokemon {
  int? id;
  String? name;
  int? order;
  bool? is_default;
  String? location_area_encounters;

  List<Ability>? abilities = [];

  Pokemon(
      {this.id,
        this.name,
        this.order,
        this.is_default,
        this.location_area_encounters,
        this.abilities});

  static Future<Pokemon?> getPokemon(String name) async {
    try {
      final response = await Dio().get('https://pokeapi.co/api/v2/pokemon/$name');
      Map<String, dynamic> body = response.data;

      return Pokemon(
        id: body["id"],
        name: body["name"],
        order: body["order"],
        is_default: body["is_default"],
        location_area_encounters: body["location_area_encounters"],
        abilities: (body["abilities"] as List)
            .map((a) => Ability.fromMap(a["ability"]))
            .toList(),
      );
    } catch (e) {
      print("Error al obtener el Pokémon: $e");
      return null; // Retorna null si hay error
    }
  }
}
