import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesEvent>((event, emit) async {
      try {
        emit(CategoriesLoadingState());
        SupabaseQueryBuilder table =
            Supabase.instance.client.from('categories');

        if (event is GetAllCategoriesEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*');

          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }

          List<Map<String, dynamic>> categories =
              await query.order('name', ascending: true);

          emit(CategoriesGetSuccessState(categories: categories));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(CategoriesFailureState());
      }
    });
  }
}
