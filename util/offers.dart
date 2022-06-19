import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class OffersContainer extends StatelessWidget {
  final String companyName;
  final String jobOffer;
  final String name;
  final String contactNumber;
  final String email;
  final String companyLocation;
  final String requirement;
  final String jobOfPersonWhoPosted;
  final String jobTime;
  final String salary;
  final String imageURL;

  const OffersContainer({
    required this.companyLocation,
    required this.companyName,
    required this.contactNumber,
    required this.email,
    required this.jobOffer,
    required this.name,
    required this.requirement,
    required this.jobOfPersonWhoPosted,
    required this.jobTime,
    required this.salary,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill
          .fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL, // default
      front: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              height: 225,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      children: [
                        Image(
                            fit: BoxFit.contain,
                            width: 65,
                            image: NetworkImage(imageURL)),
                        const SizedBox(width: 7),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              companyName,
                              style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Quicksand'),
                            ),
                            const SizedBox(height: 3),
                            Text(companyLocation,
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey,
                                    fontFamily: 'Quicksand')),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Hiring",
                      style: TextStyle(
                          fontSize: 8.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontFamily: 'Quicksand')),
                  Text(
                    jobOffer,
                    style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Quicksand'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 40),
                    child: Row(
                      children: [
                        Text(jobTime + " -",
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontFamily: 'Quicksand')),
                        const SizedBox(width: 5),
                        Text(salary,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontFamily: 'Quicksand')),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
      back: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              height: 200,
              color: Colors.black,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person,
                                size: 25, color: Colors.white),
                            const SizedBox(width: 2),
                            Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Quicksand'),
                                    ),
                                  ),
                                ),
                                Text(
                                  jobOfPersonWhoPosted,
                                  style: const TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand'),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.phone,
                                size: 18, color: Colors.white),
                            const SizedBox(width: 2),
                            Column(
                              children: [
                                Center(
                                  child: Text(
                                    contactNumber,
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Quicksand'),
                                  ),
                                ),
                                const Text(
                                  'Contact Number',
                                  style: TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand'),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.email_rounded,
                                size: 18, color: Colors.white),
                            const SizedBox(width: 5),
                            Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      email,
                                      style: const TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Quicksand'),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Email Address',
                                  style: TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand'),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded,
                                size: 18, color: Colors.white),
                            const SizedBox(width: 5),
                            Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      companyLocation,
                                      style: const TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Quicksand'),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Company Address',
                                  style: TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand'),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(height: 200, width: 1, color: Colors.grey),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.check, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Requirements',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontFamily: 'Quicksand'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: 130,
                          child: Text(
                            requirement,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                                fontFamily: 'Quicksand'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
