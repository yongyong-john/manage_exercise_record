import 'package:flutter/material.dart';

abstract class LoginEvent {}

class CheckMatchPassword extends LoginEvent {
  final BuildContext context;
  final String? password;
  CheckMatchPassword(this.context, this.password);
}

class LoadLoginInfo extends LoginEvent {
  LoadLoginInfo();
}
