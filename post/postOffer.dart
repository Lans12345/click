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

class PostOffer extends StatefulWidget {
  const PostOffer({Key? key}) : super(key: key);

  @override
  State<PostOffer> createState() => _PostOfferState();
}

class _PostOfferState extends State<PostOffer> {
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
            .ref('OFFER/$region/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('OFFER/$region/$fileName')
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
        .doc(companyName);

    final json = {
      'imageURL': imageURL,
      'companyName': companyName,
      'companyLocation': companyLocation,
      'jobOffer': jobOffer,
      'jobRequirements': jobRequirements,
      'jobHour': _value,
      'salary': salary,
      'name': name,
      'contactNumber': contactNumber,
      'email': email,
      'jobOfAgent': jobOfAgent,
      'region': region,
      'type': 'Offer'
    };

    await docUser.set(json);
  }

  Future create1() async {
    final docUser = FirebaseFirestore.instance
        .collection('Offer')
        .doc('Offer-$companyName-$jobOffer');

    final json = {
      'imageURL': imageURL,
      'companyName': companyName,
      'companyLocation': companyLocation,
      'jobOffer': jobOffer,
      'jobRequirements': jobRequirements,
      'jobHour': _value,
      'salary': salary,
      'name': name,
      'contactNumber': contactNumber,
      'email': email,
      'jobOfAgent': jobOfAgent,
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

  late String companyName = "";
  late String jobOffer = "";
  late String companyLocation = "";
  late String name = "";
  late String contactNumber = "";
  late String email = "";
  late String jobRequirements = "";
  int currentStep = 0;
  late String _value = "";
  late String salary = '';
  late String jobOfAgent = '';
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
            'Post Job Offer',
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
                  title: const Text("Company Details"),
                  content: Column(
                    children: [
                      const Text('In PNG format',
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
                                    Text('Company Logo',
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
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'Quicksand'),
                          onChanged: (_input) {
                            companyName = _input;
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
                            labelText: "Name of the Company",
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
                            companyLocation = _input;
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
                            labelText: "Address (ex. Impasugong, Bukidnon)",
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
                  title: const Text('Job Details'),
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'Quicksand'),
                          onChanged: (_input) {
                            jobOffer = _input;
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
                            labelText: "Job Offered (ex. Graphic Designer)",
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
                          maxLines: 5,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'Quicksand'),
                          onChanged: (_input) {
                            jobRequirements = _input;
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
                            labelText: "Job Requirements",
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
                          value: 'Part Time',
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value.toString();
                            });
                          },
                        ),
                        const Text('Part Time')
                      ]),
                      Row(children: [
                        Radio(
                          activeColor: Colors.black,
                          value: "Full Time",
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value.toString();
                            });
                          },
                        ),
                        const Text('Full Time')
                      ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'Quicksand'),
                          onChanged: (_input) {
                            salary = _input;
                          },
                          decoration: InputDecoration(
                            prefix: const Text('₱'),
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
                            labelText: "Estimated Salary (ex.25-30k per month)",
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'Quicksand'),
                          onChanged: (_input) {
                            name = _input;
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
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
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: "Contact Number",
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
                            prefix: const Text('@'),
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
                            labelText: "Email Address",
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                              color: Colors.black, fontFamily: 'Quicksand'),
                          onChanged: (_input) {
                            jobOfAgent = _input;
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
                            labelText: "Job Position",
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
                          title: 'Offer Posted Succesfully!',
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
              if (currentStep != 3) {
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
