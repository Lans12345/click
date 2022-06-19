import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotcom/logIn/logIn.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    super.initState();
    getTotalUsers();
  }

  int totalUsers = 0;

  getTotalUsers() async {
    var collection = FirebaseFirestore.instance.collection('NumberOfUsers');
    var docSnapshot = await collection.doc('users').get(); // Required
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var _timesPlayed = data!['totalUsers'];

      totalUsers = _timesPlayed;
    }
  }

  showToast() {
    return Fluttertoast.showToast(
        msg: 'PASSWORD DO NOT MATCH!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  Future create() async {
    final docUser = FirebaseFirestore.instance
        .collection('USERS')
        .doc('$firstName-$lastName-$contactNumber');

    final json = {
      'firstName': firstName,
      'lastName': lastName,
      'contactNumber': contactNumber,
      'gender': _value,
      'region': region,
      'myPassword': myPassword,
      'location': location,
      'userName': userName
    };

    await docUser.set(json);
  }

  late String firstName = '';
  late String lastName = '';
  late String contactNumber = '';
  late String _value = "";
  late String region = 'Region 1';
  late String location = '';
  late String userName = '';
  late String myPassword = '';
  late String confirmPassword = '';
  int currentStep = 0;
  int dropDownValue = 1;
  bool password = true;

  internetToast() {
    return Fluttertoast.showToast(
        msg: 'No Internet Connection!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to leave without saving?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stepper(
                steps: [
                  Step(
                      title: const Text('Name'),
                      content: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'Quicksand'),
                              onChanged: (_firstName) {
                                firstName = _firstName;
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
                                labelText: 'First Name',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'Quicksand'),
                              onChanged: (_lastName) {
                                lastName = _lastName;
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
                                labelText: 'Last Name',
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
                            padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              maxLength: 11,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'Quicksand'),
                              onChanged: (_contactNumber) {
                                contactNumber = _contactNumber;
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
                              ),
                            ),
                          )
                        ],
                      )),
                  Step(
                      title: const Text('Gender'),
                      content: Column(
                        children: [
                          Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: 'Male',
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value.toString();
                                });
                              },
                            ),
                            const Text('Male')
                          ]),
                          Row(children: [
                            Radio(
                              activeColor: Colors.black,
                              value: "Female",
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value.toString();
                                });
                              },
                            ),
                            const Text('Female')
                          ]),
                        ],
                      )),
                  Step(
                      title: const Text('Location'),
                      content: Column(children: [
                        const Text('Select your Region'),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: DropdownButton(
                            iconEnabledColor: Colors.black,
                            isExpanded: true,
                            value: dropDownValue,
                            items: [
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 1";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 1",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 2";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 2",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 3";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 3",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 4";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 4",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 4,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 5";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 5",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 5,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 6";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 6",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 6,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 7";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 7",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 7,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 8";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 8",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 8,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 9";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 9",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 9,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 10";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 10",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 10,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 11";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 11",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 11,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 12";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 12",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 12,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "Region 13";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("Region 13",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 13,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  region = "NCR";
                                },
                                child: Center(
                                    child: Row(children: const [
                                  Text("NCR",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                      ))
                                ])),
                                value: 14,
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
                          padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 5,
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'Quicksand'),
                            onChanged: (_location) {
                              location = _location;
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
                              labelText: "Location (ex. Poblacion, Impasugong)",
                              labelStyle: const TextStyle(
                                fontFamily: 'Quicksand',
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        )
                      ])),
                  Step(
                      title: const Text('Account Details'),
                      content: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'Quicksand'),
                              onChanged: (_userName) {
                                userName = _userName;
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
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
                                labelText: "User Name",
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
                              obscureText: password,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'Quicksand'),
                              onChanged: (__password) {
                                myPassword = __password;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.remove_red_eye,
                                      color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      password = !password;
                                    });
                                  },
                                ),
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
                                labelText: "Password",
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
                              obscureText: password,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'Quicksand'),
                              onChanged: (_confirmPassword) {
                                confirmPassword = _confirmPassword;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.remove_red_eye,
                                      color: Colors.black),
                                  onPressed: () {
                                    setState(() {
                                      password = !password;
                                    });
                                  },
                                ),
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
                                labelText: "Confirm Password",
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
                          onPressed: () async {
                            bool result =
                                await InternetConnectionChecker().hasConnection;

                            if (result == true) {
                              if (myPassword != confirmPassword) {
                                showToast();
                              } else {
                                AwesomeDialog(
                                  showCloseIcon: true,
                                  buttonsBorderRadius: const BorderRadius.all(
                                      Radius.circular(2)),
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  btnOkColor: Colors.black,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Account Created Successfuly!',
                                  btnOkOnPress: () async {
                                    FirebaseFirestore.instance
                                        .collection('NumberOfUsers')
                                        .doc('users')
                                        .update({'totalUsers': 1 + totalUsers});
                                    create();
                                    final prefs =
                                        await SharedPreferences.getInstance();

                                    prefs.setString('firstName', firstName);
                                    prefs.setString('lastName', lastName);
                                    prefs.setString(
                                        'contactNumber', contactNumber);
                                    prefs.setString('gender', _value);
                                    prefs.setString('region', region);
                                    prefs.setString('location', location);
                                    prefs.setString('userName', userName);
                                    prefs.setString('password', myPassword);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogInPage()));
                                  },
                                ).show();
                              }
                            } else if (result == false) {
                              internetToast();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(
                              'Create',
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
                  if (currentStep != 5) {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
