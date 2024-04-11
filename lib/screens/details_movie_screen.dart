import 'package:flutter/material.dart';

class DetailsMovieScreen extends StatelessWidget {
  const DetailsMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles pelicula'),
      ),
      body: Center(
        child: TextButton(
          child: Text("Regresar", style: TextStyle(fontSize: 30),),
          onPressed: () {
            Navigator.pop(context);
          },
      ),
    ));
  }
}