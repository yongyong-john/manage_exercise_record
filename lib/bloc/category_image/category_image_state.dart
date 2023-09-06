import 'package:equatable/equatable.dart';

abstract class CategoryImageState extends Equatable {
  const CategoryImageState();
}

class CategoryImageInitial extends CategoryImageState {
  const CategoryImageInitial();

  @override
  List<Object> get props => [];
}

class CategoryImageLoading extends CategoryImageState {
  const CategoryImageLoading();

  @override
  List<Object> get props => [];
}

class CategoryImageSelected extends CategoryImageState {
  final String category;
  final String categoryImagePath;
  const CategoryImageSelected(this.category, this.categoryImagePath);

  @override
  List<Object> get props => [category, categoryImagePath];
}
