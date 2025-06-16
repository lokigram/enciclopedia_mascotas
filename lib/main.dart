
//import 'package:english_words/english_words.dart';
import 'package:animales_domesticos/screens/generator_cat_page.dart';
import 'package:animales_domesticos/screens/generator_dog_page.dart';
import 'package:animales_domesticos/screens/generator_fish_page.dart';
import 'package:animales_domesticos/screens/generator_hamster_page.dart';
import 'package:animales_domesticos/screens/generator_parrot_page.dart';
import 'package:animales_domesticos/screens/generator_rabbit_page.dart';
import 'package:animales_domesticos/screens/generator_tortoise_page.dart';
import 'package:animales_domesticos/screens/my_home_page.dart';
import 'package:animales_domesticos/screens/navegation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAppStateCat()),
        ChangeNotifierProvider(create: (_) => MyAppStateDog()),
        ChangeNotifierProvider(create: (_) => MyAppStateFish()),
        ChangeNotifierProvider(create: (_) => MyAppStateHamster()),
        ChangeNotifierProvider(create: (_) => MyAppStateParrot()),
        ChangeNotifierProvider(create: (_) => MyAppStateRabbit()),
        ChangeNotifierProvider(create: (_) => MyAppStateTortoise()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      title: 'Enciclopedia de Mascotas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 42, 151, 51))
      ),
    );
  }
}


