part of 'menus_bloc.dart';

@immutable
sealed class MenusEvent {}

class GetAllMenusEvent extends MenusEvent {
  final Map<String, dynamic> params;

  GetAllMenusEvent({required this.params});
}

class AddToCartEvent extends MenusEvent {
  final Map<String, dynamic> menuDetails;

  AddToCartEvent({required this.menuDetails});
}

class EditMenuEvent extends MenusEvent {
  final Map<String, dynamic> menuDetails;
  final int menuId;

  EditMenuEvent({
    required this.menuDetails,
    required this.menuId,
  });
}

class DeleteMenuEvent extends MenusEvent {
  final int menuId;

  DeleteMenuEvent({required this.menuId});
}
