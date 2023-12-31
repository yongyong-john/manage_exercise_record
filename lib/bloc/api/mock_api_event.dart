import 'package:flutter/material.dart';

abstract class MockApiEvent {}

class PostRecordExerciseApi extends MockApiEvent {
  final String type;
  final String dateTinme;
  final String message;
  PostRecordExerciseApi(this.type, this.dateTinme, this.message);
}

class GetRecordExerciseApi extends MockApiEvent {
  final String type;
  GetRecordExerciseApi(this.type);
}

class StateUpdate extends MockApiEvent {
  StateUpdate();
}
