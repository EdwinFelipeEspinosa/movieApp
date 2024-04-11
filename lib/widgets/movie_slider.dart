

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_2/models/movie.dart';

class MovieSlider extends StatelessWidget {

  final List<Movie> movies;

  const MovieSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Title(),
          const SizedBox(height: 3,),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final Movie movie = movies[index];
                print(movie);
                return Container(
                  width:  130,
                  height: 190,
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:  FadeInImage(
                          placeholder:  NetworkImage('https://via.placeholder.com/150x150'),
                          image: NetworkImage('https://image.tmdb.org/t/p/w500'+movie.posterPath!),
                          height: 190,
                          width: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(movie.originalTitle!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20, top: 5),
      child: Text('Populares', style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),)
    );
  }
}