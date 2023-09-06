import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manage_exercise_records/bloc/login/login_bloc.dart';
import 'package:manage_exercise_records/bloc/login/login_event.dart';
import 'package:manage_exercise_records/bloc/login/login_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('LoginBloc Test', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = LoginBloc();
    });

    blocTest<LoginBloc, LoginState>(
      'Should emit LoginSuccess.',

      /// Arrange
      build: () => loginBloc,

      /// Act
      act: (bloc) => bloc.add(CheckMatchPassword('12345')),

      /// Assert
      expect: () => [
        isA<LoginLoading>().having((state) => state, 'LoginBloc LoginLoading', const LoginLoading()),
        isA<LoginSuccess>().having((state) => state, 'LoginBloc LoginSuccess', const LoginSuccess())
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Should emit LoginFailure.',

      /// Arrange
      build: () => loginBloc,

      /// Act
      act: (bloc) => bloc.add(CheckMatchPassword('123')),

      /// Assert
      expect: () => [
        isA<LoginLoading>().having((state) => state, 'LoginBloc LoginLoading', const LoginLoading()),
        isA<LoginFailure>().having((state) => state, 'LoginBloc LoginFailure', const LoginFailure())
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Should emit LoginNotYet.',

      /// Arrange
      build: () => loginBloc,

      /// Act
      act: (bloc) => bloc.add(CheckMatchPassword(null)),

      /// Assert
      expect: () => [
        isA<LoginLoading>().having((state) => state, 'LoginBloc LoginLoading', const LoginLoading()),
        isA<LoginNotYet>().having((state) => state, 'LoginBloc LoginNotYet', const LoginNotYet())
      ],
    );

    tearDown(() {
      loginBloc.close();
    });
  });
}
