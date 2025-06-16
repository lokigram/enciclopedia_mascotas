import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


class ItemMascota {
  final String nombre;
  final String descripcion;
  final String imagen;
  final String sonido;

  ItemMascota({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.sonido,
  });

  factory ItemMascota.fromJson(Map<String, dynamic> json) {
    return ItemMascota(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagen: json['imagen'],
      sonido: json['sonido'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'imagen': imagen,
      'sonido': sonido
    };
  }

}

final List<Map<String, dynamic>> mascotasJson = [
  {
    "nombre": "Perro",
    "descripcion": "El perro es un animal doméstico muy querido por su lealtad y compañía.",
    "imagen": "assets/images/perro.png",
    "sonido": "sounds/perro.mp3"
  },
  {
    "nombre": "Gato",
    "descripcion": "El gato es un animal independiente y juguetón, conocido por su elegancia.",
    "imagen": "assets/images/gato.png",
    "sonido": "sounds/gato.mp3"
  },
  {
    "nombre": "Loro",
    "descripcion": "El loro es un ave colorida y habladora, famosa por su capacidad de imitar sonidos.",
    "imagen": "assets/images/loro.png",
    "sonido": "sounds/loro.mp3"
  },
  {
    "nombre": "Tortuga",
    "descripcion": "La tortuga es un reptil de caparazón duro, conocido por su longevidad y lentitud.",
    "imagen": "assets/images/tortuga.png",
    "sonido": "sounds/tortuga.mp3"
  },
  {
    "nombre": "Conejo",
    "descripcion": "El conejo es un animal pequeño y peludo, famoso por sus largas orejas y saltos.",
    "imagen": "assets/images/conejo.png",
    "sonido": "sounds/conejo.mp3"
  },
  {
    "nombre": "Hamster",
    "descripcion": "El hámster es un pequeño roedor, popular como mascota por su tamaño y naturaleza juguetona.",
    "imagen": "assets/images/hamster.png",
    "sonido": "sounds/Hamster.mp3"
  },
  {
    "nombre": "Pez",
    "descripcion": "El pez es un animal acuático, conocido por su belleza y variedad de especies.",
    "imagen": "assets/images/pez.png",
    "sonido": "sounds/pez.mp3"
  },
];

final List<ItemMascota> mascotas = mascotasJson.map((json) => ItemMascota.fromJson(json)).toList();

class PetEncyclopedia extends StatelessWidget {
  const PetEncyclopedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: StaggeredDualView(
            itemBuilder: (context, index){ 
            if(index != 1){
              return
                MascotaItem(
                  mascota: mascotas[index],
                );
            }else{
              return LayoutBuilder(builder: (context, constraints){
                final width = constraints.maxWidth;
                //final height = constraints.maxHeight*0.5;
                return Padding(
                  padding: EdgeInsets.only(top: index.isOdd ? width : 0.0),
                  child: MascotaItem(
                    mascota: mascotas[index],
                  ),
                );
              });
            }
          
          }, itemCount: mascotas.length),
        );
  }
}

class MascotaItem extends StatefulWidget {
  const MascotaItem({super.key, required this.mascota});

  final ItemMascota mascota;

  @override
  State<MascotaItem> createState() => _MascotaItemState();
}

class _MascotaItemState extends State<MascotaItem> {
  
  TextEditingController controlTexto =
      TextEditingController(); 
 //recuperar o asignar contenido a la caja de texto
  final AudioPlayer _player = AudioPlayer(); 
 //se encarga de reproducir sonido

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
      fontSize: 24
    );
    return Card(
            clipBehavior: Clip.hardEdge,
            elevation: 5.0,
            color: theme.colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: Image.asset(
                      widget.mascota.imagen,// Use Image.network for network images or Image.asset for local assets
                      fit: BoxFit.fill,
                    )
                  ),
                  SizedBox(height: 8.0), // Add some space between the image and text
                  Text(widget.mascota.nombre, style: style, textAlign: TextAlign.center),
                  const SizedBox(height: 4.0),
                  Text(widget.mascota.descripcion, style: TextStyle(fontSize: 14, fontFamily: 'Roboto'), textAlign: TextAlign.justify,), //overflow: TextOverflow.ellipsis, maxLines: 4,
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                       _player.play(AssetSource(widget.mascota.sonido));
                    },
                    child: Text('Escuchar', style: TextStyle(fontSize: 11),),
                  ),
                ]
              ),
            )
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

// class StaggeredDualView extends StatelessWidget {
//   const StaggeredDualView({
//     super.key, 
//     required this.itemBuilder, 
//     required this.itemCount, 
//     this.spacing = 0.0, 
//     this.aspectRatio = 0.4
//     }
//   );

//   final IndexedWidgetBuilder itemBuilder;
//   final int itemCount;
//   final double spacing;
//   final double aspectRatio;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         final itemHeight = (width*0.5) / aspectRatio;
//         final height = constraints.maxHeight + itemHeight;
//         return OverflowBox(
//           minWidth: width,
//           maxWidth: width,
//           minHeight: height,
//           maxHeight: height,
//           child: GridView.builder(
//             padding: EdgeInsets.only(top: itemHeight / 2, bottom: itemHeight),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: spacing,
//               crossAxisSpacing: spacing,
//               childAspectRatio: aspectRatio,
//             ),
//             itemCount: itemCount,
//             itemBuilder: (BuildContext context, int index) {
//               return Transform.translate(
//                 offset: Offset(0.0, index.isOdd ? itemHeight * 0.5 : 0.0), // Stagger the items vertically
//                 child: itemBuilder(context, index),
//               );
//             },
//           ),
//         );
//     }
//     );
//   }
// }