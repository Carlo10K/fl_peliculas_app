import "package:flutter/material.dart";
import "package:peliculas_app/providers/movies_provider.dart";
import "package:peliculas_app/widgets/widgets.dart";
import "package:provider/provider.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          //Swiper
          CardSwiper(movies: moviesProvider.onDisplayMovies),

          //Slider
          MovieSlider(movies: moviesProvider.popularMovies, title: 'Populares')
        ]),
      ),
    );
  }
}
