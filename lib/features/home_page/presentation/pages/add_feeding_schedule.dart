import 'package:chicken_feeder/features/home_page/presentation/bloc/feeding_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../../../core/shared/constants.dart';
import '../../../../core/validators/input_validators.dart';
import '../widgets/category_multi_select.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFeedingSchedule extends StatefulWidget {
  const AddFeedingSchedule(
      {super.key,
      required this.edit,
      this.previousDate,
      this.startDate,
      this.endDate,
      this.amount,
      this.chickens,
      this.recurrence,
      this.selectedDate});
  final bool edit;
  final previousDate;
  final startDate;
  final endDate;
  final amount;
  final chickens;
  final recurrence;
  final selectedDate;

  @override
  State<AddFeedingSchedule> createState() => _AddFeedingScheduleState();
}

class _AddFeedingScheduleState extends State<AddFeedingSchedule> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  DateTime? _selectedDate;
  DateFormat? _dateFormat;
  TimeOfDay? _selectedTime;
  DateFormat? _timeFormat;
  TextEditingController? _weightController;
  TextEditingController? _numberOfChickenController;
  String _selectedOption = 'once';

  Future<void> _selectDate(BuildContext context, bool edit) async {
    if (edit == false) {
      final DateTime currentDate = DateTime.now();
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(currentDate.year + 100),
      );

      if (pickedDate != null && pickedDate != _selectedDate) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay currentTime = TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _showRepeatDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Repeat'),
          contentPadding: EdgeInsets.all(0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Radio<String>(
                  value: 'once',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                title: Text('once'),
                onTap: () {
                  setState(() {
                    _selectedOption = 'once';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'daily',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                title: Text('daily'),
                onTap: () {
                  setState(() {
                    _selectedOption = 'daily';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _dateFormat = DateFormat('yyyy-MM-dd');
    _timeFormat = DateFormat('hh:mm a');
    _weightController = TextEditingController();
    _numberOfChickenController = TextEditingController();

    if (widget.edit && widget.startDate != null) {
      // Pre-fill the form fields with the existing schedule values
      _selectedDate = widget.selectedDate;
      _selectedTime = TimeOfDay.fromDateTime(widget.startDate);
      _weightController!.text = widget.amount.toString();
      _numberOfChickenController!.text = widget.chickens.toString();
      _selectedOption = widget.recurrence;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: _appBar(context),
      body: BlocBuilder<FeedingScheduleBloc, FeedingScheduleState>(
          builder: (context, State) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth(context) * 20),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Feeding date",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: screenHeight(context) * 12),
                        TextButton(
                          onPressed: () => _selectDate(context, widget.edit),
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFF7F8F8),
                              foregroundColor: Colors.black54,
                              minimumSize: Size(screenWidth(context) * 320,
                                  screenHeight(context) * 40)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const Icon(Icons.date_range_outlined),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    _selectedDate != null
                                        ? 'Selected Date: ${_dateFormat!.format(_selectedDate!)}'
                                        : '2023-05-31',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight(context) * 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Specific feeding time",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: screenHeight(context) * 12),
                        TextButton(
                          onPressed: () => _selectTime(context),
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFFF7F8F8),
                            foregroundColor: Colors.black54,
                            minimumSize: Size(screenWidth(context) * 320,
                                screenHeight(context) * 40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time_outlined),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    _selectedTime != null
                                        ? 'Selected Time: ${_timeFormat!.format(DateTime(2023, 1, 1, _selectedTime!.hour, _selectedTime!.minute))}'
                                        : '06:30 AM',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight(context) * 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Food Weight (g/chicken)",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: screenHeight(context) * 12),
                        TextFormField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          decoration: kTextFieldDecoration(context).copyWith(
                            prefixIcon: const Icon(Icons.balance_outlined),
                            hintText: 'Enter food weight in grams / chicken',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a weight';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight(context) * 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Number of chickens",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: screenHeight(context) * 12),
                        TextFormField(
                          controller: _numberOfChickenController,
                          keyboardType: TextInputType.number,
                          decoration: kTextFieldDecoration(context).copyWith(
                            prefixIcon: const Icon(Icons.numbers_outlined),
                            hintText: 'Enter number of chickens',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the number of chickens';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight(context) * 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Repeat",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: _showRepeatDialog,
                            icon: Icon(Icons.repeat),
                            label: Text(_selectedOption),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFF7F8F8)),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.only(
                                  top: screenHeight(context) * 15.63,
                                  bottom: screenHeight(context) * 16.38,
                                  left: screenWidth(context) * 16.5,
                                ),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      screenHeight(context) * 14),
                                  side: BorderSide(
                                    color: Color(0xffF7F8F8),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      }),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: screenHeight(context) * 22,
          width: screenWidth(context) * 22,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.only(left: screenWidth(context) * 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
              // Navigator.of(context).pop(false);
            },
            child: Center(
              child: Icon(
                Icons.close_outlined,
                color: Color(0xFF1D1617),
                size: screenHeight(context) * 40,
              ),
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        widget.edit ? "Edit feeding schedule" : "Add feeding schedule",
        style: TextStyle(color: Colors.black87, fontSize: 16),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                DateTime startDate = DateTime(
                    _selectedDate!.year,
                    _selectedDate!.month,
                    _selectedDate!.day,
                    _selectedTime!.hour,
                    _selectedTime!.minute,
                    0);
                DateTime endDate = startDate;

                if (widget.edit) {
                  if (widget.recurrence == 'daily') {
                    if (_selectedOption == 'daily') {
                      endDate = DateTime(
                          startDate.year,
                          startDate.month,
                          startDate.day - 1,
                          widget.startDate.hour,
                          widget.startDate.minute);

                      context.read<FeedingScheduleBloc>().add(
                          UpdateFeedingScheduleEvent(
                              previousDate: widget.previousDate,
                              startDate: widget.startDate,
                              endDate: endDate,
                              amount: widget.amount,
                              chickens: widget.chickens,
                              recurrence: widget.recurrence));

                      endDate = DateTime(startDate.year + 100, startDate.month,
                          startDate.day, startDate.hour, startDate.minute);

                      context.read<FeedingScheduleBloc>().add(
                          CreateFeedingScheduleEvent(
                              startDate: startDate,
                              endDate: endDate,
                              amount: int.parse(_weightController!.text),
                              chickens:
                                  int.parse(_numberOfChickenController!.text),
                              recurrence: _selectedOption));
                    } else {
                      endDate = DateTime(
                          startDate.year,
                          startDate.month,
                          startDate.day - 1,
                          widget.startDate.hour,
                          widget.startDate.minute);

                      context.read<FeedingScheduleBloc>().add(
                          UpdateFeedingScheduleEvent(
                              previousDate: widget.previousDate,
                              startDate: widget.startDate,
                              endDate: endDate,
                              amount: widget.amount,
                              chickens: widget.chickens,
                              recurrence: widget.recurrence));

                      endDate = DateTime(startDate.year, startDate.month,
                          startDate.day, startDate.hour, startDate.minute);

                      context.read<FeedingScheduleBloc>().add(
                          CreateFeedingScheduleEvent(
                              startDate: startDate,
                              endDate: endDate,
                              amount: int.parse(_weightController!.text),
                              chickens:
                                  int.parse(_numberOfChickenController!.text),
                              recurrence: _selectedOption));

                      startDate = DateTime(
                          startDate.year,
                          startDate.month,
                          startDate.day + 1,
                          widget.startDate.hour,
                          widget.startDate.minute);
                      endDate = DateTime(startDate.year + 100, startDate.month,
                          startDate.day, startDate.hour, startDate.minute);

                      context.read<FeedingScheduleBloc>().add(
                          CreateFeedingScheduleEvent(
                              startDate: startDate,
                              endDate: endDate,
                              amount: widget.amount,
                              chickens: widget.chickens,
                              recurrence: widget.recurrence));
                    }
                  } else if (widget.recurrence == 'once') {
                    if (_selectedOption == 'daily') {
                      endDate = DateTime(startDate.year + 100, startDate.month,
                          startDate.day, startDate.hour, startDate.minute);

                      context.read<FeedingScheduleBloc>().add(
                          UpdateFeedingScheduleEvent(
                              previousDate: widget.previousDate,
                              startDate: startDate,
                              endDate: endDate,
                              amount: int.parse(_weightController!.text),
                              chickens:
                                  int.parse(_numberOfChickenController!.text),
                              recurrence: _selectedOption));
                    } else {
                      endDate = DateTime(startDate.year, startDate.month,
                          startDate.day, startDate.hour, startDate.minute);

                      context.read<FeedingScheduleBloc>().add(
                          UpdateFeedingScheduleEvent(
                              previousDate: widget.previousDate,
                              startDate: startDate,
                              endDate: endDate,
                              amount: int.parse(_weightController!.text),
                              chickens:
                                  int.parse(_numberOfChickenController!.text),
                              recurrence: _selectedOption));
                    }
                  }
                  // context.read<FeedingScheduleBloc>().add(UpdateFeedingScheduleEvent(
                  //     startDate: startDate,endDate: ));
                } else {
                  if (_selectedOption == 'daily') {
                    endDate = DateTime(startDate.year + 100, startDate.month,
                        startDate.day, startDate.hour, startDate.minute);
                  } else {
                    endDate = startDate;
                  }

                  context.read<FeedingScheduleBloc>().add(
                      CreateFeedingScheduleEvent(
                          startDate: startDate,
                          endDate: endDate,
                          amount: int.parse(_weightController!.text),
                          chickens: int.parse(_numberOfChickenController!.text),
                          recurrence: _selectedOption));

                  context.read<FeedingScheduleBloc>().add(
                      CreateFeedingScheduleEvent(
                          startDate: startDate,
                          endDate: endDate,
                          amount: int.parse(_weightController!.text),
                          chickens: int.parse(_numberOfChickenController!.text),
                          recurrence: _selectedOption));
                }
              }

              Navigator.of(context).pop(false);
              BlocProvider.of<FeedingScheduleBloc>(context)
                  .add(GetAllFeedingDataEvent());

              // Perform save action
              // Add your save logic here
            },
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFF3B4CA6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              widget.edit ? "update" : "Save",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
