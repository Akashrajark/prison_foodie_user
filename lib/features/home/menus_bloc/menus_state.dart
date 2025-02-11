part of 'menus_bloc.dart';

@immutable
sealed class MenusState {}

final class MenusInitialState extends MenusState {}

final class MenusLoadingState extends MenusState {}

final class MenusSuccessState extends MenusState {}

final class MenusGetSuccessState extends MenusState {
  final List<Map<String, dynamic>> menus, categories;

  MenusGetSuccessState({
    required this.menus,
    required this.categories,
  });
}

final class MenusFailureState extends MenusState {
  final String message;

  MenusFailureState({this.message = apiErrorMessage});
}
