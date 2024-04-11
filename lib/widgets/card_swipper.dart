import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_2/models/movie.dart';

class CardSwipper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwipper(
    {
      super.key,
      required this.movies
    }
  );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.5,
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.9,
        itemBuilder: (_, int index){
          final Movie movie = movies[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: NetworkImage('https://via.placeholder.com/150x150'),
              image: NetworkImage('https://image.tmdb.org/t/p/w500'+movie.posterPath!),
              fit: BoxFit.fill,
            ),
          );
        },
      )
    );
  }
}
