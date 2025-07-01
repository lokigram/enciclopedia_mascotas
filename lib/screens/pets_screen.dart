import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animales_domesticos/states/my_app_state.dart';

typedef AnimalToString<T> = String Function(T);

class PetsScreen<T> extends StatelessWidget {
  final AnimalToString<T> getTitle;
  final AnimalToString<T> getSubtitle;
  final AnimalToString<T> getImage;
  final AnimalToString<T> getDescription;

  const PetsScreen({
    super.key,
    required this.getTitle,
    required this.getSubtitle,
    required this.getImage,
    required this.getDescription,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ↓ Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontFamily: 'ABeeZee-Regular',
      fontSize: 36
    );
    var appState = context.watch<MyAppState<T>>();
    final items = appState.items.whereType<T>().toList();
    final current = appState.current;

    return items.isEmpty ? Center(child: Text('No hay elementos disponibles.'))
    :Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: theme.colorScheme.primary,
          elevation: 5.0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(getTitle(current), style: style,)
            ),
          ),
        ),
        SizedBox(height: 20.0,),
        Image.asset(getImage(current), height: 180),
        SizedBox(height: 8.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined, size: 32.0,),
              onPressed: () {
                final prev = items.indexOf(current) - 1;
                if (prev >= 0) {
                  appState.getTravel(prev);
                }
              },
            ),
            SizedBox(width: 16.0,),
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
              icon: Icon(Icons.menu_outlined, size: 32.0,),
            ),
            SizedBox(width: 16.0,),
            IconButton(
              icon: Icon( !appState.favorites.contains(current) ? Icons.favorite_border   :  Icons.favorite, color: Colors.red, size: 32.0,),
              onPressed: appState.toggleFavorite
            ),
            SizedBox(width: 16.0,),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_outlined, size: 32.0,),
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
    );
  }
}