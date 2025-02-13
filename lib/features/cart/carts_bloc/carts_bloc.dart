import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'carts_event.dart';
part 'carts_state.dart';

class CartsBloc extends Bloc<CartsEvent, CartsState> {
  CartsBloc() : super(CartsInitialState()) {
    on<CartsEvent>((event, emit) async {
      try {
        emit(CartsLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder table = supabaseClient.from('user_cart');

        if (event is GetAllCartsEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query = table
              .select('*,food_items!inner(*)')
              .eq('user_id', supabaseClient.auth.currentUser!.id);

          if (event.params['query'] != null) {
            query = query.ilike(
              'name',
              '%${event.params['query']}%',
            );
          }

          List<Map<String, dynamic>> carts = await query.order(
            'id',
            ascending: true,
          );

          emit(CartsGetSuccessState(
            carts: carts,
          ));
        } else if (event is AddCartEvent) {
          await supabaseClient.rpc('add_to_user_cart',
              params: event.cartDetails);

          emit(CartsSuccessState());
        } else if (event is EditCartEvent) {
          await table.update(event.cartDetails).eq('id', event.cartId);

          emit(CartsSuccessState());
        } else if (event is DeleteCartEvent) {
          await table.delete().eq('id', event.cartId);
          emit(CartsSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(CartsFailureState());
      }
    });
  }
}
