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
  String? url;
  String? location_area_encounters;
  int? height;
  int? weight;


  List<Ability>? abilities = [];
  Sprite? sprites;
  List<Forms>? forms = [];
  Species? species;
  List<Stat>? stats = [];
  List<Type>? types = [];
  List<Move>? moves = [];
  List<HeldItems>? helditems = [];
  List<GameIndices>? gameindices = [];


  Pokemon(
      {this.id,
        this.name,
        this.order,
        this.is_default,
        this.url,
        this.location_area_encounters,
        this.height,
        this.weight,
        this.abilities,
        this.sprites,
        this.forms,
        this.species,
        this.stats,
        this.types,
        this.moves,
        this.helditems,
        this.gameindices,});

  static Future<Pokemon?> getPokemon(int id) async {
    try {
      final response = await Dio().get('https://pokeapi.co/api/v2/pokemon/$id');
      Map<String, dynamic> body = response.data;

      return Pokemon(
        id: body["id"],
        name: body["name"],
        order: body["order"],
        is_default: body["is_default"],
        url: body["url"],
        location_area_encounters: body["location_area_encounters"],
        height: body["height"],
        weight: body["weight"],
        abilities: (body["abilities"] as List?)?.map((a) => Ability.fromMap(a["ability"])).toList() ?? [],
        sprites: body["sprites"] != null ? Sprite.fromMap(body["sprites"]) : null,
        forms: (body["forms"] as List?)?.map((a) => Forms.fromMap(a)).toList() ?? [],
        species: body["species"] != null ? Species.fromMap(body["species"]) : null,
        stats: (body["stats"] as List?)?.map((a) => Stat.fromMap(a["stat"])).toList() ?? [],
        types: (body["types"] as List?)?.map((a) => Type.fromMap(a["type"])).toList() ?? [],
        moves: (body["moves"] as List?)?.map((a) => Move.fromMap(a["move"])).toList() ?? [],
        helditems: (body["helditems"] as List?)?.map((a) => HeldItems.fromMap(a["item"])).toList() ?? [],
        gameindices: (body["game_indices"] as List?)?.map((a) => GameIndices.fromMap(a)).toList() ?? [],
      );
    } catch (e) {
      print("Error al obtener el Pokémon: $e");
      return null;
    }
  }
}
