import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokemon.dart';
import 'package:pokedexapp/models/pokemon_details_screen.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PokedexScreen(),
    );
  }
}

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  List<Pokemon> pokemons = [];
  Pokemon? selectedPokemon;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  Future<void> getPokemon() async {
    setState(() {
      isLoading = true;
    });
    final response = await Dio().get('https://pokeapi.co/api/v2/pokemon?limit=150');
    setState(() {
      pokemons = response.data["results"].map<Pokemon>((result) {
        int id = int.parse(result["url"].split("/").reversed.elementAt(1));
        return Pokemon(name: _capitalize(result['name']), id: id, url: result["url"]);
      }).toList();
      isLoading = false;
    });
  }

  Future<void> fetchPokemonDetails(Pokemon pokemon) async {
    if (pokemon.sprites == null) {
      Pokemon? fullData = await Pokemon.getPokemon(pokemon.id!);
      if (fullData != null) {
        setState(() {
          int index = pokemons.indexWhere((p) => p.id == pokemon.id);
          if (index != -1) {
            pokemons[index] = fullData;
          }
          selectedPokemon = fullData;
        });
      }
    } else {
      setState(() {
        selectedPokemon = pokemon;
      });
    }
  }

  String _capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
  }

  void navigateToDetails() {
    if (selectedPokemon != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetailsScreen(pokemon: selectedPokemon!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokédex de Kanto"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.black,
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: selectedPokemon == null
                  ? const Center(child: Text("Seleccione un Pokémon"))
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selectedPokemon!.sprites?.front_default != null)
                    GestureDetector(
                      onTap: navigateToDetails,
                      child: Image.network(
                        selectedPokemon!.sprites!.front_default!,
                        width: 150, // Tamaño ajustado
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("ID: ${selectedPokemon!.id}"),
                        Text("Nombre: ${selectedPokemon!.name}"),
                        Text("Tipos: ${selectedPokemon!.types?.map((t) => t.name).join(', ') ?? 'N/A'}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                bool isSelected = selectedPokemon?.id == pokemon.id;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        setState(() {
                          selectedPokemon = null;
                        });
                      } else {
                        fetchPokemonDetails(pokemon);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFADD8E6),
                        borderRadius: BorderRadius.circular(10),
                        border: isSelected ? Border.all(color: Colors.red, width: 2) : null,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text("${pokemon.id}. ${pokemon.name}"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

