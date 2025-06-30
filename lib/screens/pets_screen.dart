import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animales_domesticos/states/my_app_state.dart';

typedef AnimalToString<T> = String Function(T);

class PetsScreen<T> extends StatelessWidget {
  final AnimalToString<T> getTitle;
  final AnimalToString<T> getSubtitle;
  final AnimalToString<T> getImage;
  final AnimalToString<T> getDescription;
  final VoidCallback? onBack;

  const PetsScreen({
    super.key,
    required this.getTitle,
    required this.getSubtitle,
    required this.getImage,
    required this.getDescription,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ↓ Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 36,
      fontFamily: 'ABeeZee-Regular'
    );
    var appState = context.watch<MyAppState<T>>();
    final items = appState.items.whereType<T>().toList();
    final current = appState.current;

    return items.isEmpty ? Center(child: Text('No hay elementos disponibles.'))
    :Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: theme.colorScheme.primary,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTitle(current), style: style)
                  ),
                ),
                Image.asset(getImage(current), height: 180),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        final prev = items.indexOf(current) - 1;
                        if (prev >= 0) {
                          appState.getTravel(prev);
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(getSubtitle(current)),
                            content: SizedBox(
                              width: 100,
                              child: Text(getDescription(current), textAlign: TextAlign.justify),
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
                      icon: Icon(Icons.menu_outlined),
                    ),
                    IconButton(
                      icon: Icon( !appState.favorites.contains(current) ? Icons.favorite_border   :  Icons.favorite, color: Colors.red),
                      onPressed: appState.toggleFavorite
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        final next = items.indexOf(current) + 1;
                        if (next < items.length) {
                          appState.getTravel(next);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 0,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back, size: 24),
            onPressed: onBack,
            label: Text('Atras'),
          ),
        ),
      ],
    );
  }
}