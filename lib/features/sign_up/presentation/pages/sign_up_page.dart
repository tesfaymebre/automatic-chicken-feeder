import 'dart:convert';

import 'package:chicken_feeder/core/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/validators/input_validators.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../bloc/sign_up_bloc.dart';
import '../widgets/build_text.dart';
import '../widgets/qr_scanner.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/tap_to_login.dart';

class ScreenSignup extends StatefulWidget {
  @override
  _ScreenSignupState createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmedPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController deviceId = TextEditingController();
  TextEditingController woreda = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController houseNumber = TextEditingController();

  String cityselected = 'Addis Ababa';
  final List<String> city = ["Addis Ababa"];
  final List<String> subCity = [
    'Arada',
    'Addis Ketema',
    'Lideta',
    'Kolfe keranio',
    'Gullele',
    'Bole',
    'Yeka',
    'Akaki Kality',
    'Nifas Silk',
    'Lami Kura',
    'Kirkos',
  ];
  String selectedSubcity = 'Arada';
  int activeIdx = 0;
  int totalIdx = 3;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          showSnackBar(context, 'User Created Successfully');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state is SignUpFailure) {
          showSnackBar(context, ' Create account Error occured! try again.');
        }
      },
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (activeIdx != 0) {
              activeIdx--;
              setState(() {});
              return false;
            }
            return true;
          },
          child: Scaffold(
            backgroundColor: Color(0xFFF3F4F9),
            body: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: fullScreenWidth(context) * 0.08,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          bodyBuilder(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyBuilder() {
    switch (activeIdx) {
      case 0:
        return firstPage();

      case 1:
        return secondPage();
    }
    return Container();
  }

  Widget firstPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
          child: TextFormField(
            controller: email,
            validator: (value) {
              var emailValidate = Validators.validateEmail(value);
              if (emailValidate != null) {
                return emailValidate;
              }
              return null;
            },
            cursorColor: Color(0xFF3B4CA6),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              border: InputBorder.none,
              fillColor: Colors.white,
              hintText: "Email",
            ),
          ),
        ),
        // Device ID Input Field
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: deviceId,
                  cursorColor: Color(0xFF3B4CA6),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Device ID',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.qr_code_scanner),
                onPressed: () async {
                  String scannedDeviceId = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRScanner()),
                  );
                  if (scannedDeviceId != null) {
                    setState(() {
                      deviceId.text = scannedDeviceId;
                    });
                  }
                },
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
          child: TextFormField(
            controller: password,
            validator: ((value) {
              var validatePassword = Validators.validatePassword(value);
              if (validatePassword != null) {
                return validatePassword;
              }
              return null;
            }),
            cursorColor: Color(0xFF3B4CA6),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Password',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
          child: TextFormField(
            controller: confirmedPassword,
            validator: ((value) {
              if (value != password.text) {
                return 'Passwords do not match';
              }
              return null;
            }),
            cursorColor: Color(0xFF3B4CA6),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Confirm Password',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: fullScreenHeight(context) * 0.03),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("processing data"),
                  ),
                );
                activeIdx++;
                setState(() {});
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minimumSize: Size(500, 48),
                primary: const Color(0XFF64549C)),
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        buildTaptoLogin(context),
      ],
    );
  }

  Widget secondPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
            child: TextFormField(
              controller: fullName,
              validator: ((value) {
                var validateName = Validators.validateName(value, 'Full Name');
                if (validateName != null) {
                  return validateName;
                }
                return null;
              }),
              cursorColor: Color(0xFF3B4CA6),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Full Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
            child: TextFormField(
              controller: phone,
              validator: ((value) {
                var validateName = Validators.validatePhone(value);
                if (validateName != null) {
                  return validateName;
                }
                return null;
              }),
              cursorColor: Color(0xFF3B4CA6),
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Phone',
              ),
            ),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    value: cityselected,
                    icon: const Icon(Icons.expand_more_outlined),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        cityselected = value!;
                      });
                    },
                    items: ['Addis Ababa']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  // dropDown(city, initialValue: city[0]),
                ],
              ),
              SizedBox(
                width: fullScreenWidth(context) * 0.12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    value: selectedSubcity,
                    icon: const Icon(Icons.expand_more_outlined),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedSubcity = value!;
                      });
                    },
                    items:
                        subCity.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
            child: TextFormField(
              controller: woreda,
              validator: ((value) {
                var validateName = Validators.validateName(value, 'Woreda');
                if (validateName != null) {
                  return validateName;
                }
                return null;
              }),
              cursorColor: Color(0xFF3B4CA6),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Woreda',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
            child: TextFormField(
              controller: street,
              validator: ((value) {
                var validateName = Validators.validateName(value, 'Street');
                if (validateName != null) {
                  return validateName;
                }
                return null;
              }),
              cursorColor: Color(0xFF3B4CA6),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Street',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 5, right: 3),
            child: TextFormField(
              controller: houseNumber,
              validator: ((value) {
                var validateName =
                    Validators.validateName(value, 'House Number');
                if (validateName != null) {
                  return validateName;
                }
                return null;
              }),
              cursorColor: Color(0xFF3B4CA6),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'House Number',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Timestamp mytime = Timestamp.fromDate()
                  // final Map<String, dynamic> signupData = {
                  //   "firstName": full_name.text,
                  //   "middleName": middlename.text,
                  //   "lastName": lastname.text,
                  //   "DoB": '01/03/2011',
                  //   "gender": select,
                  //   'password': '12345678',
                  //   "email": email.text,
                  //   "address": {
                  //     "city": "Addis Ababa",
                  //     "subCity": selectedSubcity,
                  //     "phone": phone.text,
                  //     "woreda": woreda.text,
                  //   },
                  // };

                  BlocProvider.of<SignUpBloc>(context).add(CreateUserEvent(
                      email: email.text,
                      device_id: deviceId.text,
                      password: password.text,
                      full_name: fullName.text,
                      phoneNumber: phone.text,
                      city: cityselected,
                      subCity: selectedSubcity,
                      woreda: woreda.text,
                      street: street.text,
                      houseNo: houseNumber.text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("processing data"),
                    ),
                  );
                }
              },
              child: Text(
                "Create Account",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: Size(500, 48),
                  primary: Color(0XFF64549C)),
            ),
          )
        ],
      ),
    );
  }
}
