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

class PostServices extends StatefulWidget {
  const PostServices({Key? key}) : super(key: key);

  @override
  State<PostServices> createState() => _PostServicesState();
}

class _PostServicesState extends State<PostServices> {
  late String region = '';
  late String accountName = '';
  late String myContactNumber = '';

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
      myContactNumber = prefs.getString('contactNumber')!;
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
            .ref('SERVICE/$region/$serviceCategory/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('SERVICE/$region/$serviceCategory/$fileName')
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

  late String serviceName = '';
  late String location = '';
  late String serviceFee = '';
  late String _value = "";
  int currentStep = 0;
  late String contactNumber = '';
  late String name = '';
  late String serviceDays = '';
  late String serviceHours = '';
  late String messengerAccount = '';
  late String serviceCategory = 'Appliances Repair';
  int dropDownValue = 1;

  Future create() async {
    final docUser = FirebaseFirestore.instance
        .collection('$accountName$myContactNumber')
        .doc(serviceName);

    final json = {
      'serviceCategory': serviceCategory,
      'imageURL': imageURL,
      'serviceName': serviceName,
      'location': location,
      'serviceFee': serviceFee,
      'serviceOffer': _value,
      'serviceDays': serviceDays,
      'serviceHours': serviceHours,
      'nameOfAgent': name,
      'contactNumber': contactNumber,
      'messengerAccount': 'https://$messengerAccount',
      'region': region,
      'type': 'Service'
    };

    await docUser.set(json);
  }

  Future create1() async {
    final docUser = FirebaseFirestore.instance
        .collection('Service')
        .doc('Product-$serviceName-$name-$contactNumber');

    final json = {
      'serviceCategory': serviceCategory,
      'imageURL': imageURL,
      'serviceName': serviceName,
      'location': location,
      'serviceFee': serviceFee,
      'serviceOffer': _value,
      'serviceDays': serviceDays,
      'serviceHours': serviceHours,
      'nameOfAgent': name,
      'contactNumber': contactNumber,
      'messengerAccount': 'https://$messengerAccount',
      'region': region
    };

    await docUser.set(json);
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
          'Post Service',
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
              title: const Text('Service Details'),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Service Category',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 8.0,
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
                            serviceCategory = "Appliances Repair";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Appliances Repair",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Automotive Repair";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Automotive Repair",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Catering Service";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Catering Service",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Cooking and Baking";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Cooking and Baking",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Driver";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Driver",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Gadget Repair";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Gadget Repair",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Haircut and Nails";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Haircut and Nails",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 7,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Home Service";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Home Service",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 8,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Massage";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Massage",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Printing Service";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Printing Service",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 11,
                        ),
                        DropdownMenuItem(
                          onTap: () {
                            serviceCategory = "Others";
                          },
                          child: Center(
                              child: Row(children: const [
                            Text("Others",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ))
                          ])),
                          value: 12,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Landscape layout of Photo is recommended',
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          color: Colors.grey,
                          fontSize: 10.0,
                          fontFamily: 'Quicksand')),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Quicksand'),
                      onChanged: (_serviceName) {
                        serviceName = _serviceName;
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
                        labelText: 'Service Name',
                        labelStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Quicksand'),
                      onChanged: (_location) {
                        location = _location;
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
                        labelText: 'Complete Address',
                        labelStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Quicksand'),
                      onChanged: (_serviceFee) {
                        serviceFee = _serviceFee;
                      },
                      decoration: InputDecoration(
                        prefix: const Text('₱'),
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
                        labelText: 'Service Fee (ex. ₱500 per day)',
                        labelStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Shop Service',
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value.toString();
                        });
                      },
                    ),
                    const Text('Shop Service')
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: "Home Service",
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value.toString();
                        });
                      },
                    ),
                    const Text('Home Service')
                  ]),
                ],
              )),
          Step(
              title: const Text('Service Days'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Quicksand'),
                      onChanged: (_input) {
                        serviceDays = _input;
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
                        labelText: 'Service Days (ex. Monday-Saturday)',
                        labelStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Quicksand'),
                      onChanged: (_input) {
                        serviceHours = _input;
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
                        labelText: 'Service hours (ex. 9am-5pm)',
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
            title: const Text("Agent's Information"),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (_name) {
                        name = _name;
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
                      onChanged: (_contactNumber) {
                        contactNumber = _contactNumber;
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
                          borderSide:
                              const BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
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
                      title: 'Service Posted Succesfully!',
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
          if (currentStep != 4) {
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
      )),
    ));
  }
}
