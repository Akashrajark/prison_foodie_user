part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitialState extends AddressState {}

final class AddressLoadingState extends AddressState {}

final class AddressSuccessState extends AddressState {}

final class AddressGetSuccessState extends AddressState {
  final List<Map<String, dynamic>> address;

  AddressGetSuccessState({required this.address});
}

final class AddressFailureState extends AddressState {
  final String message;

  AddressFailureState({this.message = apiErrorMessage});
}
