import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String category;
  final String title;
  final String description;
  final String duration;
  final String image;
  final String rating;
  final DateTime createdAt;
  final String id;

  const Movie({
    required this.category,
    required this.title,
    required this.description,
    required this.duration,
    required this.image,
    required this.rating,
    required this.createdAt,
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
