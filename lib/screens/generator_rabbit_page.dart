import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemRabbit {
  final String raza;
  final String color;
  final String imagen;
  final String descripcion;

  ItemRabbit( {
    required this.raza,
    required this.color,
    required this.imagen,
    required this.descripcion
  });

  factory ItemRabbit.fromJson(Map<String, dynamic> json) {
    return ItemRabbit(
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

final List<Map<String, dynamic>> rabbitsJson = [
  {
    "raza": "Enano Holandés",
    "color": "Blanco y negro",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/enano_holandes.png"
  },
  {
    "raza": "Cabeza de León",
    "color": "Gris",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/cabeza_de_leon.png"
  },
  {
    "raza": "Rex",
    "color": "Marrón",
    "descripcion": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate.",
    "imagen": "assets/images/rex.png"
  }
];

final List<ItemRabbit> rabbits = rabbitsJson.map((json) => ItemRabbit.fromJson(json)).toList();

class GeneratorRabbitPage extends StatefulWidget {

  @override
  State<GeneratorRabbitPage> createState() => _GeneratorRabbitPageState();
}

class _GeneratorRabbitPageState extends State<GeneratorRabbitPage> {

  int get indiceRabbits => rabbits.length;
  int recorrido = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppStateRabbit>();
    var pair = appState.currentRabbit;

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
                    appState.toggleFavoriteRabbit();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (indiceRabbits != recorrido){
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

  final ItemRabbit pair;

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

class MyAppStateRabbit extends ChangeNotifier {

  //var current = WordPair.random();
  MyAppStateRabbit() {
    currentRabbit = rabbits[0];
  }

  late ItemRabbit currentRabbit;

  // ↓ Add this.
  void getTravel(int recorrido) {
    //current = WordPair.random();
    currentRabbit = rabbits[recorrido];

    notifyListeners();
  }

  var favorites = [];

  void toggleFavoriteRabbit() {
    if (favorites.contains(currentRabbit)) {
      favorites.remove(currentRabbit);
    } else {
      favorites.add(currentRabbit);
    }
    notifyListeners();
  }
}

class FavoritesPageRabbit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appStateRabbit = context.watch<MyAppStateRabbit>();

    if (appStateRabbit.favorites.isEmpty) {
      return Center(
        child: Text('No tienes favoritos.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Tiene(s) '
              '${appStateRabbit.favorites.length} favorito(s):'),
        ),
        for (var pair in appStateRabbit.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.raza),
          ),
      ],
    );
  }
}