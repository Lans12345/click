import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({Key? key}) : super(key: key);

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  late String region = '';
  late String accountName = '';
  late String contactNumber = '';

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
      contactNumber = prefs.getString('contactNumber')!;
    });
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late String fileName = '';
  late File imageFile;

  late String imageURL = '';

  late String uploadStatus = 'Not Uploaded';

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Text(
              '         Loading . . .',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('PRODUCT/$region/$productCategory/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('PRODUCT/$region/$productCategory/$fileName')
            .getDownloadURL();

        setState(() {
          uploadStatus = 'Uploaded Succesfully';
        });

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future create() async {
    final docUser = FirebaseFirestore.instance
        .collection('$accountName$contactNumber')
        .doc(productName);

    final json = {
      'photoLink': imageURL,
      'modeOfDelivery': _value,
      'productOffer': _value2,
      'productCategory': productCategory,
      'productName': productName,
      'productPrice': productPrice,
      'productCondition': _value3,
      'productDescription': productDescription,
      'sellerName': sellerName,
      'sellerContactNumber': sellerContactNumber,
      'sellerLocation': sellerLocation,
      'messengerAccount': 'https://$messengerAccount',
      'region': region,
      'type': 'Product'
    };

    await docUser.set(json);
  }

  Future create1() async {
    final docUser = FirebaseFirestore.instance
        .collection('Product')
        .doc('Product-$productName-$sellerName-$sellerContactNumber');

    final json = {
      'photoLink': imageURL,
      'modeOfDelivery': _value,
      'productOffer': _value2,
      'productCategory': productCategory,
      'productName': productName,
      'productPrice': productPrice,
      'productCondition': _value3,
      'productDescription': productDescription,
      'sellerName': sellerName,
      'sellerContactNumber': sellerContactNumber,
      'sellerLocation': sellerLocation,
      'messengerAccount': 'https://$messengerAccount',
      'region': region,
    };

    await docUser.set(json);
  }

  int dropDownValue = 1;
  int currentStep = 0;

  bool shipsToYou = false;
  bool meetUp = false;
  bool pickUp = false;

  late String _value = "";
  late String _value2 = "";
  late String _value3 = "";
  late String productName = "";
  late String productPrice = "";
  late String productDescription = "";
  late String sellerName = "";
  late String sellerContactNumber = "";
  late String sellerLocation = "";
  late String productCategory = 'Accesories';
  late String messengerAccount = '';

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
          backgroundColor: Colors.black,
          title: const Text(
            'Post Product',
            style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Quicksand'),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          child: Stepper(
            steps: [
              Step(
                  title: const Text('Product Details'),
                  content: Column(
                    children: [
                      const Text('Product Category',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontFamily: 'Quicksand')),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: DropdownButton(
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          value: dropDownValue,
                          items: [
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Accessories";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Accessories",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Appliances";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Appliances",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Clothes";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Clothes",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Foods and Drinks";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Foods and Drinks",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 4,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Gadgets";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Gadgets",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 5,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Health and Personal Care";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Health and \nPersonal Care",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 6,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Toys and Collectibles";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Toys and Collectibles",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 7,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Sports";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Sports",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 8,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Others";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Others",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 10,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              dropDownValue = int.parse(value.toString());
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 30,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_productName) {
                            productName = _productName;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Product Name',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_productPrice) {
                            productPrice = _productPrice;
                          },
                          decoration: InputDecoration(
                            prefix: const Text("₱"),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Product Price',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Product Condition',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontFamily: 'Quicksand')),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: Row(
                          children: [
                            Row(children: [
                              Radio(
                                activeColor: Colors.black,
                                value: 'Brand New',
                                groupValue: _value3,
                                onChanged: (value) {
                                  setState(() {
                                    _value3 = value.toString();
                                  });
                                },
                              ),
                              const Text('Brand New')
                            ]),
                            Row(children: [
                              Radio(
                                activeColor: Colors.black,
                                value: "Used",
                                groupValue: _value3,
                                onChanged: (value) {
                                  setState(() {
                                    _value3 = value.toString();
                                  });
                                },
                              ),
                              const Text('Used')
                            ]),
                          ],
                        ),
                      ),
                    ],
                  )),
              Step(
                  title: const Text('Upload Product Image'),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Portrait layout of Photo is recommended',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8.0,
                              fontFamily: 'Quicksand')),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: ClipRRect(
                          child: RaisedButton(
                              color: Colors.white,
                              onPressed: () {
                                _upload('gallery');
                              },
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text('Upload Photo',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontFamily: 'Quicksand')),
                                    Icon(
                                      Icons.add,
                                      size: 25.0,
                                      color: Colors.black,
                                    ),
                                  ])),
                        ),
                      ),
                      Text('Upload Status: $uploadStatus',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 10.0)),
                    ],
                  )),
              Step(
                  title: const Text('Product Delivery and Offer'),
                  content: Padding(
                    padding: const EdgeInsets.only(
                        right: 0, left: 0, top: 0, bottom: 0),
                    child: Row(children: [
                      Column(
                        children: [
                          const Text('Mode of Delivery',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand')),
                          Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: 'Ships to you',
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value.toString();
                                });
                              },
                            ),
                            const Text('Ships to you')
                          ]),
                          Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: "Meet Up",
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value.toString();
                                });
                              },
                            ),
                            const Text('Meet Up')
                          ]),
                          Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: "Pick Up",
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value.toString();
                                });
                              },
                            ),
                            const Text('Pick Up')
                          ])
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          const Text('Product Offer',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand')),
                          Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: 'Free Delivery',
                              groupValue: _value2,
                              onChanged: (value) {
                                setState(() {
                                  _value2 = value.toString();
                                });
                              },
                            ),
                            const Text('Free Delivery')
                          ]),
                          Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: "Discount",
                              groupValue: _value2,
                              onChanged: (value) {
                                setState(() {
                                  _value2 = value.toString();
                                });
                              },
                            ),
                            const Text('Discount')
                          ]),
                          Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: "No Offer",
                              groupValue: _value2,
                              onChanged: (value) {
                                setState(() {
                                  _value2 = value.toString();
                                });
                              },
                            ),
                            const Text('No Offer')
                          ])
                        ],
                      ),
                    ]),
                  )),
              Step(
                title: const Text('Product Description'),
                content: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 100,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (_productDescription) {
                      productDescription = _productDescription;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Product Description',
                      labelStyle: const TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text("Seller's Information"),
                content: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_sellerName) {
                            sellerName = _sellerName;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: "Name",
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_sellerContactNumber) {
                            sellerContactNumber = _sellerContactNumber;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Contact Number',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_sellerLocation) {
                            sellerLocation = _sellerLocation;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: "Location",
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Step(
                  title: const Text('Facebook Messenger'),
                  content: Column(
                    children: [
                      const Text(
                        'Step 1. Open "FACEBOOK MESSENGER App".',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: 'Quicksand'),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Step 2. Click your Profile Picture.',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: 'Quicksand'),
                      ),
                      const SizedBox(height: 5),
                      const Image(
                        width: 200,
                        image: AssetImage('lib/images/Slide1.JPG'),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Step 3. Click "Username".',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: 'Quicksand'),
                      ),
                      const SizedBox(height: 5),
                      const Image(
                        width: 200,
                        image: AssetImage('lib/images/Slide2.JPG'),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Step 4. Click "Copy link.',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: 'Quicksand'),
                      ),
                      const SizedBox(height: 5),
                      const Image(
                        width: 200,
                        image: AssetImage('lib/images/Slide3.JPG'),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Step 5. Paste the link below.',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: 'Quicksand'),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_input) {
                            messengerAccount = _input;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: "Messenger Link",
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Step(
                  title: const Text('Finish'),
                  content: RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        AwesomeDialog(
                          buttonsBorderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                          context: context,
                          btnOkColor: Colors.black,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Product Posted Succesfully!',
                          btnOkOnPress: () async {
                            bool result =
                                await InternetConnectionChecker().hasConnection;
                            if (result == true) {
                              create();
                              create1();
                              setState(() {
                                uploadStatus = 'Not Uploaded';
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MyApp()));
                            } else if (result == false) {
                              internetToast();
                            }
                          },
                        ).show();
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          'POST',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontFamily: 'Quicksand'),
                        ),
                      )))
            ],
            onStepTapped: (int newIndex) {
              setState(() {
                currentStep = newIndex;
              });
            },
            currentStep: currentStep,
            onStepContinue: () {
              print(_value);
              print(_value2);
              print(productCategory);
              print(messengerAccount);
              if (currentStep != 7) {
                setState(() {
                  currentStep++;
                });
              }
            },
            onStepCancel: () {
              if (currentStep != 0) {
                setState(() {
                  currentStep--;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
