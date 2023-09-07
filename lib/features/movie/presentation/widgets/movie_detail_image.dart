import 'package:flutter/material.dart';

class MovieDetailImage extends StatelessWidget {
  final String image;
  final String rating;
  const MovieDetailImage({
    required this.image,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          right: 30,
          bottom: 0,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  rating,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}