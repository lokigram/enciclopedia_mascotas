import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemPerro {
    final String raza;
    final String tipo;
    final String imagen;
    final String descripcion;

  ItemPerro({
    required this.raza,
    required this.tipo,
    required this.imagen,
    required this.descripcion
  });

  factory ItemPerro.fromJson(Map<String, dynamic> json) {
    return ItemPerro(
      raza: json['raza'],
      tipo: json['tipo'],
      imagen: json['imagen'],
      descripcion: json['descripcion']
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

final List<Map<String, dynamic>> perrosJson = [
  {
    "raza": "Labrador Retriever",
    "tipo": "populares",
    "imagen": "assets/images/labrador.png",
    "descripcion": "Conocido por su amabilidad y energía, ideal para familias. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate."
  },
  {
    "raza": "Bulldog Francés",
    "tipo": "populares",
    "imagen": "assets/images/bulldog_frances.png",
    "descripcion": "Compacto y con una personalidad encantadora, se adapta bien a espacios pequeños. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate."
  },
  {
    "raza": "Golden Retriever",
    "tipo": "populares",
    "imagen": "assets/images/golden.png",
    "descripcion": "Similar al Labrador, también muy afectuoso y juguetón. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate."
  },
  {
    "raza": "Chihuahua",
    "tipo": "pequeños",
    "imagen": "assets/images/chihuahua.png",
    "descripcion": "Pequeño pero con mucha personalidad, requiere cuidados específicos. . Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate."
  },
  {
    "raza": "Pastor Alemán",
    "tipo": "guardianes",
    "imagen": "assets/images/pastor_aleman.png",
    "descripcion": "Inteligente, leal y protector, ideal para dueños activos. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate."
  }
];

final List<ItemPerro> perros = perrosJson.map((json) => ItemPerro.fromJson(json)).toList();



class GeneratorDogPage extends StatefulWidget {

  @override
  State<GeneratorDogPage> createState() => _GeneratorDogPageState();
}

class _GeneratorDogPageState extends State<GeneratorDogPage> {

  int get indicePerros => perros.length;
  int recorrido = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppStateDog>();
    var pair = appState.currentDog;

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
                    appState.toggleFavoriteDog();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (indicePerros != recorrido){
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

  final ItemPerro pair;

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

class MyAppStateDog extends ChangeNotifier {

  //var current = WordPair.random();
  MyAppStateDog() {
    currentDog = perros[0];
  }
  late ItemPerro currentDog;

  // ↓ Add this.
  void getTravel(int recorrido) {
    //current = WordPair.random();
    currentDog = perros[recorrido];

    notifyListeners();
  }

  var favorites = [];

  void toggleFavoriteDog() {
    if (favorites.contains(currentDog)) {
      favorites.remove(currentDog);
    } else {
      favorites.add(currentDog);
    }
    notifyListeners();
  }
}

class FavoritesPageDog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appStateDog = context.watch<MyAppStateDog>();

    if (appStateDog.favorites.isEmpty) {
      return Center(
        child: Text('No tienes favoritos.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Tiene(s) '
              '${appStateDog.favorites.length} favorito(s):'),
        ),
        for (var pair in appStateDog.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.raza),
          ),
      ],
    );
  }
}