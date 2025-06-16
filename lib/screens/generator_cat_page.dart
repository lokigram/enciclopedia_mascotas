import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemGato {
  final String raza;
  final String tipo;
  final String imagen;
  final String descripcion;

  ItemGato( {
    required this.raza,
    required this.tipo,
    required this.imagen,
    required this.descripcion
  });

  factory ItemGato.fromJson(Map<String, dynamic> json) {
    return ItemGato(
      raza: json['raza'],
      tipo: json['tipo'],
      imagen: json['imagen'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'raza': raza,
      'tipo': tipo,
      'imagen': imagen,
      'descripcion': descripcion
    };
  }
} 

final List<Map<String, dynamic>> gatosJson = [
  {
    "raza": "Siames",
    "tipo": "Pelo corto",
    "imagen": "assets/images/siames.png",
    "descripcion": "Gato de origen tailandés, conocido por su inteligencia, curiosidad y voz distintiva. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate."
  },
  {
    "raza": "Persa",
    "tipo": "Pelo largo",
    "imagen": "assets/images/persa.png",
    "descripcion": "Gato de pelo largo y cara plana, requiere cuidados específicos de su pelaje. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate."
  },
  {
    "raza": "Maine Coon",
    "tipo": "paton unico",
    "imagen": "assets/images/maine_coon.png",
    "descripcion": "Gato grande y amistoso, conocido por su pelaje abundante y su naturaleza juguetona. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate."
  }
];

final List<ItemGato> gatos = gatosJson.map((json) => ItemGato.fromJson(json)).toList();

class GeneratorCatPage extends StatefulWidget {

  @override
  State<GeneratorCatPage> createState() => _GeneratorCatPageState();
}

class _GeneratorCatPageState extends State<GeneratorCatPage> {

  int get indiceGatos => gatos.length;
  int recorrido = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppStateCat>();
    var pair = appState.currentCat;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (recorrido > 0){
                      recorrido--;
                      appState.getTravel(recorrido);
                    }
                  },
                  child: Icon(Icons.navigate_before),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(pair.tipo),
                        content: SizedBox(
                          width: 200,
                          child: Text(pair.descripcion),
                        ),
                        actions: [                            
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.menu_outlined),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavoriteCat();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (indiceGatos != recorrido){
                      recorrido++;
                      appState.getTravel(recorrido);
                    }
                  },
                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ...
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final ItemGato pair;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(

      color: theme.colorScheme.onSecondary,
      fontSize: 32
    );

    return Card(
      elevation: 5.0,
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(pair.raza, style: style,),
            const SizedBox(height: 16),
            Image.asset(
              pair.imagen,              
              width: 200,
              height: 350,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      )
    );
  }
}

class MyAppStateCat extends ChangeNotifier {

  //var current = WordPair.random();
  MyAppStateCat() {
    currentCat = gatos[0];
  }
  late ItemGato currentCat;

  // ↓ Add this.
  void getTravel(int recorrido) {
    //current = WordPair.random();
    currentCat = gatos[recorrido];

    notifyListeners();
  }

  var favorites = [];

  void toggleFavoriteCat() {
    if (favorites.contains(currentCat)) {
      favorites.remove(currentCat);
    } else {
      favorites.add(currentCat);
    }
    notifyListeners();
  }
}

class FavoritesPageCat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appStateCat = context.watch<MyAppStateCat>();

    if (appStateCat.favorites.isEmpty) {
      return Center(
        child: Text('No tienes favoritos.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('tiene(s) '
              '${appStateCat.favorites.length} favorito(s):'),
        ),
        for (var pair in appStateCat.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.raza),
          ),
      ],
    );
  }
}