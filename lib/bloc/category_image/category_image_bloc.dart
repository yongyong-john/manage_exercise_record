import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_event.dart';
import 'package:manage_exercise_records/bloc/category_image/category_image_state.dart';

class CategoryImageBloc extends Bloc<CategoryImageEvent, CategoryImageState> {
  CategoryImageBloc() : super(const CategoryImageInitial()) {
    on<SetCategoryImage>(_onSetCategoryImage);
  }

  void _onSetCategoryImage(SetCategoryImage event, Emitter<CategoryImageState> emit) {
    emit(const CategoryImageLoading());
    emit(CategoryImageSelected(event.category, event.categoryImagePath));
  }
}
