import 'package:mobile/features/movie/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required String category,
    required String title,
    required String description,
    required String duration,
    required String image,
    required String rating,
    required DateTime createdAt,
    required String id,
  }) : super(
          category: category,
          title: title,
          description: description,
          duration: duration,
          image: image,
          rating: rating,
          createdAt: createdAt,
          id: id,
        );

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    print(map['category']);
    print(map['title']);
    print(map['description']);
    print(map['createdAt']);
    print(map['image']);
    print(map['rating']);
    print(map['id']);
    return MovieModel(
        category: map['category'],
        title: map['title'],
        description: map['description'],
        duration: map['duration'],
        image: map['image'],
        rating: map['rating'].toString(),
        createdAt: DateTime.parse(map['createdAt']),
        id: map['id']);
  }
}
