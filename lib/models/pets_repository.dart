import 'dart:convert';

import 'package:animales_domesticos/models/pets_model.dart';
import 'package:flutter/services.dart';

class MascotaItemRepository {
  List<ItemMascota> _itemMascotas = [];

  Future<void> cargarItemMascotasDesdeJson() async {
    String jsonResponse = await rootBundle.loadString('assets/data/item_mascotas.json');
    final List<dynamic> data = jsonDecode(jsonResponse);
    _itemMascotas = data.map<ItemMascota>((json) => ItemMascota.fromJson(json)).toList();
  }

  List<ItemMascota> get itemMascotas => List.unmodifiable(_itemMascotas);
}

class MascotasRepository {

  List<Mascota> _mascotas = [];

  Future<void> cargarMascotasDesdeJson() async{
    String jsonResponse = await rootBundle.loadString('assets/data/mascotas.json');
    final List<dynamic> data = jsonDecode(jsonResponse);
    _mascotas = data.map<Mascota>((json) {
      switch (json['tipo']) {
        case 'Perro':
          return Dog.fromJson(json);
        case 'Gato':
          return Cat.fromJson(json);
        case 'Pez':
          return Fish.fromJson(json);
        case 'Hamster':
          return Hamster.fromJson(json);
        case 'Loro':
          return Parrot.fromJson(json);
        case 'Conejo':
          return Rabbit.fromJson(json);
        case 'Tortuga':
          return Tortoise.fromJson(json);
        default:
          throw UnimplementedError('Tipo de mascota desconocido');
      }
    }).toList();
  }

  List<Mascota> get todasLasMascotas => List.unmodifiable(_mascotas);

  List<Cat> get gatos => _mascotas.whereType<Cat>().toList();
  List<Dog> get perros => _mascotas.whereType<Dog>().toList();
  List<Fish> get pescados => _mascotas.whereType<Fish>().toList();
  List<Hamster> get hamsters => _mascotas.whereType<Hamster>().toList();
  List<Parrot> get loros => _mascotas.whereType<Parrot>().toList();
  List<Rabbit> get conejos => _mascotas.whereType<Rabbit>().toList();
  List<Tortoise> get tortugas => _mascotas.whereType<Tortoise>().toList();

  //List<Mascota> get favoritos => _mascotas.where((m) => m.esFavorito).toList();
  
}
