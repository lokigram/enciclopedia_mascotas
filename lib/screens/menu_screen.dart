import 'package:animales_domesticos/models/pets_model.dart';
import 'package:animales_domesticos/screens/favorites_screen.dart';
import 'package:animales_domesticos/screens/home_screen.dart';
import 'package:animales_domesticos/screens/targets_screen.dart';
import 'package:animales_domesticos/states/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  int _selectedIndex = 0;
  double groupAlignment = -1.0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  

  @override
  Widget build(BuildContext context){
    final dogFavs = context.watch<MyAppState<Dog>>().favorites;
    final catFavs = context.watch<MyAppState<Cat>>().favorites;
    final parrotFavs = context.watch<MyAppState<Parrot>>().favorites;
    final tortoiseFavs = context.watch<MyAppState<Tortoise>>().favorites;
    final rabbitFavs = context.watch<MyAppState<Rabbit>>().favorites;
    final hamsterFavs = context.watch<MyAppState<Hamster>>().favorites;
    final fishFavs = context.watch<MyAppState<Fish>>().favorites;

    final List favoritos = [
      ...dogFavs,
      ...catFavs,
      ...parrotFavs,
      ...tortoiseFavs,
      ...rabbitFavs,
      ...hamsterFavs,
      ...fishFavs,
    ];
    final theme = Theme.of(context);
    
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = HomeScreen();
        break;
      case 1:
        page = TargetsScreen();
      break;
      case 2:
        page = FavoritesScreen(favorites: favoritos,);
      break;
      default:
        throw UnimplementedError('no existe el widget para $_selectedIndex');
    }
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640 
      ?BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: theme.colorScheme.onPrimaryContainer,
        unselectedItemColor: theme.colorScheme.primary,
        onTap: (int value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Enciclopedia'),
          const BottomNavigationBarItem(icon: Icon(Icons.pets_outlined), label: 'Mascotas'),
          BottomNavigationBarItem(icon: Icon(favoritos.isEmpty ? Icons.favorite_border   :  Icons.favorite, color: Colors.red,), label: 'Favoritos',),
        ]
      )
      : null,
      body: SafeArea(
        child: Row(
          children: [
            if(MediaQuery.of(context).size.width >= 640)
            NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: groupAlignment,
            onDestinationSelected: (int value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            labelType: labelType,
            destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home, color: theme.colorScheme.primary,),
                  label: Text('Enciclopedia', style: TextStyle(color: theme.colorScheme.primary),),
                ),                 
                NavigationRailDestination(
                  icon: Icon(Icons.pets_outlined, color: theme.colorScheme.primary,),
                  label: Text('Mascotas', style: TextStyle(color: theme.colorScheme.primary),),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite, color: Colors.redAccent,),
                  label: Text('Favoritos', style: TextStyle(color: theme.colorScheme.primary),),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Container(
                child: page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ...
