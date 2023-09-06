import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:manage_exercise_records/bloc/api/mock_api_event.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_state.dart';
import 'package:manage_exercise_records/common/data.dart';

class MockApiBloc extends Bloc<MockApiEvent, MockApiState> {
  MockApiBloc() : super(const MockApiInitial()) {
    on<PostRecordExerciseApi>(_onPostRecordExerciseApi);
    on<GetRecordExerciseApi>(_onGetRecordExerciseApi);
  }

  Future<void> _onPostRecordExerciseApi(PostRecordExerciseApi event, Emitter<MockApiState> emit) async {
    emit(const MockApiLoading());
    Map<String, String> queryParams = {
      'clientId': '1',
      'createdAt': event.dateTinme,
      'type': event.type,
      'message': event.message,
    };
    final Uri uri = Uri.parse('https://64f7dc29824680fd217ee2bb.mockapi.io/api/v1/recordexercisebytype');
    await http.post(uri, body: queryParams);
    emit(const RecordDataUpdated());
  }

  Future<void> _onGetRecordExerciseApi(GetRecordExerciseApi event, Emitter<MockApiState> emit) async {
    emit(const MockApiLoading());

    final Uri uri = Uri.parse('https://64f7dc29824680fd217ee2bb.mockapi.io/api/v1/recordexercisebytype');
    var response = await http.get(uri);
    print('status=${response.statusCode}');
    print('body=${jsonDecode(response.body)}');
    List<dynamic> list = jsonDecode(response.body);
    List<ExerciseData> exerciseDataList = list.map((item) => ExerciseData.fromJson(item)).toList();
    emit(RecordDataLoaded(exerciseDataList));
  }
}
