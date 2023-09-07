import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WatchNowButton extends StatelessWidget {
  const WatchNowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {context.push('/home');},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 27, 149, 249),
        minimumSize: const Size(350, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "Watch Now",
        style: TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}