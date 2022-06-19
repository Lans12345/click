import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/search/searchRegionApplicants.dart';
import 'package:dotcom/util/applicants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobApplicants extends StatefulWidget {
  const JobApplicants({Key? key}) : super(key: key);

  @override
  State<JobApplicants> createState() => _JobApplicantsState();
}

late String region = '';
late String accountName = '';

class _JobApplicantsState extends State<JobApplicants> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      region = prefs.getString('region')!;
      accountName = prefs.getString('firstName')!;
    });
  }

  internetToast() {
    return Fluttertoast.showToast(
        msg: 'No Internet Connection!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Nearby Job Seekers',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            const SizedBox(width: 90),
            InkWell(
                onTap: () async {
                  bool result = await InternetConnectionChecker().hasConnection;

                  if (result == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchRegionApplicants()));
                  } else if (result == false) {
                    internetToast();
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      color: Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(Icons.search, color: Colors.black),
                      )),
                ))
          ]),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Applicant')
                  .where('region', isEqualTo: region)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('error');
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                        itemCount: snapshot.data?.size ?? 0,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            SingleChildScrollView(
                              child: ApplicantsContainer(
                                  messengerLink: data.docs[index]
                                      ['messengerAccount'],
                                  imageURL: data.docs[index]['imageURL'],
                                  location: data.docs[index]['location'],
                                  name: data.docs[index]['name'],
                                  email: data.docs[index]['email'],
                                  jobExperience: data.docs[index]['experience'],
                                  educationalAttainment: data.docs[index]
                                      ['educationAttainment'],
                                  contactNumber: data.docs[index]
                                      ['contactNumber'],
                                  jobWanted: data.docs[index]['jobWanted']),
                            ),
                          ]);
                        }),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
