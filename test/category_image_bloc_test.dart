import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_bloc.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_event.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_state.dart';
import 'package:manage_exercise_records/common/consts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('CategoryImageBloc Test', () {
    late CategoryImageBloc categoryImageBloc;

    setUp(() {
      categoryImageBloc = CategoryImageBloc();
    });

    blocTest<CategoryImageBloc, CategoryImageState>(
      'Should emit CategoryImageSelected.',

      /// Arrange
      build: () => categoryImageBloc,

      /// Act
      act: (bloc) => bloc.add(SetCategoryImage(lunge, lungeImage)),

      /// Assert
      expect: () => [
        isA<CategoryImageLoading>()
            .having((state) => state, 'CategoryImageBloc CategoryImageLoading', const CategoryImageLoading()),
        isA<CategoryImageSelected>().having(
            (state) => state, 'CategoryImageBloc CategoryImageSelected', const CategoryImageSelected(lunge, lungeImage))
      ],
    );

    blocTest<CategoryImageBloc, CategoryImageState>(
      'Should emit CategoryImageSelected.',

      /// Arrange
      build: () => categoryImageBloc,

      /// Act
      act: (bloc) => bloc.add(SetCategoryImage(pushUp, pushUpImage)),

      /// Assert
      expect: () => [
        isA<CategoryImageLoading>()
            .having((state) => state, 'CategoryImageBloc CategoryImageLoading', const CategoryImageLoading()),
        isA<CategoryImageSelected>().having((state) => state, 'CategoryImageBloc CategoryImageSelected',
            const CategoryImageSelected(pushUp, pushUpImage))
      ],
    );

    tearDown(() {
      categoryImageBloc.close();
    });
  });
}
