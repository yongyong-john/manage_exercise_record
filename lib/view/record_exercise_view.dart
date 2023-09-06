import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_bloc.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_event.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_state.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_bloc.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_state.dart';

class RecordExerciseView extends StatefulWidget {
  const RecordExerciseView({Key? key}) : super(key: key);

  @override
  State<RecordExerciseView> createState() => _RecordExerciseView();
}

class _RecordExerciseView extends State<RecordExerciseView> {
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final TextEditingController _messageController = TextEditingController();
  String _imagePath = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: _dateTime, firstDate: DateTime(2015), lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null && picked != _timeOfDay) {
      setState(() {
        _timeOfDay = picked;
      });
    }
  }

  DateTime addTimeOfDayToDateTime(DateTime dateTime, TimeOfDay timeOfDay) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    String selectedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(addTimeOfDayToDateTime(_dateTime, _timeOfDay));
    String category = '';
    return BlocBuilder<CategoryImageBloc, CategoryImageState>(
      builder: (context, state) {
        if (state is CategoryImageSelected) {
          _imagePath = state.categoryImagePath;
          category = state.category;
        }
        return BlocBuilder<MockApiBloc, MockApiState>(builder: (context, state) {
          if (state is RecordDataFailed) {}
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(category),
            ),
            body: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _imagePath.isNotEmpty
                          ? Image.asset(
                              _imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Container(),
                      const SizedBox(height: 16),
                      ListTile(
                        title: Text(selectedDateTime),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () => _selectDate(context),
                            ),
                            IconButton(
                              icon: const Icon(Icons.access_time),
                              onPressed: () => _selectTime(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Message Textfield
                      TextField(
                        controller: _messageController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Message',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<MockApiBloc>(context).add(
                                  PostRecordExerciseApi(context, category, selectedDateTime, _messageController.text));
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
