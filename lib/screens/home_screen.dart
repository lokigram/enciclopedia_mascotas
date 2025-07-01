import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      fontWeight: FontWeight.bold,
      fontFamily: 'GamjaFlower-Regular'
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [            
            Stack(
              alignment: Alignment(0.0, 0.8),
              children: <Widget>[
                Text(
                  'Enciclopedia de mascotas', 
                  style: style,
                  textAlign: TextAlign.center
                ),  
                Image.asset(
                  'assets/images/portada.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),          
              ],
            ),
            SizedBox(height: 8.0,),
            Text(
                  'La elección de una mascota depende de factores como el estilo de vida, el espacio disponible y el nivel de compromiso del dueño.', 
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify
                ),
          ]
        ),
      ),
    );  
  }
}