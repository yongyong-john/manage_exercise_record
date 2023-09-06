import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_bloc.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_event.dart';
import 'package:manage_exercise_records/bloc/api/mock_api_state.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_bloc.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_state.dart';
import 'package:manage_exercise_records/common/data/data_class.dart';

class HistoryExerciseView extends StatefulWidget {
  const HistoryExerciseView({Key? key}) : super(key: key);

  @override
  State<HistoryExerciseView> createState() => _HistoryExerciseView();
}

class _HistoryExerciseView extends State<HistoryExerciseView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ExerciseData> exerciseDataList = <ExerciseData>[];
    String category = '';
    return BlocBuilder<CategoryImageBloc, CategoryImageState>(
      builder: (context, state) {
        if (state is CategoryImageSelected) {
          BlocProvider.of<MockApiBloc>(context).add(GetRecordExerciseApi(state.category));
          category = state.category;
        }
        return BlocBuilder<MockApiBloc, MockApiState>(
          builder: (context, state) {
            if (state is MockApiLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RecordDataLoaded) {
              exerciseDataList = state.exerciseDataList;
            }
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(category),
              ),
              body: ListView.builder(
                controller: _scrollController,
                itemCount: exerciseDataList.length,
                itemBuilder: (context, index) {
                  if (index > 0) {
                    return ListTile(
                      title: Text(exerciseDataList[index].createdAt),
                      subtitle: Text(exerciseDataList[index].message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
