import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/ad_video/ad_video_bloc.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_bloc.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_bloc.dart';
import 'package:manage_exercise_records/bloc/login/login_bloc.dart';
import 'package:manage_exercise_records/repository/interface/ilogin_info_repository.dart';
import 'package:manage_exercise_records/view/main_view.dart';

class ManageExerciseRecords extends StatefulWidget {
  const ManageExerciseRecords({Key? key}) : super(key: key);

  @override
  State<ManageExerciseRecords> createState() => _ManageExerciseRecords();
}

class _ManageExerciseRecords extends State<ManageExerciseRecords> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryImageBloc>(
          create: (BuildContext context) => CategoryImageBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(
            loginInfoRepository: LoginInfoRepository(),
          ),
        ),
        BlocProvider<AdVideoBloc>(
          create: (BuildContext context) => AdVideoBloc(),
        ),
        BlocProvider<MockApiBloc>(
          create: (BuildContext context) => MockApiBloc(),
        ),
      ],
      child: const MaterialApp(
        home: MainView(),
      ),
    );
  }
}
