import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../analysis/presentation/pages/analysis_page.dart';
import '../batter_status/presentation/pages/battery_page.dart';
import '../food_capacity/presentation/pages/food_capacity.dart';
import '../home_page/presentation/pages/home_page.dart';
import '../user/presentation/bloc/userprofile/user_profile_bloc.dart';
import '../user/presentation/pages/user_profile.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Feeding schedule",
              colorLineSelected: Color(0xff3B4CA6),
              baseStyle: TextStyle(
                color: Colors.white,
              ),
              selectedStyle: TextStyle(color: Colors.white, fontSize: 25)),
          const HomePage(
            admin: true,
          )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Food Capacity",
              colorLineSelected: Color(0xff3B4CA6),
              baseStyle: TextStyle(
                color: Colors.white,
              ),
              selectedStyle: TextStyle(color: Colors.white, fontSize: 25)),
          FoodCapacityPage(
            level: 5.3,
          )),
      // ScreenHiddenDrawer(
      //     ItemHiddenMenu(
      //         name: "Battery",
      //         colorLineSelected: Color(0xff3B4CA6),
      //         baseStyle: TextStyle(
      //           color: Colors.white,
      //         ),
      //         selectedStyle: TextStyle(color: Colors.white, fontSize: 25)),
      //     BatteryLevelIndicator(
      //       batteryLevelValue: 100,
      //     )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Report",
              colorLineSelected: Color(0xff3B4CA6),
              baseStyle: TextStyle(
                color: Colors.white,
              ),
              selectedStyle: TextStyle(color: Colors.white, fontSize: 25)),
          ReportPage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        print(state.toString());
        if (state is UserProfileInitial) {
          BlocProvider.of<UserProfileBloc>(context).add(LoadUserProfile());
          return Container();
        } else if (state is UserProfileLoaded) {
          return HiddenDrawerMenu(
              backgroundColorMenu: Color.fromARGB(255, 141, 151, 203),
              actionsAppBar: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      // context
                      //                 .read<MyBlogsBloc>()
                      //                 .add(LoadMyBlogs());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => UserProfilePage()));
                    },
                    child: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileLoaded) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFF3B4CA6),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                // backgroundColor: Colors.amber,
                                foregroundImage: Image.asset(
                                  "assets/images/profile.png",
                                  fit: BoxFit.scaleDown,
                                ).image,
                                radius: 48,
                              ),
                            ),
                          );
                        } else {
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFF3B4CA6),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
              leadingAppBar: Icon(
                Icons.menu,
                color: Color(0xFF3B4CA6),
              ),
              backgroundColorAppBar: Color(0xFFF9F9F9),
              elevationAppBar: 0,
              screens: _pages,
              initPositionSelected: 0,
              styleAutoTittleName: TextStyle(color: Colors.black));
          // : FeedsPage(admin: false);
        } else {
          return HomePage(
            admin: false,
          );
        }
      },
    );
  }
}
