part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

class GetAllCategoriesEvent extends CategoriesEvent {
  final Map<String, dynamic> params;

  GetAllCategoriesEvent({required this.params});
}
