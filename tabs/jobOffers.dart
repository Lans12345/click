import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/search/searchRegionOffers.dart';
import 'package:dotcom/util/offers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobOffers extends StatefulWidget {
  const JobOffers({Key? key}) : super(key: key);

  @override
  State<JobOffers> createState() => _JobOffersState();
}

late String region = '';
late String accountName = '';

class _JobOffersState extends State<JobOffers> {
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
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Job Validity',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                              'Ask to the Company Agent a Validity of the Job Offered',
                              style: TextStyle(fontFamily: 'Quicksand'),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ));
                },
                icon: const Icon(
                  Icons.warning_rounded,
                  color: Colors.black,
                )),
            const Padding(
              padding: EdgeInsets.only(left: 3),
              child: Text(
                'Nearby Job Offers',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            const SizedBox(width: 80),
            InkWell(
                onTap: () async {
                  bool result = await InternetConnectionChecker().hasConnection;

                  if (result == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchRegionOffers()));
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
                  .collection('Offer')
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
                                child: OffersContainer(
                              imageURL: data.docs[index]['imageURL'],
                              companyLocation: data.docs[index]
                                  ['companyLocation'],
                              companyName: data.docs[index]['companyName'],
                              contactNumber: data.docs[index]['contactNumber'],
                              email: data.docs[index]['email'],
                              jobOffer: data.docs[index]['jobOffer'],
                              name: data.docs[index]['name'],
                              requirement: data.docs[index]['jobRequirements'],
                              jobOfPersonWhoPosted: data.docs[index]
                                  ['jobOfAgent'],
                              salary: data.docs[index]['salary'],
                              jobTime: data.docs[index]['jobHour'],
                            )),
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
