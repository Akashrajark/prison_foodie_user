part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitialState extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesSuccessState extends CategoriesState {}

final class CategoriesGetSuccessState extends CategoriesState {
  final List<Map<String, dynamic>> categories;

  CategoriesGetSuccessState({required this.categories});
}

final class CategoriesFailureState extends CategoriesState {
  final String message;

  CategoriesFailureState({this.message = apiErrorMessage});
}
