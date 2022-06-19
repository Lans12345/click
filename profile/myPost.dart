import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/profile/myPostApply.dart';
import 'package:dotcom/profile/myPostOffer.dart';
import 'package:dotcom/profile/myPostProduct.dart';
import 'package:dotcom/profile/myPostService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  late String firstName = '';
  late String lastName = '';
  late String contactNumber = '';
  late String gender = '';
  late String region = '';
  late String location = '';

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName')!;
      lastName = prefs.getString('lastName')!;
      contactNumber = prefs.getString('contactNumber')!;
      gender = prefs.getString('gender')!;
      region = prefs.getString('region')!;
      location = prefs.getString('location')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'My Post',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 24.0),
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelStyle: TextStyle(fontFamily: 'Quicksand', fontSize: 12.0),
            tabs: [
              Tab(text: 'Product'),
              Tab(text: 'Services'),
              Tab(text: 'Job \nSeeking'),
              Tab(text: 'Job \nOffering'),
            ],
          ),
        ),
        body: TabBarView(children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('$firstName$contactNumber')
                  .where('type', isEqualTo: 'Product')
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
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          SingleChildScrollView(
                            child: MyPostProduct(
                                accountName: firstName,
                                myContactNumber: contactNumber,
                                messengerLink: data.docs[index]
                                    ['messengerAccount'],
                                imageURL: data.docs[index]['photoLink'],
                                productName: data.docs[index]['productName'],
                                location: data.docs[index]['sellerLocation'],
                                typeOfDelivery: data.docs[index]
                                    ['modeOfDelivery'],
                                price: data.docs[index]['productPrice'],
                                paymentMethod: data.docs[index]['productOffer'],
                                productDescription: data.docs[index]
                                    ['productDescription'],
                                nameOfSeller: data.docs[index]['sellerName'],
                                contactNumberOfSeller: data.docs[index]
                                    ['sellerContactNumber'],
                                productCondition: data.docs[index]
                                    ['productCondition']),
                          ),
                        ]);
                      }),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('$firstName$contactNumber')
                  .where('type', isEqualTo: 'Service')
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
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          SingleChildScrollView(
                            child: MyPostServices(
                              accountName: firstName,
                              myContactNumber: contactNumber,
                              messengerLink: data.docs[index]
                                  ['messengerAccount'],
                              serviceName: data.docs[index]['serviceName'],
                              imageURL: data.docs[index]['imageURL'],
                              location: data.docs[index]['location'],
                              serviceHours: data.docs[index]['serviceHours'],
                              serviceOffter: data.docs[index]['serviceOffer'],
                              serviceType: data.docs[index]['serviceCategory'],
                              contactNumber: data.docs[index]['contactNumber'],
                              rateFee: data.docs[index]['serviceFee'],
                              nameOfAgent: data.docs[index]['nameOfAgent'],
                              serviceDays: data.docs[index]['serviceDays'],
                            ),
                          ),
                        ]);
                      }),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('$firstName$contactNumber')
                  .where('type', isEqualTo: 'Apply')
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
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          SingleChildScrollView(
                            child: MyPostApply(
                                accountName: firstName,
                                myContactNumber: contactNumber,
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
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('$firstName$contactNumber')
                  .where('type', isEqualTo: 'Offer')
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
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          SingleChildScrollView(
                              child: MyPostOffer(
                            accountName: firstName,
                            myContactNumber: contactNumber,
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
                );
              }),
        ]),
      ),
    );
  }
}
