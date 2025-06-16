import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemParrot {
  final String especie;
  final String color;
  final String imagen;
  final String descripcion;

  ItemParrot( {
    required this.especie,
    required this.color,
    required this.imagen,
    required this.descripcion
  });

  factory ItemParrot.fromJson(Map<String, dynamic> json) {
    return ItemParrot(
      especie: json['especie'],
      color: json['color'],
      imagen: json['imagen'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'especie': especie,
      'color': color,
      'imagen': imagen,
      'descripcion': descripcion
    };
  }
} 

final List<Map<String, dynamic>> parrotsJson = [
  {
    "especie": "Guacamayo",
    "color": "Azul y amarillo",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/guacamayo.png"
  },
  {
    "especie": "Cacatúa",
    "color": "Blanco y amarillo",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/cacatua.png"
  },
  {
    "especie": "Loro Amazónico",
    "color": "Verde",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/loro_amazonico.png"
  }
];

final List<ItemParrot> parrot = parrotsJson.map((json) => ItemParrot.fromJson(json)).toList();

class GeneratorParrotPage extends StatefulWidget {

  @override
  State<GeneratorParrotPage> createState() => _GeneratorParrotPageState();
}

class _GeneratorParrotPageState extends State<GeneratorParrotPage> {

  int get indiceParrots => parrot.length;
  int recorrido = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppStateParrot>();
    var pair = appState.currentParrot;

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
                        title: Text(pair.color),
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
                    appState.toggleFavoriteParrot();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (indiceParrots != recorrido){
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

  final ItemParrot pair;

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
            Text(pair.especie, style: style,),
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

class MyAppStateParrot extends ChangeNotifier {

  //var current = WordPair.random();
  MyAppStateParrot() {
    currentParrot = parrot[0];
  }
  late ItemParrot currentParrot;

  // ↓ Add this.
  void getTravel(int recorrido) {
    //current = WordPair.random();
    currentParrot = parrot[recorrido];

    notifyListeners();
  }

  var favorites = [];

  void toggleFavoriteParrot() {
    if (favorites.contains(currentParrot)) {
      favorites.remove(currentParrot);
    } else {
      favorites.add(currentParrot);
    }
    notifyListeners();
  }

}

class FavoritesPageParrot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appStateParrot = context.watch<MyAppStateParrot>();

    if (appStateParrot.favorites.isEmpty) {
      return Center(
        child: Text('No tienes favoritos.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Tiene(s) '
              '${appStateParrot.favorites.length} favorito(s):'),
        ),
        for (var pair in appStateParrot.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.especie),
          ),
      ],
    );
  }
}