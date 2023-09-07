import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/color/colors.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';

class AllMoviesTile extends StatelessWidget {
  final List<Movie> allMovies;
  const AllMoviesTile({
    required this.allMovies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: allMovies.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            context.push('/movie', extra: allMovies[index].id);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: tilesColor,),
            child: Row(
              
              children: [
                Container(
                  height: 80,
                  width: 120,
                  // child: FadeInImage.assetNetwork(placeholder: 'assets/images/loading.jpg', image: allMovies[index].image, fit: BoxFit.cover,) ,

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(allMovies[index].image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allMovies[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 5),
                        Text(allMovies[index].rating),
                        const SizedBox(width: 15),
                        const Icon(Icons.access_time),
                        Text(allMovies[index].duration),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
