import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokemon.dart';
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
                      child: Image.network(selectedPokemon!.sprites!.front_default!),
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

class PokemonDetailsScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailsScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  String selectedTab = "Información";
  String selectedForm = "Macho";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokédex de Kanto"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _tabButton("Información", () =>
                  setState(() => selectedTab = "Información")),
              _tabButton(
                  "Formas", () => setState(() => selectedTab = "Formas")),
            ],
          ),
          Expanded(
            child: selectedTab == "Información"
                ? _buildInfoTab()
                : _buildFormsTab(),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String title, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: selectedTab == title ? Colors.red : Colors.transparent,
        side: const BorderSide(color: Colors.black),
      ),
      child: Text(title, style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _buildInfoTab() {
    return Row(
      children: [
        Expanded(child: Image.network(widget.pokemon.sprites!.front_default!)),
        Expanded(
          child: Column(
            children: [
              Text("ID: ${widget.pokemon.id}"),
              Text("Nombre: ${widget.pokemon.name}"),
              Text("Tipos: ${widget.pokemon.types?.map((t) => t.name).join(
                  ', ') ?? 'N/A'}"),
              Text("Altura: ${(widget.pokemon.height! / 10).toStringAsFixed(
                  1)} m"),
              Text("Peso: ${(widget.pokemon.weight! / 10).toStringAsFixed(
                  1)} kg"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormsTab() {
    return Row(
      children: [
        // Sección izquierda: Sprite frontal (o Ditto si no encontrado)
        Expanded(
          child: Center(
            child: Image.network(
              _getSprite(selectedForm, true) ??
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
              width: 150,
              height: 150,
            ),
          ),
        ),

        // Sección central: Texto "No encontrado" si el sprite no existe
        Expanded(
          child: Center(
            child: _getSprite(selectedForm, false) == null
                ? const Text("No encontrado",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                : Image.network(
              _getSprite(selectedForm, false)!,
              width: 150,
              height: 150,
            ),
          ),
        ),

        // Sección derecha: Botones de selección
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ["Macho", "Hembra", "Macho shiny", "Hembra shiny"].map((
                form) {
              bool isSelected = selectedForm == form;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedForm = form;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    form,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String? _getSprite(String form, bool isFront) {
    if (widget.pokemon.sprites == null) return null;

    switch (form) {
      case "Macho":
        return isFront
            ? widget.pokemon.sprites?.front_default
            : widget.pokemon.sprites?.back_default;
      case "Hembra":
        return isFront
            ? widget.pokemon.sprites?.front_female
            : widget.pokemon.sprites?.back_female;
      case "Macho shiny":
        return isFront
            ? widget.pokemon.sprites?.front_shiny
            : widget.pokemon.sprites?.back_shiny;
      case "Hembra shiny":
        return isFront
            ? widget.pokemon.sprites?.front_shiny_female
            : widget.pokemon.sprites?.back_shiny_female;
      default:
        return null;
    }
  }

}
