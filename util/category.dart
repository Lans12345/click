import 'package:flutter/material.dart';

class CategoryCointainer extends StatelessWidget {
  final String label;
  final String image;

  const CategoryCointainer({required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
          height: 100,
          width: 100,
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Image(
                  height: 50,
                  width: 50,
                  image: AssetImage(image),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label,
                    style: const TextStyle(fontFamily: 'Quicksand'),
                  ),
                )
              ])),
        ),
      ),
    );
  }
}
