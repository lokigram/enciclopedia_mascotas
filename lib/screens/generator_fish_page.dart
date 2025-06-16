import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemFish {
  final String especie;
  final String color;
  final String imagen;
  final String descripcion;

  ItemFish( {
    required this.especie,
    required this.color,
    required this.imagen,
    required this.descripcion
  });

  factory ItemFish.fromJson(Map<String, dynamic> json) {
    return ItemFish(
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

final List<Map<String, dynamic>> fishesJson = [
  {
    "especie": "Betta",
    "color": "Rojo y azul",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/betta.png"
  },
  {
    "especie": "Goldfish",
    "color": "Naranja",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/goldfish.png"
  },
  {
    "especie": "Guppy",
    "color": "Multicolor",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/guppy.png"
  }
];

final List<ItemFish> fishs = fishesJson.map((json) => ItemFish.fromJson(json)).toList();

class GeneratorFishPage extends StatefulWidget {

  @override
  State<GeneratorFishPage> createState() => _GeneratorFishPageState();
}

class _GeneratorFishPageState extends State<GeneratorFishPage> {

  int get indiceFishs => fishs.length;
  int recorrido = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppStateFish>();
    var pair = appState.currentFish;

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
                    appState.toggleFavoriteFish();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (indiceFishs != recorrido){
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

  final ItemFish pair;

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

class MyAppStateFish extends ChangeNotifier {

  //var current = WordPair.random();
  MyAppStateFish() {
    currentFish = fishs[0];
  }
  late ItemFish currentFish;

  // ↓ Add this.
  void getTravel(int recorrido) {
    //current = WordPair.random();
    currentFish = fishs[recorrido];

    notifyListeners();
  }

  var favorites = [];

  void toggleFavoriteFish() {
    if (favorites.contains(currentFish)) {
      favorites.remove(currentFish);
    } else {
      favorites.add(currentFish);
    }
    notifyListeners();
  }
}

class FavoritesPageFish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appStateFish = context.watch<MyAppStateFish>();

    if (appStateFish.favorites.isEmpty) {
      return Center(
        child: Text('No tienes favoritos.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('tiene(s) '
              '${appStateFish.favorites.length} favorito(s):'),
        ),
        for (var pair in appStateFish.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.especie),
          ),
      ],
    );
  }
}