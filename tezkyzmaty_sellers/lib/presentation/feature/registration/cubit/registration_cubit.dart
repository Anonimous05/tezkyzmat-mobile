import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/domain/entities/profile_entity.dart';
import 'package:tezkyzmaty_sellers/domain/usecases/login_use_case.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';

part 'registration_state.dart';

@injectable
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._loginUseCase)
    : _authenticationBloc = getIt<AuthenticationBloc>(),
      super(const RegistrationState());

  final LoginUseCase _loginUseCase;
  final AuthenticationBloc _authenticationBloc;
}
