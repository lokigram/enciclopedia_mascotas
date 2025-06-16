import 'package:animales_domesticos/screens/generator_cat_page.dart';
import 'package:animales_domesticos/screens/generator_dog_page.dart';
import 'package:animales_domesticos/screens/generator_fish_page.dart';
import 'package:animales_domesticos/screens/generator_hamster_page.dart';
import 'package:animales_domesticos/screens/generator_parrot_page.dart';
import 'package:animales_domesticos/screens/generator_rabbit_page.dart';
import 'package:animales_domesticos/screens/generator_tortoise_page.dart';
import 'package:animales_domesticos/screens/navegation_provider.dart';
import 'package:animales_domesticos/screens/pet_encyclopedia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ...

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ...
    final navigationProvider = Provider.of<NavigationProvider>(context);
    int selectedIndex = navigationProvider.selectedIndex;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = PetEncyclopedia();
        break;
      case 1:
        page = GeneratorDogPage();
      break;
      case 2:
      page = FavoritesPageDog();
      break;
      case 3:
        page = GeneratorCatPage();
      break;
      case 4:
      page = FavoritesPageCat();
      break;      
      case 5:
        page = GeneratorHamsterPage();
      break;
      case 6:
      page = FavoritesPageHamster();
      break;
      case 7:
        page = GeneratorParrotPage();
      break;
      case 8:
      page = FavoritesPageParrot();
      break;
      case 9:
        page = GeneratorFishPage();
      break;
      case 10:
      page = FavoritesPageFish();
      break;
      case 11:
        page = GeneratorTortoisePage();
      break;
      case 12:
      page = FavoritesPageTortoise();
      break;
      case 13:
        page = GeneratorRabbitPage();
      break;
      case 14:
      page = FavoritesPageRabbit();
      break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // ...
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home, size: 32,),
                    label: Text('ENCICLOPEDIA DE MASCOTAS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),                 
                  NavigationRailDestination(
                    icon: Icon(Icons.pets_outlined, size: 32,),
                    label: Text('Perros', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite, size: 18, color: Colors.green,),
                    label: Text('Favoritos'),
                  ), 
                  NavigationRailDestination(
                    icon: Icon(Icons.pets_rounded, size: 32,),
                    label: Text('Gatos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite, size: 18, color: Colors.green,),
                    label: Text('Favoritos'),
                  ),                   
                  NavigationRailDestination(
                    icon: Icon(Icons.pets_sharp, size: 32,),
                    label: Text('Hamster', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite, size: 18, color: Colors.green,),
                    label: Text('Favoritos'),
                  ), 
                  NavigationRailDestination(
                    icon: Icon(Icons.pets, size: 32,),
                    label: Text('Loro', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite, size: 18, color: Colors.green,),
                    label: Text('Favoritos'),
                  ), 
                  NavigationRailDestination(
                    icon: Icon(Icons.pets, size: 32,),
                    label: Text('Pez', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite, size: 18, color: Colors.green,),
                    label: Text('Favoritos'),
                  ), 
                  NavigationRailDestination(
                    icon: Icon(Icons.pets, size: 32,),
                    label: Text('Tortuga', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite, size: 18, color: Colors.green,),
                    label: Text('Favoritos'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.pets, size: 32,),
                    label: Text('Conejo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite, size: 18, color: Colors.green,),
                    label: Text('Favoritos'),
                  ),                
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    Provider.of<NavigationProvider>(context, listen: false).setPage(value);
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ...
