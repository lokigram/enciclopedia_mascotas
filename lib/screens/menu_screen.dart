import 'package:animales_domesticos/screens/favorites_screen.dart';
import 'package:animales_domesticos/screens/home_screen.dart';
import 'package:animales_domesticos/screens/targets_screen.dart';
import 'package:flutter/material.dart';

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
        page = FavoritesScreen();
      break;
      default:
        throw UnimplementedError('no existe el widget para $_selectedIndex');
    }
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width < 640 
      ?BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: theme.colorScheme.secondary,
        selectedItemColor: theme.colorScheme.primary,
        onTap: (int value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Enciclopedia'),
          BottomNavigationBarItem(icon: Icon(Icons.pets_outlined), label: 'Mascotas'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, color: Colors.redAccent,), label: 'Favoritos',),
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
                  icon: Icon(Icons.home),
                  label: Text('Enciclopedia',),
                ),                 
                NavigationRailDestination(
                  icon: Icon(Icons.pets_outlined),
                  label: Text('Mascotas'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite, color: Colors.redAccent,),
                  label: Text('Favoritos',),
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
