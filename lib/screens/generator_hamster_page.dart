import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemHamster {
  final String raza;
  final String color;
  final String imagen;
  final String descripcion;

  ItemHamster( {
    required this.raza,
    required this.color,
    required this.imagen,
    required this.descripcion
  });

  factory ItemHamster.fromJson(Map<String, dynamic> json) {
    return ItemHamster(
      raza: json['raza'],
      color: json['color'],
      imagen: json['imagen'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'raza': raza,
      'color': color,
      'imagen': imagen,
      'descripcion': descripcion
    };
  }
} 
final List<Map<String, dynamic>> hamsterJson = [
  {
    "raza": "Sirio",
    "color": "Dorado",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/hamster_sirio.png"
  },
  {
    "raza": "Enano Ruso",
    "color": "Gris",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/hamster_ruso.png"
  },
  {
    "raza": "Roborovski",
    "color": "Blanco y marrón",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/hamster_roborovski.png"
  }
];

final List<ItemHamster> hamster = hamsterJson.map((json) => ItemHamster.fromJson(json)).toList();

class GeneratorHamsterPage extends StatefulWidget {

  @override
  State<GeneratorHamsterPage> createState() => _GeneratorHamsterPageState();
}

class _GeneratorHamsterPageState extends State<GeneratorHamsterPage> {

  int get indiceHamster => hamster.length;
  int recorrido = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppStateHamster>();
    var pair = appState.currentHamster;

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
                    appState.toggleFavoriteHamster();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (indiceHamster != recorrido){
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

  final ItemHamster pair;

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

class MyAppStateHamster extends ChangeNotifier {

  //var current = WordPair.random();
  MyAppStateHamster() {
    currentHamster = hamster[0];
  }
  late ItemHamster currentHamster;

  // ↓ Add this.
  void getTravel(int recorrido) {
    //current = WordPair.random();
    currentHamster = hamster[recorrido];

    notifyListeners();
  }

  var favorites = [];

  void toggleFavoriteHamster() {
    if (favorites.contains(currentHamster)) {
      favorites.remove(currentHamster);
    } else {
      favorites.add(currentHamster);
    }
    notifyListeners();
  }

}

class FavoritesPageHamster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appStateHamster = context.watch<MyAppStateHamster>();

    if (appStateHamster.favorites.isEmpty) {
      return Center(
        child: Text('No tienes favoritos.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Tiene(s) '
              '${appStateHamster.favorites.length} favorito(s):'),
        ),
        for (var pair in appStateHamster.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.raza),
          ),
      ],
    );
  }
}