import 'package:flutter/material.dart';

class SearchCategory extends StatelessWidget {
  final String label;
  final String image;

  SearchCategory({required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white,
          height: 120,
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
                  child: Text(label),
                )
              ])),
        ),
      ),
    );
  }
}
