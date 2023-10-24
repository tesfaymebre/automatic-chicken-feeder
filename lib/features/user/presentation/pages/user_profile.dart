import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/constants.dart';
import '../../../../core/validators/input_validators.dart';
import '../../../../main.dart';
import '../../../login/presentation/bloc/auth/authentication_bloc.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../bloc/userprofile/user_profile_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool readValue = true;

    TextEditingController titleController = new TextEditingController();
    TextEditingController nameController = new TextEditingController();
    TextEditingController positionController = new TextEditingController();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.chevron_left),
            ),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                      ..add(LoggedOut());
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => SplashScreen()),
                        (route) => false);
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          backgroundColor: Color.fromARGB(255, 244, 246, 246),
          body: Container(
            height: fullScreenHeight(context) * 0.8,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  child: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                    if (state is UserProfileInitial ||
                        state is UserProfileEditedSuccess ||
                        state is UserProfileInitial) {
                      BlocProvider.of<UserProfileBloc>(context)
                        ..add(LoadUserProfile());
                    }

                    if (state is UserProfileLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is UserProfileLoaded) {
                      print(state.userModel);
                      TextEditingController nameController =
                          TextEditingController(text: state.userModel.fullName);

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context) * 25),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: height * 0.035,
                                            backgroundColor: Colors.transparent,
                                            child: CircleAvatar(
                                              backgroundImage: Image.asset(
                                                      "assets/images/profile.png")
                                                  .image,
                                              radius: height * 0.035,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.03),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${state.userModel.fullName}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 30)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xFF3B4CA6)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)))),
                                          onPressed: () {
                                            readValue = false;

                                            showAddTestimonial(
                                                context, state, _formKey);

                                            setState(() {});
                                            context
                                                .read<UserProfileBloc>()
                                                .add(EditUserProfile());
                                          },
                                          child: Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is UserProfileEditing) {
                      return Scaffold(
                        body: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: height * 0.035,
                                            backgroundColor: Colors.transparent,
                                            child: CircleAvatar(
                                              backgroundImage: Image.asset(
                                                      "assets/images/profile.png")
                                                  .image,
                                              radius: height * 0.035,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.03),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${state.userModel.fullName}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 30)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xFF3B4CA6)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)))),
                                          onPressed: () {
                                            readValue = false;

                                            showAddTestimonial(
                                                context, state, _formKey);

                                            setState(() {});
                                            context
                                                .read<UserProfileBloc>()
                                                .add(EditUserProfile());
                                          },
                                          child: Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is AuthenticationUnauthenticated) {
                      return LoginScreen();
                    } else {
                      return Container(
                        child: Text("else state"),
                      );
                    }
                  }),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(
                //           left: screenWidth(context) * 25, top: 20),
                //       child: Text("My blogs",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold, fontSize: 16)),
                //     ),
                //     SizedBox(
                //       height: screenHeight(context) * 15,
                //     ),
                //     Container(
                //       child: BlocBuilder<MyBlogsBloc, MyBlogsState>(
                //           builder: (context, state) {
                //         if (state is MyBlogsLoaded) {
                //           return state.blogData.length > 0
                //               ? userFeeding(context, state)
                //               : Container(
                //                   height: fullScreenHeight(context) * 0.25,
                //                   child: Center(
                //                       child: Text(
                //                     "No Blogs Added",
                //                     style: TextStyle(fontSize: 18),
                //                   )),
                //                 );
                //         } else {
                //           return Center(
                //               child: Text(
                //             "No Blogs Added",
                //             style: TextStyle(fontSize: 20),
                //           ));
                //         }
                //       }),
                //     )
                //   ],
                // ),
              ]),
            ),
          )),
    );
  }

  _showPopupMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
      items: [
        PopupMenuItem<String>(
            child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                        ..add(LoggedOut());
                    },
                    child: Text("   Logout ")))),
      ],
      elevation: 8.0,
    );
  }

  void showAddTestimonial(BuildContext context, state, formKey) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TextEditingController titleController =
    //     new TextEditingController(text: state.userModel.role);
    TextEditingController nameController =
        new TextEditingController(text: state.userModel.fullName);
    // TextEditingController MiddleNameController =
    //     new TextEditingController(text: state.userModel.middleName);
    showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: formKey,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                Row(
                  children: const [
                    Text(
                      "Personal Information",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  readOnly: false,
                  controller: nameController,
                  decoration: kTextFieldDecoration(context).copyWith(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: '',
                  ),
                  validator: (value) {
                    var val = Validators.validateName(value, "Full name");
                    if (val != null) {
                      return val;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                // TextFormField(
                //   readOnly: false,
                //   controller: MiddleNameController,
                //   decoration: kTextFieldDecoration(context).copyWith(
                //     prefixIcon: Icon(Icons.email_outlined),
                //     hintText: '',
                //   ),
                //   validator: (value) {
                //     var val = Validators.validateName(value, "middle name");
                //     if (val != null) {
                //       return val;
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(
                //   height: height * 0.01,
                // ),
                // TextFormField(
                //   readOnly: false,
                //   controller: titleController,
                //   decoration: kTextFieldDecoration(context).copyWith(
                //     prefixIcon: Icon(Icons.email_outlined),
                //     hintText: '',
                //   ),
                //   validator: (value) {
                //     var val = Validators.validateTitle(value);
                //     if (val != null) {
                //       return val;
                //     }
                //     return null;
                //   },
                // ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final changes = <String, String>{
                          "fullName": nameController.text,
                          // "role": titleController.text,
                          // "middleName": MiddleNameController.text,
                        };
                        context.read<UserProfileBloc>()
                          ..add(UpdateUserProfile(changes: changes));

                        BlocProvider.of<UserProfileBloc>(context)
                          ..add(LoadUserProfile());

                        context.read<UserProfileBloc>()..add(LoadUserProfile());

                        setState(() {});

                        Navigator.pop(context);
                      }
                    },
                    child: Center(child: Text("Change Profile")))
              ],
            ),
          );
        });
  }
}
