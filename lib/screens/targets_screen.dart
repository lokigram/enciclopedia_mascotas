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

  

  int? itemSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ↓ Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      fontFamily: 'GamjaFlower-Regular',
      fontSize: 24,
    );
    final orientacion = MediaQuery.of(context).orientation;

    Widget? page;
    if (itemSelect != null) {
      switch (itemSelect) {
        case 0:
          page = PetsScreen<Dog>(
            getTitle: (item) => item.raza,
            getSubtitle: (item) => item.tipo,
            getImage: (item) => item.retrato,
            getDescription: (item) => item.descripcion,
          );
          break;
        case 1:
          page = PetsScreen<Cat>(
            getTitle: (item) => item.raza,
            getSubtitle: (item) => item.tipo,
            getImage: (item) => item.retrato,
            getDescription: (item) => item.descripcion,
          );
          break;
        case 2:
          page = PetsScreen<Parrot>(
            getTitle: (item) => item.especie,
            getSubtitle: (item) => item.tipo,
            getImage: (item) => item.retrato,
            getDescription: (item) => item.descripcion,
          );
          break;
        case 3:
          page = PetsScreen<Tortoise>(
            getTitle: (item) => item.especie,
            getSubtitle: (item) => item.tipo,
            getImage: (item) => item.retrato,
            getDescription: (item) => item.descripcion,
          );
          break;
        case 4:
          page = PetsScreen<Rabbit>(
            getTitle: (item) => item.raza,
            getSubtitle: (item) => item.tipo,
            getImage: (item) => item.retrato,
            getDescription: (item) => item.descripcion,
          );
          break;
        case 5:
          page = PetsScreen<Hamster>(
            getTitle: (item) => item.raza,
            getSubtitle: (item) => item.tipo,
            getImage: (item) => item.retrato,
            getDescription: (item) => item.descripcion,
          );
          break;
        case 6:
          page = PetsScreen<Fish>(
            getTitle: (item) => item.especie,
            getSubtitle: (item) => item.tipo,
            getImage: (item) => item.retrato,
            getDescription: (item) => item.descripcion,
          );
          break;
        default:
          throw UnimplementedError('no hay widget para $itemSelect');
      }
    }
    return _cargando
        ? Center(child: CircularProgressIndicator())
        : (itemSelect != null && page != null)
            ? Scaffold(
              body: SizedBox(

                height: double.infinity,
                child: Center(
                  child: page
                  )
                ),
              floatingActionButton: FloatingActionButton.extended(
                heroTag: 'back_btn',
                elevation: 4,
                onPressed: () {
                  setState(() {
                    itemSelect = null;
                  });
                },
                icon: const Icon(Icons.arrow_back),
                label: Text('Regresar', style: style,),                                       
              )
            )
            : Column(
              children: [
                Expanded(
                  child: orientacion == Orientation.portrait
                      ? ListView.builder(
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
                                        itemSelect = index;
                                      });
                                    },
                                    child: ItemMascotaCard(
                                      color: Colors.primaries[index % Colors.primaries.length],
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
                                        icon: const Icon(Icons.volume_up, size: 30, color: Colors.black),
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
                                        icon: Icon(Icons.menu_outlined, size: 30, color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : StaggeredDualView(
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
                                            itemSelect = index;
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(top: index == 1 ? width * 0.2 : 0.0),
                                          child: ItemMascotaCard(
                                            color: Colors.primaries[index % Colors.primaries.length],
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
                                            icon: const Icon(Icons.volume_up, size: 30, color: Color.fromARGB(255, 36, 24, 24)),
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
                                            icon: Icon(Icons.menu_outlined, size: 30, color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
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
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      fontFamily: 'GamjaFlower-Regular'
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
