import 'package:flutter/material.dart';
import 'package:movie_2/providers/moviePopularProvider.dart';
import 'package:movie_2/providers/movie_provider.dart';
import 'package:movie_2/screens/screens.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider(), lazy: false,),
        ChangeNotifierProvider(create: (_) => moviePopularProvider(), lazy: false,)
      ],
      child: MyApp(),
    );
  }
  
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailsMovieScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.indigo
        )
      ),
    );
  }
}