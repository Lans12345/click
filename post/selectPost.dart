import 'package:dotcom/post/postApply.dart';
import 'package:dotcom/post/postOffer.dart';
import 'package:dotcom/post/postProduct.dart';
import 'package:dotcom/post/postServices.dart';
import 'package:dotcom/util/post.dart';
import 'package:flutter/material.dart';

class SelectPost extends StatelessWidget {
  const SelectPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Type of Post',
          style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Quicksand'),
        ),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PostProduct()));
              },
              child:
                  Post(image: 'lib/images/product.png', post: 'Sell Products'),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PostServices()));
              },
              child: Post(
                  image: 'lib/images/services.png', post: 'Offer a Service'),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PostApply()));
              },
              child: Post(
                  image: 'lib/images/findJob.png', post: 'Apply for a Job'),
            )),
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PostOffer()));
                    },
                    child: Post(
                        image: 'lib/images/offerJob.png', post: 'Offer a Job')))
          ]),
    );
  }
}
