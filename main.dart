import 'package:dotcom/firebase_options.dart';
import 'package:dotcom/loadingScreens/loadingScreen.dart';
import 'package:dotcom/post/selectPost.dart';
import 'package:dotcom/profile/profile.dart';
import 'package:dotcom/search/searchRegionProducts.dart';
import 'package:dotcom/searched/searchProduct.dart';
import 'package:dotcom/tabs/jobApplicants.dart';
import 'package:dotcom/tabs/jobOffers.dart';
import 'package:dotcom/tabs/services.dart';
import 'package:dotcom/util/category.dart';
import 'package:dotcom/util/products.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: LoadingScreen()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

late String region = '';
late String accountName = '';

class _MyAppState extends State<MyApp> {
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

  late String searchRegion;

  late String searchProduct;

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () async {
                    bool result =
                        await InternetConnectionChecker().hasConnection;
                    if (result == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SelectPost()));
                    } else if (result == false) {
                      internetToast();
                    }
                  },
                  child: const Icon(
                    Icons.post_add_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    print(prefs.getString('userName'));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyProfile()));
                  },
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
              ],
              backgroundColor: Colors.black,
              title: const Image(
                  fit: BoxFit.contain,
                  height: 70,
                  width: 120,
                  image: AssetImage('lib/images/text.png')),
              bottom: TabBar(
                  labelStyle:
                      const TextStyle(fontSize: 10.0, fontFamily: 'Quicksand'),
                  tabs: [
                    Tab(
                        text: 'Products',
                        icon: SizedBox(
                          height: 20,
                          child: Image.asset(
                            'lib/images/product.png',
                            color: Colors.white,
                          ),
                        )),
                    Tab(
                        text: 'Services',
                        icon: SizedBox(
                          height: 20,
                          child: Image.asset('lib/images/services.png',
                              color: Colors.white),
                        )),
                    Tab(
                        text: 'Job Seekers',
                        icon: SizedBox(
                          height: 20,
                          child: Image.asset('lib/images/findJob.png',
                              color: Colors.white),
                        )),
                    Tab(
                        text: "Who's hiring?",
                        icon: SizedBox(
                          height: 20,
                          child: Image.asset('lib/images/offerJob.png',
                              color: Colors.white),
                        ))
                  ]),
            ),
            body: TabBarView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Product Categories',
                        style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand'),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Accessories';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('categoryProduct', 'Accessories');

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Accessories',
                                image: 'lib/images/Accessories.png'),
                          ),
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Appliances';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('categoryProduct', 'Appliances');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Appliances',
                                image: 'lib/images/Appliances.png'),
                          ),
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Clothes';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('categoryProduct', 'Clothes');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Clothes',
                                image: 'lib/images/Clothes.png'),
                          ),
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Foods and Drinks';

                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'categoryProduct', 'Foods and Drinks');

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Foods and Drinks',
                                image: 'lib/images/Foods and Drinks.png'),
                          ),
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Gadgets';
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('categoryProduct', 'Gadgets');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Gadgets',
                                image: 'lib/images/Gadgets.png'),
                          ),
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Health and Personal Care';
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('categoryProduct',
                                  'Health and Personal Care');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Health and Personal Care',
                                image:
                                    'lib/images/Health and Personal Care.png'),
                          ),
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Toys and Collectibles';
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'categoryProduct', 'Toys and Collectibles');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Toys and Collectibles',
                                image: 'lib/images/Toys and Collectibles.png'),
                          ),
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Sports';
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('categoryProduct', 'Sports');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Sports',
                                image: 'lib/images/Sports.png'),
                          ),
                          InkWell(
                            onTap: () async {
                              searchProduct = 'Others';
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('categoryProduct', 'Others');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchedProduct()));
                            },
                            child: const CategoryCointainer(
                                label: 'Others',
                                image: 'lib/images/Others.png'),
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
                          'Nearby Products',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand'),
                        ),
                      ),
                      const SizedBox(width: 130),
                      InkWell(
                          onTap: () async {
                            bool result =
                                await InternetConnectionChecker().hasConnection;

                            if (result == true) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchRegionProducts()));
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
                                  child:
                                      Icon(Icons.search, color: Colors.black),
                                )),
                          ))
                    ]),
                    const SizedBox(height: 5),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Product')
                            .where('region', isEqualTo: region)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print('error');
                            return const Center(child: Text('Error'));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                        child: Products(
                                            messengerLink: data.docs[index]
                                                ['messengerAccount'],
                                            imageURL: data.docs[index]
                                                ['photoLink'],
                                            productName: data.docs[index]
                                                ['productName'],
                                            location: data.docs[index]
                                                ['sellerLocation'],
                                            typeOfDelivery: data.docs[index]
                                                ['modeOfDelivery'],
                                            price: data.docs[index]
                                                ['productPrice'],
                                            paymentMethod: data.docs[index]
                                                ['productOffer'],
                                            productDescription: data.docs[index]
                                                ['productDescription'],
                                            nameOfSeller: data.docs[index]
                                                ['sellerName'],
                                            contactNumberOfSeller:
                                                data.docs[index]
                                                    ['sellerContactNumber'],
                                            productCondition: data.docs[index]
                                                ['productCondition']),
                                      ),
                                    ]);
                                  }),
                            ),
                          );
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
                const Services(),
                const JobApplicants(),
                const JobOffers()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
