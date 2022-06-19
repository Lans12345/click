import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPostServices extends StatelessWidget {
  final String location;
  final String serviceType;
  final String serviceOffter;
  final String contactNumber;
  final String serviceHours;
  final String rateFee;
  final String nameOfAgent;
  final String serviceDays;
  final String imageURL;
  final String serviceName;
  final String messengerLink;
  final String accountName;
  final String myContactNumber;

  const MyPostServices({
    required this.location,
    required this.serviceHours,
    required this.serviceOffter,
    required this.serviceType,
    required this.contactNumber,
    required this.rateFee,
    required this.nameOfAgent,
    required this.serviceDays,
    required this.imageURL,
    required this.serviceName,
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
                .doc(serviceName)
                .delete();

            FirebaseFirestore.instance
                .collection('Service')
                .doc('Product-$serviceName-$nameOfAgent-$contactNumber')
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
              const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white,
              height: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Colors.black,
                      size: 15,
                    ),
                    const SizedBox(width: 2),
                    SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          location,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Quicksand'),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    width: 250,
                    child: Center(
                      child: Text(
                        serviceName,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 10),
                    child: Image(height: 120, image: NetworkImage(imageURL)),
                  ),
                  SizedBox(
                    width: 250,
                    child: Center(
                      child: Text(
                        "₱" + rateFee,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand'),
                      ),
                    ),
                  ),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Agent",
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
                                    child: Text(nameOfAgent,
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
                                    child: Text(contactNumber,
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
                                      child: Text('Message Agent',
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
                      ),
                      Container(height: 150, width: 1, color: Colors.grey),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            const Icon(Icons.check_box, color: Colors.white),
                            const SizedBox(width: 5),
                            Column(children: [
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    serviceHours,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontFamily: 'Quicksand'),
                                  ),
                                ),
                              ),
                              const Text('Service Hours',
                                  style: TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      fontFamily: 'Quicksand')),
                            ]),
                          ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            const Icon(Icons.check_box, color: Colors.white),
                            const SizedBox(width: 5),
                            Column(children: [
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    serviceDays,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontFamily: 'Quicksand'),
                                  ),
                                ),
                              ),
                              const Text('Service Days',
                                  style: TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      fontFamily: 'Quicksand')),
                            ]),
                          ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            const Icon(Icons.check_box, color: Colors.white),
                            const SizedBox(width: 5),
                            Column(children: [
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    serviceOffter,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                        fontFamily: 'Quicksand'),
                                  ),
                                ),
                              ),
                              const Text('Service Type',
                                  style: TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      fontFamily: 'Quicksand')),
                            ]),
                          ]),
                        ],
                      ),
                    ])),
          ),
        ),
      ),
    ]);
  }
}
