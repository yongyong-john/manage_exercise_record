import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/login/login_event.dart';
import 'package:manage_exercise_records/bloc/login/login_state.dart';
import 'package:manage_exercise_records/common/consts.dart';
import 'package:manage_exercise_records/common/crypto.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<CheckMatchPassword>(_onCheckMatchPassword);
  }

  void _onCheckMatchPassword(CheckMatchPassword event, Emitter<LoginState> emit) {
    emit(const LoginLoading());
    if (event.password == null) {
      emit(const LoginNotYet());
      return;
    }
    // TODO: Add Login api
    var hashPassword = hashString(event.password!);
    if (hashPassword == password) {
      emit(const LoginSuccess());
    } else {
      emit(const LoginFailure());
    }
  }
}
