import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokemon.dart';

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
              _tabButton("Información", () => setState(() => selectedTab = "Información")),
              _tabButton("Formas", () => setState(() => selectedTab = "Formas")),
            ],
          ),
          Expanded(
            child: selectedTab == "Información" ? _buildInfoTab() : _buildFormsTab(),
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
        Expanded(
          child: Image.network(
            widget.pokemon.sprites!.front_default!,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),  // Agregado margen horizontal
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoText("ID: ${widget.pokemon.id}"),
                _buildInfoText("Nombre: ${widget.pokemon.name}"),
                _buildInfoText("Tipos: ${widget.pokemon.types?.map((t) => t.name).join(', ') ?? 'N/A'}"),
                _buildInfoText("Altura: ${(widget.pokemon.height! / 10).toStringAsFixed(1)} m"),
                _buildInfoText("Peso: ${(widget.pokemon.weight! / 10).toStringAsFixed(1)} kg"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }



  Widget _buildFormsTab() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Image.network(
              _getSprite(selectedForm, true) ??
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png",
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: _getSprite(selectedForm, false) == null
                ? const Text("No encontrado", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                : Image.network(
              _getSprite(selectedForm, false)!,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ["Macho", "Hembra", "Macho shiny", "Hembra shiny"].map((form) {
              bool isSelected = selectedForm == form;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedForm = form;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    form,
                    style: TextStyle(color: isSelected ? Colors.white : Colors.black),
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
        return isFront ? widget.pokemon.sprites?.front_default : widget.pokemon.sprites?.back_default;
      case "Hembra":
        return isFront ? widget.pokemon.sprites?.front_female : widget.pokemon.sprites?.back_female;
      case "Macho shiny":
        return isFront ? widget.pokemon.sprites?.front_shiny : widget.pokemon.sprites?.back_shiny;
      case "Hembra shiny":
        return isFront ? widget.pokemon.sprites?.front_shiny_female : widget.pokemon.sprites?.back_shiny_female;
      default:
        return null;
    }
  }
}
