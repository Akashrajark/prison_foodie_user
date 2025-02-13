import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'menus_event.dart';
part 'menus_state.dart';

class MenusBloc extends Bloc<MenusEvent, MenusState> {
  MenusBloc() : super(MenusInitialState()) {
    on<MenusEvent>((event, emit) async {
      try {
        emit(MenusLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder table = supabaseClient.from('food_items');
        SupabaseQueryBuilder categoriesTable =
            supabaseClient.from('categories');

        if (event is GetAllMenusEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*');

          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }
          if (event.params['category_id'] != null) {
            query = query.eq('category_id', '${event.params['category_id']}');
          }

          List<Map<String, dynamic>> menus =
              await query.order('name', ascending: true);
          List<Map<String, dynamic>> categories = [];
          if (event.params['category_id'] == null) {
            categories = await categoriesTable
                .select('*')
                .order('name', ascending: true);
          }

          emit(MenusGetSuccessState(menus: menus, categories: categories));
        } else if (event is AddToCartEvent) {
          await supabaseClient.rpc('add_to_user_cart',
              params: event.menuDetails);

          emit(MenusSuccessState());
        } else if (event is EditMenuEvent) {
          await table.update(event.menuDetails).eq('id', event.menuId);

          emit(MenusSuccessState());
        } else if (event is DeleteMenuEvent) {
          await table.delete().eq('id', event.menuId);
          emit(MenusSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(MenusFailureState());
      }
    });
  }
}
