import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotcom/logIn/logIn.dart';
import 'package:dotcom/profile/myPost.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  late String firstName = '';
  late String lastName = '';
  late String contactNumber = '';
  late String gender = '';
  late String region = '';
  late String location = '';

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName')!;
      lastName = prefs.getString('lastName')!;
      contactNumber = prefs.getString('contactNumber')!;
      gender = prefs.getString('gender')!;
      region = prefs.getString('region')!;
      location = prefs.getString('location')!;
    });
  }

  Widget myGender() {
    if (gender == 'Male') {
      return const Image(
        height: 100,
        width: 100,
        image: AssetImage('lib/images/male.png'),
      );
    } else {
      return const Image(
          height: 100, width: 100, image: AssetImage('lib/images/female.png'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'My Profile',
            style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Quicksand'),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                myGender(),
                const SizedBox(height: 10),
                Text(firstName + " " + lastName,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Quicksand',
                        fontSize: 24.0)),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        color: Colors.white,
                        child: ExpansionTile(
                          leading: const Icon(Icons.phone, color: Colors.black),
                          title: const Text(
                            'Contact Number',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontSize: 18.0,
                            ),
                          ),
                          children: [
                            ListTile(
                              title: Text(
                                contactNumber,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand',
                                  fontSize: 24.0,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        color: Colors.white,
                        child: ExpansionTile(
                          leading: const Icon(Icons.location_on_rounded,
                              color: Colors.black),
                          title: const Text(
                            'Location',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontSize: 18.0,
                            ),
                          ),
                          children: [
                            ListTile(
                              title: Text(
                                "Region: $region",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand',
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Address: $location",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand',
                                  fontSize: 18.0,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyPost()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Text(
                        "My Post",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      AwesomeDialog(
                        buttonsBorderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        context: context,
                        btnOkColor: Colors.red,
                        btnCancelColor: Colors.red,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Are you sure you\n want to log out?',
                        desc: '',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('userLoggedIn', false);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LogInPage()));
                        },
                      ).show();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
