import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/util/products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchedProductInSearchIcon extends StatefulWidget {
  const SearchedProductInSearchIcon({Key? key}) : super(key: key);

  @override
  State<SearchedProductInSearchIcon> createState() =>
      _SearchedProductInSearchIconState();
}

late String region = '';
late String accountName = '';
late String toSearchProduct = '';
late String toSearchRegion = '';

class _SearchedProductInSearchIconState
    extends State<SearchedProductInSearchIcon> {
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
            'Products',
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
                      .collection('Product')
                      .where('region', isEqualTo: toSearchRegion)
                      .where('productCategory', isEqualTo: toSearchProduct)
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
                                child: Products(
                                    messengerLink: data.docs[index]
                                        ['messengerAccount'],
                                    imageURL: data.docs[index]['photoLink'],
                                    productName: data.docs[index]
                                        ['productName'],
                                    location: data.docs[index]
                                        ['sellerLocation'],
                                    typeOfDelivery: data.docs[index]
                                        ['modeOfDelivery'],
                                    price: data.docs[index]['productPrice'],
                                    paymentMethod: data.docs[index]
                                        ['productOffer'],
                                    productDescription: data.docs[index]
                                        ['productDescription'],
                                    nameOfSeller: data.docs[index]
                                        ['sellerName'],
                                    contactNumberOfSeller: data.docs[index]
                                        ['sellerContactNumber'],
                                    productCondition: data.docs[index]
                                        ['productCondition']),
                              ),
                            ]);
                          }),
                    );
                  }),
            ]),
      ),
    );
  }
}
