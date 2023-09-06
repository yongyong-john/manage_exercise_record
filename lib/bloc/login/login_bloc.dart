import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/login/login_event.dart';
import 'package:manage_exercise_records/bloc/login/login_state.dart';
import 'package:manage_exercise_records/common/consts.dart';
import 'package:manage_exercise_records/repository/interface/ilogin_info_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required ILoginInfoRepository loginInfoRepository})
      : _loginInfoRepository = loginInfoRepository,
        super(const LoginInitial()) {
    on<CheckMatchPassword>(_onCheckMatchPassword);
    on<LoadLoginInfo>(_onLoadLoginInfo);
  }
  final ILoginInfoRepository _loginInfoRepository;

  void _onCheckMatchPassword(CheckMatchPassword event, Emitter<LoginState> emit) {
    emit(const LoginLoading());
    // TODO: Add Login api
    if (event.password == password) {
      _loginInfoRepository.setLoginInfo(true);
      emit(const LoginSuccess());
    } else {
      emit(const LoginFailure());
      _loginInfoRepository.setLoginInfo(false);
      if (event.password == null) {
        return;
      }
      var snackBar = const SnackBar(
        content: Text(
          'Failed to login. Please check password and try again.',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
    }
  }

  Future<void> _onLoadLoginInfo(LoadLoginInfo event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    if (await _loginInfoRepository.getLoginInfo()) {
      emit(const LoginAlready());
    } else {
      emit(const LoginNotYet());
    }
  }
}
