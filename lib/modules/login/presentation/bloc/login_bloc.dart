import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_calendar/core/services/event_service.dart';
import 'package:magic_calendar/modules/login/domain/usecase/sign_in_usecase.dart';
import 'package:magic_calendar/modules/login/presentation/bloc/login_event.dart';
import 'package:magic_calendar/modules/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUseCase signInUseCase;
  final EventService fetchEventsUseCase; //TODO

  LoginBloc({required this.signInUseCase, required this.fetchEventsUseCase}) : super(LoginInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(LoginLoading());
      final user = await signInUseCase(event.email);
      if (user != null) {
        try {
          final events = await fetchEventsUseCase.fetchEvents(DateTime.now().year);
          emit(LoginSuccess(user: user, events: events));
        } catch (e) {
          emit(LoginError(message: 'Failed to load events'));
        }
      } else {
        emit(UserNotFound());
      }
    });
  }
}