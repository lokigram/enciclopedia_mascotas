import 'package:animales_domesticos/states/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pets_model.dart';

class FavoritesScreen extends StatelessWidget {

  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  


  // Usar los providers de cada tipo de mascota para obtener todos los favoritos
  final dogFavs = context.watch<MyAppState<Dog>>().favorites;
  final catFavs = context.watch<MyAppState<Cat>>().favorites;
  final parrotFavs = context.watch<MyAppState<Parrot>>().favorites;
  final tortoiseFavs = context.watch<MyAppState<Tortoise>>().favorites;
  final rabbitFavs = context.watch<MyAppState<Rabbit>>().favorites;
  final hamsterFavs = context.watch<MyAppState<Hamster>>().favorites;
  final fishFavs = context.watch<MyAppState<Fish>>().favorites;

  final favorites = [
    ...dogFavs,
    ...catFavs,
    ...parrotFavs,
    ...tortoiseFavs,
    ...rabbitFavs,
    ...hamsterFavs,
    ...fishFavs,
  ];

    return favorites.isEmpty
        ? Center(child: Text('No tienes favoritos.'))
        : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text('FAVORITOS: tienes ${favorites.length} favorito(s)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              for (var item in favorites)
                ListTile(
                  leading: Icon(Icons.favorite, color: Colors.red),
                  title: Text(
                    item is Dog
                        ? 'Perro: ${item.raza}'
                        : item is Cat
                            ? 'Gato: ${item.raza}'
                            : item is Hamster
                                ? 'Hamster: ${item.raza}'
                                : item is Parrot
                                    ? 'Loro: ${item.especie}'
                                    : item is Fish
                                        ? 'Pez: ${item.especie}'
                                        : item is Tortoise
                                            ? 'Tortuga: ${item.especie}'
                                            : item is Rabbit
                                                ? 'Conejo: ${item.raza}'
                                                : item.tipo,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    tooltip: 'Quitar de favoritos',
                    onPressed: () {
                      if (item is Dog) {
                        context.read<MyAppState<Dog>>().toggleFavoriteDelete(item);
                      } else if (item is Cat) {
                        context.read<MyAppState<Cat>>().toggleFavoriteDelete(item);
                      } else if (item is Hamster) {
                        context.read<MyAppState<Hamster>>().toggleFavoriteDelete(item);
                      } else if (item is Parrot) {
                        context.read<MyAppState<Parrot>>().toggleFavoriteDelete(item);
                      } else if (item is Fish) {
                        context.read<MyAppState<Fish>>().toggleFavoriteDelete(item);
                      } else if (item is Tortoise) {
                        context.read<MyAppState<Tortoise>>().toggleFavoriteDelete(item);
                      } else if (item is Rabbit) {
                        context.read<MyAppState<Rabbit>>().toggleFavoriteDelete(item);
                      }
                    },
                  ),
                ),
            ],
          );
  }
}


