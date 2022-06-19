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

class PostApply extends StatefulWidget {
  const PostApply({Key? key}) : super(key: key);

  @override
  State<PostApply> createState() => _PostApplyState();
}

class _PostApplyState extends State<PostApply> {
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
            .ref('APPLICANT/$region/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('APPLICANT/$region/$fileName')
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
        .collection('$accountName$myContactNumber')
        .doc('$name-$contactNumber');

    final json = {
      'imageURL': imageURL,
      'name': name,
      'location': location,
      'jobWanted': jobWanted,
      'contactNumber': contactNumber,
      'email': email,
      'educationAttainment': educationAttainment,
      'experience': experience,
      'messengerAccount': 'https://$messengerAccount',
      'region': region,
      'type': 'Apply'
    };

    await docUser.set(json);
  }

  Future create1() async {
    final docUser = FirebaseFirestore.instance
        .collection('Applicant')
        .doc('Applicant-$name-$jobWanted');

    final json = {
      'imageURL': imageURL,
      'name': name,
      'location': location,
      'jobWanted': jobWanted,
      'contactNumber': contactNumber,
      'email': email,
      'educationAttainment': educationAttainment,
      'experience': experience,
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

  late String name = "";
  late String location = "";
  late String jobWanted = "";
  late String email = "";
  late String contactNumber = "";
  late String experience = "";
  late String educationAttainment = "";
  int currentStep = 0;
  late String messengerAccount = '';
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
            'Post Job Application',
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
              title: const Text('Personal Information'),
              content: Column(children: [
                const Text('Provide a Formal Photo',
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
                              Text('Formal Photo',
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
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Quicksand'),
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
                      labelText: 'Full Name',
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
                      labelText: 'Home Address',
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
                title: const Text('Job Wanted'),
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'Quicksand'),
                        onChanged: (_input) {
                          jobWanted = _input;
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
                          labelText: 'Job Wanted (ex. Software Engineer)',
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
                title: const Text('Contact Details'),
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'Quicksand'),
                        onChanged: (_input) {
                          contactNumber = _input;
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
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'Quicksand'),
                        onChanged: (_input) {
                          email = _input;
                        },
                        decoration: InputDecoration(
                          prefix: const Text("@"),
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
                          labelText: "Email Address",
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
                title: const Text('Education Attainment'),
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 5,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'Quicksand'),
                        onChanged: (_input) {
                          educationAttainment = _input;
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
                          labelText:
                              "(ex. College Level - USTP - Computer Engineering)",
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
                title: const Text('Job Experience'),
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 5,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'Quicksand'),
                        onChanged: (_input) {
                          experience = _input;
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
                          labelText: "Job Experiences",
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
                        title: 'Application Posted Succesfully!',
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
            if (currentStep != 6) {
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
      ),
    );
  }
}
