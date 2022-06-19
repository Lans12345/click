import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/util/applicants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchedApplicants extends StatefulWidget {
  const SearchedApplicants({Key? key}) : super(key: key);

  @override
  State<SearchedApplicants> createState() => _SearchedApplicantsState();
}

late String region = '';
late String accountName = '';
late String toSearchProduct = '';
late String toSearchRegion = '';

class _SearchedApplicantsState extends State<SearchedApplicants> {
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
      toSearchProduct = prefs.getString('categoryProductFromSearchIcon')!;
      toSearchRegion = prefs.getString('regionProductFromSearchIcon')!;
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
            'Job Applicants',
            style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Quicksand'),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Applicant')
                .where('region', isEqualTo: toSearchRegion)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.size ?? 0,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      SingleChildScrollView(
                        child: ApplicantsContainer(
                            messengerLink: data.docs[index]['messengerAccount'],
                            imageURL: data.docs[index]['imageURL'],
                            location: data.docs[index]['location'],
                            name: data.docs[index]['name'],
                            email: data.docs[index]['email'],
                            jobExperience: data.docs[index]['experience'],
                            educationalAttainment: data.docs[index]
                                ['educationAttainment'],
                            contactNumber: data.docs[index]['contactNumber'],
                            jobWanted: data.docs[index]['jobWanted']),
                      ),
                    ]);
                  });
            }),
      ),
    );
  }
}
