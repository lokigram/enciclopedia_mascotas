import 'package:animales_domesticos/models/pets_repository.dart';
import 'package:animales_domesticos/models/pets_model.dart';
import 'package:animales_domesticos/screens/pets_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class TargetsScreen extends StatefulWidget {
  @override
  State<TargetsScreen> createState() => _TargetsScreenState();
}

class _TargetsScreenState extends State<TargetsScreen> {
  final AudioPlayer _player = AudioPlayer();
  Widget? _detalleSeleccionado;
  List<ItemMascota> _itemMascotas = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarItemMascotas();
  }

  Future<void> _cargarItemMascotas() async {
    final repo = MascotaItemRepository();
    await repo.cargarItemMascotasDesdeJson();

    setState(() {
      _itemMascotas = repo.itemMascotas;
      _cargando = false;
    });
  }

  Widget buildDetalleItemMascota(int itemSelect) {
    switch (itemSelect) {
      case 0:
        return PetsScreen<Dog>(
          getTitle: (item) => item.raza,
          getSubtitle: (item) => item.tipo,
          getImage: (item) => item.retrato,
          getDescription: (item) => item.descripcion,
          onBack: () {
            setState(() {
              _detalleSeleccionado = null;
            });
          },
        );
      case 1:
        return PetsScreen<Cat>(
          getTitle: (item) => item.raza,
          getSubtitle: (item) => item.tipo,
          getImage: (item) => item.retrato,
          getDescription: (item) => item.descripcion,
          onBack: () {
            setState(() {
              _detalleSeleccionado = null;
            });
          },
        );
      case 2:
        return PetsScreen<Parrot>(
          getTitle: (item) => item.especie,
          getSubtitle: (item) => item.tipo,
          getImage: (item) => item.retrato,
          getDescription: (item) => item.descripcion,
          onBack: () {
            setState(() {
              _detalleSeleccionado = null;
            });
          },
        );
      case 3:
        return PetsScreen<Tortoise>(
          getTitle: (item) => item.especie,
          getSubtitle: (item) => item.tipo,
          getImage: (item) => item.retrato,
          getDescription: (item) => item.descripcion,
          onBack: () {
            setState(() {
              _detalleSeleccionado = null;
            });
          },
        );
      case 4:
        return PetsScreen<Rabbit>(
          getTitle: (item) => item.raza,
          getSubtitle: (item) => item.tipo,
          getImage: (item) => item.retrato,
          getDescription: (item) => item.descripcion,
          onBack: () {
            setState(() {
              _detalleSeleccionado = null;
            });
          },
        );
      case 5:
        return PetsScreen<Hamster>(
          getTitle: (item) => item.raza,
          getSubtitle: (item) => item.tipo,
          getImage: (item) => item.retrato,
          getDescription: (item) => item.descripcion,     
          onBack: () {
            setState(() {
              _detalleSeleccionado = null;
            });
          },
        );
      case 6:
        return PetsScreen<Fish>(
          getTitle: (item) => item.especie,
          getSubtitle: (item) => item.tipo,
          getImage: (item) => item.retrato,
          getDescription: (item) => item.descripcion,
          onBack: () {
            setState(() {
              _detalleSeleccionado = null;
            });
          },
        );
      default:
        throw UnimplementedError('no hay widget para $itemSelect');
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientacion = MediaQuery.of(context).orientation;

    if (_cargando) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: orientacion == Orientation.portrait
                  ? _detalleSeleccionado != null ? _detalleSeleccionado! 
                  :(ListView.builder(
                      itemCount: _itemMascotas.length,
                      itemBuilder: (context, index) {
                        final item = _itemMascotas[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment(1.0, 1.0),
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _detalleSeleccionado = buildDetalleItemMascota(index);
                                  });
                                },
                                child: ItemMascotaCard(
                                  color: Colors.primaries[
                                      index % Colors.primaries.length],
                                  item: item,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _player.play(AssetSource(item.sonido));
                                    },
                                    icon: const Icon(Icons.volume_up,
                                        size: 30, color: Colors.black),
                                  ),
                                  IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(item.tipo),
                                        content: SizedBox(
                                          width: 100,
                                          child: Text(item.caracteristica),
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
                                  icon: Icon(Icons.menu_outlined,
                                      size: 30, color: Colors.black),
                                  ),                                
                               ],
                              )
                            ],
                          ),
                        );
                      },
                    ))
                  : _detalleSeleccionado != null ? _detalleSeleccionado!  
                  :(StaggeredDualView(
                      itemCount: _itemMascotas.length,
                      itemBuilder: (context, index) {
                        final item = _itemMascotas[index];
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment(1.0, 1.0),
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _detalleSeleccionado = buildDetalleItemMascota(index);
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: index == 1 ? width * 0.2 : 0.0),
                                      child: ItemMascotaCard(
                                        color: Colors.primaries[
                                            index % Colors.primaries.length],
                                        item: item,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _player.play(AssetSource(item.sonido));
                                        },
                                        icon: const Icon(Icons.volume_up,
                                            size: 30, color: Color.fromARGB(255, 36, 24, 24)),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(item.tipo),
                                              content: SizedBox(
                                                width: 100,
                                                child: Text(item.caracteristica),
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
                                        icon: Icon(Icons.menu_outlined,
                                            size: 30, color: Colors.black),
                                      ),                                      
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemMascotaCard extends StatelessWidget {
  const ItemMascotaCard({super.key, required this.color, required this.item});

  final Color color;
  final ItemMascota item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    );
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 5.0,
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.3),
              color,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: item.tipo
                    .split('')
                    .map((letra) => Text(letra, style: style))
                    .toList(),
              ),
              const SizedBox(height: 10.0),
              if (item.imagen.isNotEmpty)
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset(
                    item.imagen,
                    fit: BoxFit.fill,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// obtenerUnaPorTipo(mascotas) {
//   final Map<Type, Mascota> mapa = {};
//   for (var mascota in mascotas) {
//     mapa[mascota.runtimeType] ??= mascota;
//   }
//   return mapa.values.toList();
// }

// class MascotaItem extends StatefulWidget {
//   const MascotaItem({super.key, required this.color, required this.mascota});

//   final Color color;
//   final Mascota mascota;

//   @override
//   State<MascotaItem> createState() => _MascotaItemState();
// }

// class _MascotaItemState extends State<MascotaItem> {
//   //se encarga de reproducir sonido

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final style = theme.textTheme.displayMedium!.copyWith(
//       color: theme.colorScheme.onSecondary,
//       fontSize: 16,
//       fontWeight: FontWeight.bold,
//       letterSpacing: 1,
//     );
//     return Card(
//         clipBehavior: Clip.hardEdge,
//         elevation: 5.0,
//         child: Container(
//           height: 160,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//               widget.color.withValues(alpha: 0.3),
//               widget.color,
//             ]),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: widget.mascota.tipo
//                       .split('')
//                       .map((letra) => Text(letra, style: style))
//                       .toList(),
//                 ),
//                 const SizedBox(height: 10.0),
//                 AspectRatio(
//                   aspectRatio: 1.2,
//                   //child: Image.asset(
//                   //widget.mascota.imagen,
//                   //fit: BoxFit.fill,
//                   //)
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.spacing = 16.0,
  });

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
