import 'package:flutter/material.dart';

abstract class MockApiEvent {}

class PostRecordExerciseApi extends MockApiEvent {
  final BuildContext context;
  final String type;
  final String dateTinme;
  final String message;
  PostRecordExerciseApi(this.context, this.type, this.dateTinme, this.message);
}

class GetRecordExerciseApi extends MockApiEvent {
  final BuildContext context;
  final String type;
  GetRecordExerciseApi(this.context, this.type);
}
