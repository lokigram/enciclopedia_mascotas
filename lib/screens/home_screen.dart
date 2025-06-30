import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment(0.0, 0.6),
              children: <Widget>[
                Text(
                  'Bienvenidos a la enciclopedia de mascotas', 
                  style: TextStyle(fontSize: 32, fontFamily: 'GamjaFlower-Regular'),
                  textAlign: TextAlign.center
                ),          
                Image.asset(
                  'assets/images/portada.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ],
            ),
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