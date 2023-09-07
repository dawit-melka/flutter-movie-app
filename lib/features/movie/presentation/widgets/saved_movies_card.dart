import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/color/colors.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';

class SavedMoviesCard extends StatelessWidget {
  final List<Movie> savedMovies;
  const SavedMoviesCard({
    required this.savedMovies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: savedMovies.length,
        options: CarouselOptions(
          height: 250,
          autoPlay: true,
          viewportFraction: 0.59,
          autoPlayInterval:
              const Duration(seconds: 2), // Specify the auto-play interval
          autoPlayAnimationDuration: const Duration(seconds: 1),
          // pageSnapping: true,
        ),
        itemBuilder: (context, index, pageViewIndex) {
          return InkWell(
            onTap: () {
              context.push('/movie', extra: savedMovies[index].id);
            },
            child: Stack(
              children: [
                Container(
                  height: 250,
                  width: 200,
                  // child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(12),
                  //     child: FadeInImage.assetNetwork(
                  //       placeholder: 'assets/images/loading.jpg',
                  //       image: savedMovies[index].image,
                  //       fit: BoxFit.cover,
                  //     )),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        savedMovies[index].image,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    // margin: EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tile2Color,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          savedMovies[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5),
                            Text(savedMovies[index].rating),
                            const SizedBox(width: 15),
                            const Icon(Icons.access_time),
                            Text(savedMovies[index].duration),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
