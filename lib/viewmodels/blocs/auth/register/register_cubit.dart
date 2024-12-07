import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmitted() {
    emit(
      state.copyWith(
        formStatus: FormStatus.submitting,
        name: Name.dirty(state.name.value),

        isValid: Formz.validate([state.name]),
      ),
    );

    print('Submitted $state');

  }

  void updateName(String value) {
    final name = Name.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name]),
      ),
    );
  }
}
