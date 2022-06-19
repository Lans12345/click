import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/util/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchedServices extends StatefulWidget {
  const SearchedServices({Key? key}) : super(key: key);

  @override
  State<SearchedServices> createState() => _SearchedServicesState();
}

late String region = '';
late String accountName = '';
late String toSearchProduct = '';

class _SearchedServicesState extends State<SearchedServices> {
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
      toSearchProduct = prefs.getString('toSearchProduct')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black,
          title: const Text(
            'Services',
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Service')
                      .where('region', isEqualTo: region)
                      .where('serviceCategory', isEqualTo: toSearchProduct)
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
                                  serviceHours: data.docs[index]
                                      ['serviceHours'],
                                  serviceOffter: data.docs[index]
                                      ['serviceOffer'],
                                  serviceType: data.docs[index]
                                      ['serviceCategory'],
                                  contactNumber: data.docs[index]
                                      ['contactNumber'],
                                  rateFee: data.docs[index]['serviceFee'],
                                  nameOfAgent: data.docs[index]['nameOfAgent'],
                                  serviceDays: data.docs[index]['serviceDays'],
                                ),
                              )
                            ]);
                          }),
                    );
                  }),
            ]),
      ),
    );
  }
}
