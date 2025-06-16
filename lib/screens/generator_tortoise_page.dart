import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemTortoise {
  final String especie;
  final String color;
  final String imagen;
  final String descripcion;

  ItemTortoise( {
    required this.especie,
    required this.color,
    required this.imagen,
    required this.descripcion
  });

  factory ItemTortoise.fromJson(Map<String, dynamic> json) {
    return ItemTortoise(
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

final List<Map<String, dynamic>> tortoisesJson = [
  {
    "especie": "Tortuga de tierra",
    "color": "Verde y marrón",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/tortuga_tierra.png"
  },
  {
    "especie": "Tortuga rusa",
    "color": "Marrón claro",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/tortuga_rusa.png"
  },
  {
    "especie": "Tortuga de orejas rojas",
    "color": "Verde y rojo",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/tortuga_orejas_rojas.png"
  }
];

final List<ItemTortoise> tortoises = tortoisesJson.map((json) => ItemTortoise.fromJson(json)).toList();

class GeneratorTortoisePage extends StatefulWidget {

  @override
  State<GeneratorTortoisePage> createState() => _GeneratorTortoisePageState();
}

class _GeneratorTortoisePageState extends State<GeneratorTortoisePage> {

  int get indiceTortoises => tortoises.length;
  int recorrido = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppStateTortoise>();
    var pair = appState.currentTortoise;

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
                    appState.toggleFavoriteTortoises();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (indiceTortoises != recorrido){
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

  final ItemTortoise pair;

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

class MyAppStateTortoise extends ChangeNotifier {

  //var current = WordPair.random();
  MyAppStateTortoise() {
    currentTortoise = tortoises[0];
  }
  late ItemTortoise currentTortoise;

  // ↓ Add this.
  void getTravel(int recorrido) {
    //current = WordPair.random();
    currentTortoise = tortoises[recorrido];

    notifyListeners();
  }

  var favorites = [];

  void toggleFavoriteTortoises() {
    if (favorites.contains(currentTortoise)) {
      favorites.remove(currentTortoise);
    } else {
      favorites.add(currentTortoise);
    }
    notifyListeners();
  }
}

class FavoritesPageTortoise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appStateTotoise = context.watch<MyAppStateTortoise>();

    if (appStateTotoise.favorites.isEmpty) {
      return Center(
        child: Text('No tienes favoritos.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Tiene(s) '
              '${appStateTotoise.favorites.length} favorito(s):'),
        ),
        for (var pair in appStateTotoise.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.especie),
          ),
      ],
    );
  }
}