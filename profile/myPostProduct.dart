import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPostProduct extends StatelessWidget {
  final String productName;
  final String location;
  final String typeOfDelivery;
  final String price;
  final String paymentMethod;
  final String productDescription;
  final String nameOfSeller;
  final String contactNumberOfSeller;
  final String productCondition;
  final String imageURL;
  final String messengerLink;
  final String accountName;
  final String myContactNumber;

  const MyPostProduct({
    required this.productName,
    required this.location,
    required this.typeOfDelivery,
    required this.price,
    required this.paymentMethod,
    required this.productDescription,
    required this.nameOfSeller,
    required this.contactNumberOfSeller,
    required this.productCondition,
    required this.imageURL,
    required this.messengerLink,
    required this.accountName,
    required this.myContactNumber,
  });

  void _launchURL() async => await canLaunch(messengerLink)
      ? await launch(messengerLink)
      : throw 'Not found $messengerLink';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RaisedButton(
          color: Colors.black,
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            FirebaseFirestore.instance
                .collection('$accountName$myContactNumber')
                .doc(productName)
                .delete();

            FirebaseFirestore.instance
                .collection('Product')
                .doc(
                    'Product-$productName-$nameOfSeller-$contactNumberOfSeller')
                .delete();
          },
          child: const Text(
            'Delete Post',
            style: TextStyle(color: Colors.white, fontFamily: 'Quicksand'),
          )),
      FlipCard(
        fill: Fill
            .fillBack, // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.VERTICAL, // default
        front: Padding(
          padding:
              const EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 175,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                        child: Image(
                            fit: BoxFit.contain,
                            height: 120,
                            image: NetworkImage(imageURL)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Column(
                          children: [
                            Row(children: [
                              const Icon(Icons.location_on_rounded,
                                  color: Colors.black, size: 15),
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    location,
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Quicksand'),
                                  ),
                                ),
                              )
                            ]),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: SizedBox(
                                  width: 150,
                                  child: Center(
                                      child: Text(
                                    productName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        fontFamily: 'Quicksand'),
                                  ))),
                            ),
                            const SizedBox(height: 10),
                            Row(children: [
                              Text(
                                "₱" + price,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Quicksand'),
                              )
                            ]),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        back: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                height: 175,
                color: Colors.black,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    typeOfDelivery,
                                    style: const TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontFamily: 'Quicksand'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    productCondition,
                                    style: const TextStyle(
                                        fontSize: 8.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontFamily: 'Quicksand'),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  paymentMethod,
                                  style: const TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                      fontFamily: 'Quicksand'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 150,
                            child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(width: 8),
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const SizedBox(
                            width: 150,
                            child: Center(
                              child: Text(
                                'Product Description',
                                style: TextStyle(
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 120,
                            child: Center(
                              child: Text(
                                productDescription,
                                style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 150, width: 1, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Seller",
                                style: TextStyle(
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand')),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Center(
                                    child: Text(nameOfSeller,
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Quicksand')),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 1),
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Center(
                                    child: Text(contactNumberOfSeller,
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                            fontFamily: 'Quicksand')),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () => _launchURL(),
                                child: Container(
                                    color: Colors.white,
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text('Message Seller',
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontFamily: 'Quicksand')),
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                    ])),
          ),
        ),
      ),
    ]);
  }
}
