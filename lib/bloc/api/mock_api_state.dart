import 'package:equatable/equatable.dart';
import 'package:manage_exercise_records/common/data/data_class.dart';

abstract class MockApiState extends Equatable {
  const MockApiState();
}

class MockApiInitial extends MockApiState {
  const MockApiInitial();

  @override
  List<Object> get props => [];
}

class MockApiLoading extends MockApiState {
  const MockApiLoading();

  @override
  List<Object> get props => [];
}

class RecordDataUpdated extends MockApiState {
  const RecordDataUpdated();

  @override
  List<Object> get props => [];
}

class RecordDataFailed extends MockApiState {
  const RecordDataFailed();

  @override
  List<Object> get props => [];
}

class RecordDataLoaded extends MockApiState {
  final List<ExerciseData> exerciseDataList;
  const RecordDataLoaded(this.exerciseDataList);

  @override
  List<Object> get props => [ExerciseData];
}
