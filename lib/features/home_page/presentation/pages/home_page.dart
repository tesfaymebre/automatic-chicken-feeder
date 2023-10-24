import 'package:chicken_feeder/core/shared/text_style.dart';
import 'package:chicken_feeder/features/home_page/presentation/pages/add_feeding_schedule.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../user/presentation/bloc/userprofile/user_profile_bloc.dart';
import '../../../user/presentation/pages/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/all_feeding_data_entity.dart';
import '../bloc/feeding_schedule_bloc.dart';
import '../widgets/shimmer_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.admin});
  final bool admin;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This widget is the root of your application.
  DateTime _selectedDate = DateTime.now();
  List<AllFeedingDataEntity> selectedFeedingData = [];
  List<AllFeedingDataEntity> allFeedingData = [];
  String _selectedOption = 'once';
  bool isInitialLoad = true; // Track initial load

  Future<void> getAllFeedingData(context) async {
    BlocProvider.of<FeedingScheduleBloc>(context).add(GetAllFeedingDataEvent());
  }

  Future<void> _refreshHomePage() async {
    await getAllFeedingData(context);
  }

  void filterFeedingData(
      DateTime selectedDate, List<AllFeedingDataEntity> allFeedingData) {
    selectedFeedingData = allFeedingData
        .where((data) =>
            (DateFormat('yyyy-MM-dd')
                    .format(data.startDate)
                    .compareTo(DateFormat('yyyy-MM-dd').format(selectedDate)) <=
                0) &&
            (DateFormat('yyyy-MM-dd')
                    .format(selectedDate)
                    .compareTo(DateFormat('yyyy-MM-dd').format(data.endDate)) <=
                0))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    getAllFeedingData(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        appBar: widget.admin
            ? AppBar(
                toolbarHeight: 0,
              )
            : AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Feeds",
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        // context.read<UserProfileBloc>().add(LoadUserProfile());
                        // context.read<MyBlogsBloc>().add(LoadMyBlogs());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UserProfilePage()));
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
              ),
        body: BlocBuilder<FeedingScheduleBloc, FeedingScheduleState>(
            builder: (context, state) {
          if (state is GetAllFeedingDataSuccess) {
            allFeedingData = state.allFeedingDataEntity;
            filterFeedingData(_selectedDate, allFeedingData);
          } else if (state is GetAllFeedingDataLoading) {
            // Display a shimmer effect while the data is loading
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemBuilder: (_, __) => const ShimmerCard(),
                itemCount: 5, // Or any other number of items to show
              ),
            );
          }

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: subHeadingStyle,
                        ),
                        Text(
                          "Today",
                          style: HeadingStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: DatePicker(
                  DateTime.now(),
                  height: 80,
                  width: 50,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Color(0xFF3B4CA6),
                  selectedTextColor: Colors.white,
                  onDateChange: ((selectedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                      filterFeedingData(_selectedDate, allFeedingData);
                    });
                  }),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshHomePage,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      color: Colors.grey[50],
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: selectedFeedingData.length,
                        itemBuilder: (context, index) {
                          final feedingData = selectedFeedingData[index];
                          // Build your list item widget using feedingData
                          // For example:
                          return Card(
                            color: Colors.blue,
                            elevation: 1,
                            child: ListTile(
                              // title: Text('time: ${feedingData.startDate}'),
                              // subtitle: Text('User: ${feedingData.chickens}'),
                              title: Text('Lunch'),
                              textColor: Colors.white,
                              subtitle: Text(
                                  'total of ${feedingData.amount * feedingData.chickens}grams/chicken'),
                              leading: Icon(Icons.food_bank_outlined),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                              contentPadding: EdgeInsets.all(20),
                              iconColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Expanded(child: Text('Lunch')),
                                          IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CardDetail(
                                              title: "Food weight",
                                              value:
                                                  '${feedingData.amount} grams/chicken'),
                                          CardDetail(
                                              title: "Number of chickens",
                                              value: '${feedingData.chickens}'),
                                          CardDetail(
                                              title: "Date",
                                              value:
                                                  '${DateFormat('EEEE, MMM d yyyy').format(_selectedDate)}'),
                                          CardDetail(
                                              title: "Specific time",
                                              value:
                                                  '${DateFormat('hh:mm a').format(feedingData.startDate)}'),
                                          CardDetail(
                                              title: "Repeats",
                                              value:
                                                  '${feedingData.recurrence}'),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AddFeedingSchedule(
                                                    edit: true,
                                                    previousDate:
                                                        feedingData.startDate,
                                                    startDate:
                                                        feedingData.startDate,
                                                    endDate:
                                                        feedingData.endDate,
                                                    amount: feedingData.amount,
                                                    chickens:
                                                        feedingData.chickens,
                                                    recurrence:
                                                        feedingData.recurrence,
                                                    selectedDate: _selectedDate,
                                                  );
                                                });
                                            // Perform edit action
                                            // Add your edit logic here
                                            // Navigator.of(context).pop();
                                          },
                                          child: Text('Edit'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (feedingData.recurrence ==
                                                'once') {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        elevation: 1,
                                                        title: Text('Confirm'),
                                                        content: Text(
                                                            "Delete this schedule?"),
                                                        actions: [
                                                          TextButton(
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF3B4CA6)),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                            },
                                                          ),
                                                          TextButton(
                                                            child:
                                                                Text("Delete"),
                                                            onPressed: () {
                                                              BlocProvider.of<
                                                                          FeedingScheduleBloc>(
                                                                      context)
                                                                  .add(DeleteFeedingScheduleEvent(
                                                                      startDate:
                                                                          feedingData
                                                                              .startDate));
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                              BlocProvider.of<
                                                                          FeedingScheduleBloc>(
                                                                      context)
                                                                  .add(
                                                                      GetAllFeedingDataEvent());
                                                            },
                                                          )
                                                        ]);
                                                  });
                                            } else if (feedingData.recurrence ==
                                                'daily') {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState) {
                                                      return AlertDialog(
                                                          elevation: 1,
                                                          title: Text(
                                                              'Delete recurring schedule'),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              ListTile(
                                                                leading: Radio<
                                                                    String>(
                                                                  value: 'once',
                                                                  groupValue:
                                                                      _selectedOption,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _selectedOption =
                                                                          value!;
                                                                    });
                                                                  },
                                                                ),
                                                                title: Text(
                                                                    'Only this schedule'),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _selectedOption =
                                                                        'once';
                                                                  });
                                                                },
                                                              ),
                                                              ListTile(
                                                                leading: Radio<
                                                                    String>(
                                                                  value:
                                                                      'daily',
                                                                  groupValue:
                                                                      _selectedOption,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _selectedOption =
                                                                          value!;
                                                                    });
                                                                  },
                                                                ),
                                                                title: Text(
                                                                    'This and following schedules'),
                                                                onTap: () {
                                                                  setState(() {
                                                                    _selectedOption =
                                                                        'daily';
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF3B4CA6)),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text(
                                                                  "Delete"),
                                                              onPressed: () {
                                                                if (_selectedOption ==
                                                                    'once') {
                                                                  DateTime endDate = DateTime(
                                                                      _selectedDate
                                                                          .year,
                                                                      _selectedDate
                                                                          .month,
                                                                      _selectedDate
                                                                              .day -
                                                                          1,
                                                                      feedingData
                                                                          .startDate
                                                                          .hour,
                                                                      feedingData
                                                                          .startDate
                                                                          .minute);
                                                                  context.read<FeedingScheduleBloc>().add(UpdateFeedingScheduleEvent(
                                                                      previousDate:
                                                                          feedingData
                                                                              .startDate,
                                                                      startDate:
                                                                          feedingData
                                                                              .startDate,
                                                                      endDate:
                                                                          endDate,
                                                                      amount: feedingData
                                                                          .amount,
                                                                      chickens:
                                                                          feedingData
                                                                              .chickens,
                                                                      recurrence:
                                                                          feedingData
                                                                              .recurrence));

                                                                  DateTime startDate = DateTime(
                                                                      _selectedDate
                                                                          .year,
                                                                      _selectedDate
                                                                          .month,
                                                                      _selectedDate
                                                                              .day +
                                                                          1,
                                                                      feedingData
                                                                          .startDate
                                                                          .hour,
                                                                      feedingData
                                                                          .startDate
                                                                          .minute);

                                                                  endDate = DateTime(
                                                                      startDate
                                                                              .year +
                                                                          100,
                                                                      startDate
                                                                          .month,
                                                                      startDate
                                                                          .day,
                                                                      startDate
                                                                          .hour,
                                                                      startDate
                                                                          .minute);

                                                                  context.read<FeedingScheduleBloc>().add(CreateFeedingScheduleEvent(
                                                                      startDate:
                                                                          startDate,
                                                                      endDate:
                                                                          endDate,
                                                                      amount: feedingData
                                                                          .amount,
                                                                      chickens:
                                                                          feedingData
                                                                              .chickens,
                                                                      recurrence:
                                                                          feedingData
                                                                              .recurrence));
                                                                } else if (_selectedOption ==
                                                                    "daily") {
                                                                  DateTime endDate = DateTime(
                                                                      _selectedDate
                                                                          .year,
                                                                      _selectedDate
                                                                          .month,
                                                                      _selectedDate
                                                                              .day -
                                                                          1,
                                                                      feedingData
                                                                          .startDate
                                                                          .hour,
                                                                      feedingData
                                                                          .startDate
                                                                          .minute);
                                                                  context.read<FeedingScheduleBloc>().add(UpdateFeedingScheduleEvent(
                                                                      previousDate:
                                                                          feedingData
                                                                              .startDate,
                                                                      startDate:
                                                                          feedingData
                                                                              .startDate,
                                                                      endDate:
                                                                          endDate,
                                                                      amount: feedingData
                                                                          .amount,
                                                                      chickens:
                                                                          feedingData
                                                                              .chickens,
                                                                      recurrence:
                                                                          feedingData
                                                                              .recurrence));
                                                                }

                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                                BlocProvider.of<
                                                                            FeedingScheduleBloc>(
                                                                        context)
                                                                    .add(
                                                                        GetAllFeedingDataEvent());
                                                              },
                                                            )
                                                          ]);
                                                    });
                                                  });
                                            }
                                            // Perform delete action
                                            // Add your delete logic here
                                            // Navigator.of(context).pop();
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },

                              // ... add more properties as needed
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        floatingActionButton: InkWell(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: AddFeedingSchedule(
                edit: false,
              ),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                color: Color(0xFF3B4CA6),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${title}: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${value}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
