import 'package:dio/dio.dart';
import 'package:pokedexapp/models/ability.dart';
import 'package:pokedexapp/models/sprite.dart';
import 'package:pokedexapp/models/forms.dart';
import 'package:pokedexapp/models/spices.dart';
import 'package:pokedexapp/models/type.dart';
import 'package:pokedexapp/models/stat.dart';
import 'package:pokedexapp/models/game_indices.dart';
import 'package:pokedexapp/models/held_items.dart';
import 'package:pokedexapp/models/move.dart';

class Pokemon {
  int? id;
  String? name;
  int? order;
  bool? is_default;
  String? location_area_encounters;

  List<Ability>? abilities = [];
  List<Move>? moves = [];
  List<Sprite>? sprites = [];
  List<Type>? types = [];
  List<Forms>? forms = [];
  List<Spices>? spices = [];
  List<Stat>? stats = [];
  List<GameIndices>? gameindices = [];
  List<HeldItems>? helditems = [];


  Pokemon(
      {this.id,
        this.name,
        this.order,
        this.is_default,
        this.location_area_encounters,
        this.abilities,
        this.moves,
        this.sprites,
        this.types,
        this.forms,
        this.spices,
        this.stats,
        this.gameindices,
        this.helditems,});

  static Future<Pokemon?> getPokemon(int id) async {
    try {
      final response = await Dio().get('https://pokeapi.co/api/v2/pokemon/$id');
      Map<String, dynamic> body = response.data;

      return Pokemon(
        id: body["id"],
        name: body["name"],
        order: body["order"],
        is_default: body["is_default"],
        location_area_encounters: body["location_area_encounters"],
        abilities: (body["abilities"] as List).map((a) => Ability.fromMap(a["ability"])).toList(),
        moves: (body["moves"] as List).map((a) => Move.fromMap(a["move"])).toList(),
        sprites: (body["sprites"] as List).map((a) => Sprite.fromMap(a["sprites"])).toList(),
        types: (body["types"] as List).map((a) => Type.fromMap(a["type"])).toList(),
        forms: (body["forms"] as List).map((a) => Forms.fromMap(a["forms"])).toList(),
        spices: (body["spices"] as List).map((a) => Spices.fromMap(a["spices"])).toList(),
        stats: (body["stats"] as List).map((a) => Stat.fromMap(a["stat"])).toList(),
        gameindices: (body["gameindices"] as List).map((a) => GameIndices.fromMap(a["gameindices"])).toList(),
        helditems: (body["helditems"] as List).map((a) => HeldItems.fromMap(a["helditems"])).toList(),

      );
    } catch (e) {
      print("Error al obtener el Pokémon: $e");
      return null; // Retorna null si hay error
    }
  }
}
