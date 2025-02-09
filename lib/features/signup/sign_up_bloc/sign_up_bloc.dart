import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:prison_foodie_user/values/strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEvent>((event, emit) async {
      try {
        emit(SignUpLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;
        if (event is SignUpUserEvent) {
          final AuthResponse response = await supabaseClient.auth.signUp(
            email: event.email,
            password: event.password,
          );

          final String? userId = response.user?.id; // Get user ID

          if (userId != null) {
            event.userDetails['user_id'] = userId;

            try {
              await supabaseClient.from('users').insert(event.userDetails);
              emit(SignUpSuccessState());
            } catch (dbError) {
              Logger().e('Database Insert Error: $dbError');
              // Delete user since inserting details failed
              await supabaseClient.auth.admin.deleteUser(userId);
              emit(SignUpFailureState(
                  message: 'Sign-up failed due to database error.'));
            }
          } else {
            emit(SignUpFailureState(
                message: 'Sign-up failed. Please try again.'));
          }
        }
      } catch (e, s) {
        Logger().e('$e\n$s');

        if (e is AuthException) {
          emit(SignUpFailureState(message: e.message));
        } else {
          emit(SignUpFailureState());
        }
      }
    });
  }
}
