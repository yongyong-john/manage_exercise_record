import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:manage_exercise_records/bloc/api/mock_api_event.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_state.dart';
import 'package:manage_exercise_records/common/consts.dart';
import 'package:manage_exercise_records/common/data/data_class.dart';
import 'package:manage_exercise_records/common/widget/snackbar.dart';

class MockApiBloc extends Bloc<MockApiEvent, MockApiState> {
  MockApiBloc() : super(const MockApiInitial()) {
    on<PostRecordExerciseApi>(_onPostRecordExerciseApi);
    on<GetRecordExerciseApi>(_onGetRecordExerciseApi);
  }

  Future<void> _onPostRecordExerciseApi(PostRecordExerciseApi event, Emitter<MockApiState> emit) async {
    emit(const MockApiLoading());
    try {
      Map<String, String> queryParams = {
        'clientId': '1',
        'createdAt': event.dateTinme,
        'type': event.type,
        'message': event.message,
      };
      final Uri uri = Uri.parse(recordExerciseByTypeUrl);
      var response = await http.post(uri, body: queryParams);
      print('status=${response.statusCode}');
      print('body=${jsonDecode(response.body)}');
    } catch (e) {
      emit(const RecordDataFailed());
      snackBarWithText(event.context, 'Failed to record exercise [${event.type}].');
      return;
    }
    emit(const RecordDataUpdated());
  }

  Future<void> _onGetRecordExerciseApi(GetRecordExerciseApi event, Emitter<MockApiState> emit) async {
    emit(const MockApiLoading());
    List<ExerciseData> exerciseDataList = <ExerciseData>[];
    try {
      final Uri uri = Uri.parse('$recordExerciseByTypeUrl?type=${event.type}');
      var response = await http.get(uri);
      print('status=${response.statusCode}');
      print('body=${jsonDecode(response.body)}');
      List<dynamic> list = jsonDecode(response.body);
      exerciseDataList = list.map((item) => ExerciseData.fromJson(item)).toList();
    } catch (e) {
      emit(const RecordDataFailed());
      snackBarWithText(event.context, 'Failed to get exercise [${event.type}] history.');
      return;
    }
    emit(RecordDataLoaded(exerciseDataList));
  }
}
