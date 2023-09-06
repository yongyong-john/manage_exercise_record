import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  const LoginSuccess();

  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  const LoginFailure();

  @override
  List<Object> get props => [];
}

class LoginAlready extends LoginState {
  const LoginAlready();

  @override
  List<Object> get props => [];
}

class LoginNotYet extends LoginState {
  const LoginNotYet();

  @override
  List<Object> get props => [];
}
