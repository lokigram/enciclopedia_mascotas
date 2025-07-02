import 'package:animales_domesticos/models/pets_model.dart';
import 'package:animales_domesticos/states/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  final List favorites;

  const FavoritesScreen({
    super.key,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ↓ Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      fontFamily: 'GamjaFlower-Regular',
      fontWeight: FontWeight.bold,
      fontSize: 32,
    );
    print(favorites);
    return favorites.isEmpty
        ? Center(child: Text('No tienes favoritos.'))
        : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                    favorites.length == 1
                        ? 'FAVORITO: Tiene ${favorites.length} favorito'
                        : 'FAVORITOS: Tienes ${favorites.length} favoritos',
                    style: style),
              ),
              for (var item in favorites)
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 32.0,
                  ),
                  title: Text(_getFavoriteTitle(item)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    tooltip: 'Quitar de favoritos',
                    onPressed: () => _getFavoriteDelete(context, item),
                  ),
                ),
            ],
          );
  }
}

String _getFavoriteTitle(dynamic item) {
  if (item is Dog) {
    return 'Perro: ${item.raza}';
  } else if (item is Cat) {
    return 'Gato: ${item.raza}';
  } else if (item is Hamster) {
    return 'Hamster: ${item.raza}';
  } else if (item is Parrot) {
    return 'Loro: ${item.especie}';
  } else if (item is Fish) {
    return 'Pez: ${item.especie}';
  } else if (item is Tortoise) {
    return 'Tortuga: ${item.especie}';
  } else if (item is Rabbit) {
    return 'Conejo: ${item.raza}';
  } else {
    return item.tipo;
  }
}

void _getFavoriteDelete(BuildContext context, dynamic item) {
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
}
