abstract class CategoryImageEvent {}

class SetCategoryImage extends CategoryImageEvent {
  final String category;
  final String categoryImagePath;
  SetCategoryImage(this.category, this.categoryImagePath);
}

class GetCategoryImage extends CategoryImageEvent {
  GetCategoryImage();
}
