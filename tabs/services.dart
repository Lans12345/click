import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/search/searchRegionServices.dart';
import 'package:dotcom/searched/searchedServices.dart';
import 'package:dotcom/util/category.dart';
import 'package:dotcom/util/services.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

late String region = '';
late String accountName = '';

class _ServicesState extends State<Services> {
  late String searchService;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Service Categories',
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () async {
                    searchService = 'Appliances Repair';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Appliances Repair');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Appliances Repair',
                      image: 'lib/images/Appliances Repair.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Automotive Repair';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Automotive Repair');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Automotive Repair',
                      image: 'lib/images/Automotive Repair.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Catering';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Catering');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Catering Service',
                      image: 'lib/images/Catering Services.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Cooking and Baking';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Cooking and Baking');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Cooking and Baking',
                      image: 'lib/images/Bake and Cook.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Driver';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Driver');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Driver', image: 'lib/images/Driver.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Gadget Repair';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Gadget Repair');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Gadget Repair',
                      image: 'lib/images/Gadget Repair.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Haircut and Nails';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Haircut and Nails');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Haircut and Nails',
                      image: 'lib/images/Haircut and Nails.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Household Chores';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Home Service');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Home Service',
                      image: 'lib/images/Household Chores.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Spa and Massage';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Massage');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Massage', image: 'lib/images/Massage.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Printing Service';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Printing Service');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Printing Service',
                      image: 'lib/images/Printing Services.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Others';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('toSearchProduct', 'Others');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchedServices()));
                  },
                  child: const CategoryCointainer(
                      label: 'Others', image: 'lib/images/Others.png'),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              height: 20,
              thickness: 2,
              color: Colors.white,
            ),
          ),
          Row(children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Nearby Services',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            const SizedBox(width: 130),
            InkWell(
                onTap: () async {
                  bool result = await InternetConnectionChecker().hasConnection;

                  if (result == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchRegionServices()));
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
          const SizedBox(height: 5),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Service')
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
                    height: 270,
                    child: ListView.builder(
                        itemCount: snapshot.data?.size ?? 0,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            SingleChildScrollView(
                              child: ServicesOffer(
                                messengerLink: data.docs[index]
                                    ['messengerAccount'],
                                serviceName: data.docs[index]['serviceName'],
                                imageURL: data.docs[index]['imageURL'],
                                location: data.docs[index]['location'],
                                serviceHours: data.docs[index]['serviceHours'],
                                serviceOffter: data.docs[index]['serviceOffer'],
                                serviceType: data.docs[index]
                                    ['serviceCategory'],
                                contactNumber: data.docs[index]
                                    ['contactNumber'],
                                rateFee: data.docs[index]['serviceFee'],
                                nameOfAgent: data.docs[index]['nameOfAgent'],
                                serviceDays: data.docs[index]['serviceDays'],
                              ),
                            ),
                          ]);
                        }),
                  ),
                );
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
