import 'package:flutter/material.dart';
import 'package:movie_2/providers/moviePopularProvider.dart';
import 'package:movie_2/providers/movie_provider.dart';
import 'package:movie_2/widgets/card_swipper.dart';
import 'package:movie_2/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MovieProvider>(context);
    final moviesProvider2 = Provider.of<moviePopularProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cartelera'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          CardSwipper(movies: moviesProvider.listNowPlayingMovies,),
          MovieSlider(movies: moviesProvider2.listNowPopularMovies)
        ],),
      )
    );
  }
}