import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/dio_response/dio_base_response.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';

import '../../../../domain/usecases/usecases.dart';

part 'authorization_state.dart';

@injectable
class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit(this._loginUseCase)
    : _authenticationBloc = getIt<AuthenticationBloc>(),
      super(const AuthorizationState());

  Future<void> registerLogin(String phone, String password) async {
    emit(
      state.copyWith(
        authorizationStatus: AuthorizationStatus.loading,
        phone: phone,
      ),
    );

    final Map<String, dynamic> payload = {'password': password};
    if (isNumeric(phone)) {
      payload.addAll({'phone': phone});
    }

    if (!isNumeric(phone)) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: 'Wrong phone',
        ),
      );
    }

    try {
      final response = await _loginUseCase.otpSend(input: payload);
      if (response.isLeft) {
        return emit(
          state.copyWith(
            authorizationStatus: AuthorizationStatus.error,
            errorMessage: response.left.message,
          ),
        );
      }

      if (response.isRight) {
        return emit(
          state.copyWith(
            authorizationStatus:
                AuthorizationStatus.registrationSendOTPConfirmed,
          ),
        );
      }
    } catch (e) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.error));
  }

  Future<void> restorePassword(String phone) async {
    emit(
      state.copyWith(
        authorizationStatus: AuthorizationStatus.loading,
        phone: phone,
      ),
    );

    final Map<String, dynamic> payload = {};
    if (isNumeric(phone)) {
      payload.addAll({'phone': phone});
    }

    if (!isNumeric(phone)) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: 'Wrong phone',
        ),
      );
    }

    try {
      final response = await _loginUseCase.restorePassword(input: payload);
      if (response.isLeft) {
        return emit(
          state.copyWith(
            authorizationStatus: AuthorizationStatus.error,
            errorMessage: response.left.message,
          ),
        );
      }

      if (response.isRight) {
        return emit(
          state.copyWith(
            authorizationStatus:
                AuthorizationStatus.forgotPasswordSendOTPConfirmed,
          ),
        );
      }
    } catch (e) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.error));
  }

  Future<void> login(String phone, String password) async {
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.loading));

    final Map<String, dynamic> payload = {'password': password};
    if (isNumeric(phone)) {
      payload.addAll({'phone': phone});
    }

    if (!isNumeric(phone)) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: 'Wrong phone',
        ),
      );
    }

    try {
      final response = await _loginUseCase.login(input: payload);

      if (response.isRight) {
        final value = response.right;
        _authenticationBloc.add(
          LoggedIn(
            refreshToken: value.refresh,
            token: value.access,
            save: true,
          ),
        );
        return emit(
          state.copyWith(
            authorizationStatus: AuthorizationStatus.loginConfirmed,
          ),
        );
      }
    } catch (e) {
      if (e is DioBaseResponse) {
        if (e.data['detail'] != null) {
          return emit(
            state.copyWith(
              authorizationStatus: AuthorizationStatus.error,
              errorMessage: e.data['detail'].toString(),
            ),
          );
        }
      }
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.error));
  }

  Future<void> otpVerify(String phone, String password, String otp) async {
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.loading));

    final Map<String, dynamic> payload = {'code': otp, 'password': password};

    if (isNumeric(phone)) {
      payload.addAll({'phone': phone});
    }

    if (!isNumeric(phone)) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: 'Wrong phone',
        ),
      );
    }

    try {
      final response = await _loginUseCase.otpVerify(input: payload);

      if (response.isRight) {
        final value = response.right;
        _authenticationBloc.add(
          LoggedIn(
            refreshToken: value.refresh,
            token: value.access,
            save: true,
          ),
        );
        return emit(
          state.copyWith(
            authorizationStatus: AuthorizationStatus.registrationOTPConfirmed,
            isNewUser: value.isNewUser,
          ),
        );
      }
    } catch (e) {
      if (e is DioBaseResponse) {
        if (e.data['detail'] != null) {
          return emit(
            state.copyWith(
              authorizationStatus: AuthorizationStatus.error,
              errorMessage: e.data['detail'].toString(),
            ),
          );
        }
      }
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.error));
  }

  Future<void> otpVerifyRestorePassword(String phone, String otp) async {
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.loading));

    final Map<String, dynamic> payload = {'code': otp};

    if (isNumeric(phone)) {
      payload.addAll({'phone': phone});
    }
    if (!isNumeric(phone)) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: 'Wrong phone',
        ),
      );
    }

    try {
      final response = await _loginUseCase.otpVerifyRestorePassword(
        input: payload,
      );
      if (response.isRight) {
        return emit(
          state.copyWith(
            token: response.right,
            authorizationStatus: AuthorizationStatus.forgotPasswordOTPConfirmed,
          ),
        );
      }
    } catch (e) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.error));
  }

  Future<void> enterNewPassword(String token, String password) async {
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.loading));

    final Map<String, dynamic> payload = {
      'token': token,
      'new_password': password,
    };

    try {
      final response = await _loginUseCase.enterNewPassword(input: payload);

      if (response.isRight) {
        return emit(
          state.copyWith(
            authorizationStatus: AuthorizationStatus.enterNewPasswordConfirmed,
          ),
        );
      }
    } catch (e) {
      return emit(
        state.copyWith(
          authorizationStatus: AuthorizationStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(authorizationStatus: AuthorizationStatus.error));
  }

  final LoginUseCase _loginUseCase;
  final AuthenticationBloc _authenticationBloc;
}

bool isNumeric(String str) {
  return RegExp(r'^[0-9]+$').hasMatch(str);
}
