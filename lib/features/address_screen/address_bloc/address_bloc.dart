import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitialState()) {
    on<AddressEvent>((event, emit) async {
      try {
        emit(AddressLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder table = supabaseClient.from('address');

        if (event is GetAllAddressEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query = table
              .select('*')
              .eq('user_id', supabaseClient.auth.currentUser!.id);

          if (event.params['query'] != null) {
            query = query.ilike('title', '%${event.params['query']}%');
          }
          if (event.params['limit'] != null) {
            await query.limit(event.params['limit']);
          }

          List<Map<String, dynamic>> address =
              await query.order('title', ascending: true);

          emit(AddressGetSuccessState(address: address));
        } else if (event is AddAddressEvent) {
          await table.insert(event.addresDetails);

          emit(AddressSuccessState());
        } else if (event is EditAddressEvent) {
          await table.update(event.addresDetails).eq('id', event.addresId);

          emit(AddressSuccessState());
        } else if (event is DeleteAddressEvent) {
          await table.delete().eq('id', event.addresId);
          emit(AddressSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(AddressFailureState());
      }
    });
  }
}
