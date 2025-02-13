part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

class GetAllAddressEvent extends AddressEvent {
  final Map<String, dynamic> params;

  GetAllAddressEvent({required this.params});
}

class AddAddressEvent extends AddressEvent {
  final Map<String, dynamic> addresDetails;

  AddAddressEvent({required this.addresDetails});
}

class EditAddressEvent extends AddressEvent {
  final Map<String, dynamic> addresDetails;
  final int addresId;

  EditAddressEvent({
    required this.addresDetails,
    required this.addresId,
  });
}

class DeleteAddressEvent extends AddressEvent {
  final int addresId;

  DeleteAddressEvent({required this.addresId});
}
