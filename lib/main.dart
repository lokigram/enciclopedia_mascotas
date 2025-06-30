
//import 'package:english_words/english_words.dart';
// import 'package:animales_domesticos/config/theme.dart';
// import 'package:animales_domesticos/config/util.dart';
import 'package:animales_domesticos/models/pets_repository.dart';
import 'package:animales_domesticos/screens/menu_screen.dart';
import 'package:animales_domesticos/states/my_app_state.dart';
import 'package:animales_domesticos/models/pets_model.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppInitializer());
}

class AppInitializer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initRepo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              )
            ),
          );
        }
        final repo = snapshot.data as MascotasRepository;
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<MyAppState<Dog>>(create: (_) => MyAppState<Dog>(repo.perros)),
            ChangeNotifierProvider<MyAppState<Cat>>(create: (_) => MyAppState<Cat>(repo.gatos)),
            ChangeNotifierProvider<MyAppState<Parrot>>(create: (_) => MyAppState<Parrot>(repo.loros)),
            ChangeNotifierProvider<MyAppState<Tortoise>>(create: (_) => MyAppState<Tortoise>(repo.tortugas)),
            ChangeNotifierProvider<MyAppState<Rabbit>>(create: (_) => MyAppState<Rabbit>(repo.conejos)),
            ChangeNotifierProvider<MyAppState<Hamster>>(create: (_) => MyAppState<Hamster>(repo.hamsters)),
            ChangeNotifierProvider<MyAppState<Fish>>(create: (_) => MyAppState<Fish>(repo.pescados)),
          ],
          child: MyApp(),
        );
      },
    );
  }

  Future<MascotasRepository> _initRepo() async {
    MascotasRepository repo = MascotasRepository();
    await repo.cargarMascotasDesdeJson();
    return repo;
  }
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TextTheme textTheme = createTextTheme(context, "ABeeZee", "Gamja Flower");
    // MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      home: MenuScreen(),
      title: 'Enciclopedia de Mascotas',
      // theme: theme.light(),
      theme: ThemeData(
        fontFamily: 'ABeeZee-Regular',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 42, 151, 51))
      ),
    );
  }
}