import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokemon.dart';

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

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    List<Pokemon> tempList = [];
    for (int i = 1; i <= 151; i++) {
      Pokemon? p = await Pokemon.getPokemon(i);
      if (p != null) {
        tempList.add(p);
      }
    }
    setState(() {
      pokemons = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex de Kanto"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: selectedPokemon == null
                  ? const Center(child: Text("Seleccione un Pokémon"))
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selectedPokemon!.sprites?.front_default != null)
                    Image.network(selectedPokemon!.sprites!.front_default!),
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("ID: ${selectedPokemon!.id}"),
                        Text("Nombre: ${selectedPokemon!.name}"),
                        Text("Species: ${selectedPokemon!.species?.name ?? 'N/A'}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: pokemons.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                return Container(
                  decoration: BoxDecoration(
                    border: selectedPokemon?.id == pokemon.id
                        ? Border.all(color: Colors.red, width: 1.5)
                        : null,
                  ),
                  child: ListTile(
                    leading: pokemon.sprites?.front_default != null
                        ? Image.network(pokemon.sprites!.front_default!)
                        : const SizedBox(width: 50, height: 50),
                    title: Text("${pokemon.id}. ${pokemon.name}"),
                    onTap: () {
                      setState(() {
                        selectedPokemon = pokemon;
                      });
                    },
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
