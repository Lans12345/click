import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotcom/loadingScreens/loadingScreen2.dart';
import 'package:dotcom/logIn/createAccount.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late String userName = '';
  late String myPassword = '';
  late bool password = true;
  late String newUserName = '';

  @override
  void initState() {
    super.initState();
  }

  showToast1() {
    return Fluttertoast.showToast(
        msg: 'INVALID USERNAME!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  showToast() {
    return Fluttertoast.showToast(
        msg: 'INVALID ACCOUNT',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
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
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            color: Colors.black,
            height: 280,
            child: const Image(
                fit: BoxFit.contain,
                width: 180,
                image: AssetImage('lib/images/11.png')),
          ),
          Expanded(
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'WELCOME!',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 3.0,
                                fontSize: 32.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Sign Up and Get Started!',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.grey[700],
                                  fontSize: 15.0),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                            child: TextFormField(
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
                                labelText: 'User name',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                            child: TextFormField(
                              obscureText: password,
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: 'Quicksand'),
                              onChanged: (_myPassword) {
                                myPassword = _myPassword;
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
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                title: TextFormField(
                                                  onChanged: (_username) {
                                                    newUserName = _username;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'Enter Username',
                                                          labelStyle: TextStyle(
                                                            fontFamily:
                                                                'Quicksand',
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.grey))),
                                                ),
                                                backgroundColor:
                                                    Colors.grey[200],
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                actions: [
                                              Center(
                                                child: FlatButton(
                                                  color: Colors.white,
                                                  onPressed: () async {
                                                    final prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    if (prefs.getString(
                                                            'userName') ==
                                                        newUserName) {
                                                      String? username =
                                                          prefs.getString(
                                                              'userName');
                                                      String? password =
                                                          prefs.getString(
                                                              'password');
                                                      AwesomeDialog(
                                                        buttonsBorderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    2)),
                                                        context: context,
                                                        btnOkColor: Colors.red,
                                                        dialogType:
                                                            DialogType.SUCCES,
                                                        animType: AnimType
                                                            .BOTTOMSLIDE,
                                                        title:
                                                            'Account Details',
                                                        desc:
                                                            'Username: $username\nPassword: $password',
                                                        btnOkOnPress: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LogInPage()));
                                                        },
                                                      ).show();
                                                    } else {
                                                      showToast1();
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Continue',
                                                    style: TextStyle(
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        letterSpacing: 2.0),
                                                  ),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                ),
                                              )
                                            ]),
                                      );
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          color: Colors.black,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ]),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: FlatButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();

                                    prefs.setBool('userLoggedIn', true);
                                    bool result =
                                        await InternetConnectionChecker()
                                            .hasConnection;
                                    if (result == true) {
                                      if (userName ==
                                                  prefs.getString('userName') &&
                                              myPassword ==
                                                  prefs.getString('password') ||
                                          userName == 'testUserName123' &&
                                              myPassword == 'testPassword123') {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoadingScreen2()));
                                      } else {
                                        showToast();
                                      }
                                    } else if (result == false) {
                                      internetToast();
                                    }
                                  },
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: FlatButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    bool result =
                                        await InternetConnectionChecker()
                                            .hasConnection;

                                    if (result == true) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreateAccount()));
                                    } else if (result == false) {
                                      internetToast();
                                    }
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    ));
  }
}
