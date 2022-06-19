import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPostApply extends StatelessWidget {
  final String location;
  final String name;

  final String contactNumber;

  final String jobWanted;
  final String email;
  final String educationalAttainment;
  final String jobExperience;
  final String imageURL;
  final String messengerLink;
  final String accountName;
  final String myContactNumber;

  const MyPostApply({
    required this.location,
    required this.name,
    required this.email,
    required this.jobExperience,
    required this.educationalAttainment,
    required this.contactNumber,
    required this.jobWanted,
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
                .doc('$name-$contactNumber')
                .delete();

            FirebaseFirestore.instance
                .collection('Applicant')
                .doc('Applicant-$name-$contactNumber')
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
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                height: 150,
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            minRadius: 40,
                            maxRadius: 40,
                            backgroundImage: NetworkImage(imageURL),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 150,
                            child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Quicksand'),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () => _launchURL(),
                                      child: const Image(
                                        height: 18,
                                        width: 18,
                                        image: AssetImage(
                                            'lib/images/messenger.png'),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 150,
                            child: Center(
                              child: Text(
                                jobWanted,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontFamily: 'Quicksand'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 130, width: 1, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      color: Colors.black,
                                      child: const Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Icon(
                                          Icons.phone,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                                const SizedBox(width: 5),
                                Text(contactNumber,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Quicksand'))
                              ],
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      color: Colors.black,
                                      child: const Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Icon(
                                          Icons.email,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 80,
                                  child: Text(email,
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Quicksand')),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      color: Colors.black,
                                      child: const Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Icon(
                                          Icons.location_on_rounded,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 80,
                                  child: Text(location,
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Quicksand')),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ])),
          ),
        ),
        back: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ABOUT ME',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Quicksand'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5),
                        Column(children: [
                          Row(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  color: Colors.white,
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.school_rounded,
                                      size: 10,
                                      color: Colors.black,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 5),
                            const Text('Educational Attainment: ',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand')),
                          ]),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 120,
                            child: Text(educationalAttainment,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand')),
                          ),
                        ]),
                        const SizedBox(width: 20),
                        Column(children: [
                          Row(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  color: Colors.white,
                                  child: const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.work_rounded,
                                      size: 10,
                                      color: Colors.black,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 5),
                            const Text('Job Experiences: ',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand')),
                          ]),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 120,
                            child: Text(jobExperience,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Quicksand')),
                          ),
                        ]),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    ]);
  }
}
