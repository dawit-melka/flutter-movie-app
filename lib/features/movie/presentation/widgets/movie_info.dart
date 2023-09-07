import 'package:flutter/material.dart';

class MovieInfo extends StatelessWidget {
  final String duration;
  final String category;
  const MovieInfo({
    required this.duration,
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          color: Colors.blue,
        ),
        Text(
          "$duration | $category",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}