import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokemon.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Pokemon> pokemons = [];
  TextEditingController _nameController = TextEditingController();

  void _showAddPokemonDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Agregar Pokémon"),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Ingrese el nombre"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _nameController.clear(); // Limpia el campo al cancelar
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text.trim().toLowerCase();
                if (name.isEmpty) return;

                Pokemon? pokemon = await Pokemon.getPokemon(name);
                if (pokemon == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Pokémon no encontrado")),
                  );
                } else {
                  setState(() {
                    pokemons.add(pokemon);
                  });
                  _nameController.clear(); // Limpia el campo después de agregar
                  Navigator.pop(context);
                }
              },
              child: Text("Añadir"),
            ),
          ],
        );
      },
    );
  }

  void _showPokemonDetails(Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${pokemon.name}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ID: ${pokemon.id}"),
              Text("Habilidades: ${pokemon.abilities?.map((a) => a.name).join(", ") ?? "N/A"}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        backgroundColor: Color(0xFFFF0033),
        foregroundColor: Color(0xFF3D7DCA),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: _showAddPokemonDialog,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xFFF2F2F2),
        child: Column(
          children: [
            Expanded(
              child: pokemons.isEmpty
                  ? Center(child: Text("No se han ingresado pokémons"))
                  : ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemons[index];
                  return ListTile(
                    title: Text(pokemon.name ?? "Desconocido"),
                    trailing: IconButton(
                      icon: Icon(Icons.info, color: Colors.grey),
                      onPressed: () => _showPokemonDetails(pokemon),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
