// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezkyzmaty_sellers/core/api_response/api_response.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_general_constants.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_prefs_consts.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/core/services/global_storage_service.dart';
import 'package:tezkyzmaty_sellers/domain/entities/entities.dart';
import 'package:tezkyzmaty_sellers/domain/usecases/usecases.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

const cachedUpdateCheckDate = 'CACHED_UPDATE_CHECK';

@LazySingleton()
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._userUseCase) : super(const AuthenticationState()) {
    on<LoggedIn>(loggedIn);
    on<AppStarted>(appStarted);
    on<LoggedOut>(loggedOut);
    on<DeleteAccount>(deleteAccount);
    on<UpdateProfile>(updateProfile);
  }
  final UserUseCase _userUseCase;

  Future<void> appStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));

    try {
      ProfileEntity? profile;
      await Future.delayed(const Duration(seconds: 1), () async {});

      final Either<Failure, bool> authenticated =
          await _userUseCase.verifyToken();

      if (authenticated.isRight) {
        final Either<Failure, ProfileEntity?> profileResponse =
            await _userUseCase.fetchProfile();

        if (profileResponse.isRight) {
          profile = profileResponse.right;
        }
        return emit(
          state.copyWith(
            authenticationStatus: AuthenticationStatus.authenticate,
            profile: profile,
          ),
        );
      }

      emit(
        const AuthenticationState(
          authenticationStatus: AuthenticationStatus.unAuthenticated,
        ),
      );
    } catch (e) {
      if (e is UnauthorizedException) {
        await resetCache();
        emit(
          const AuthenticationState(
            authenticationStatus: AuthenticationStatus.unAuthenticated,
          ),
        );
      }
      emit(
        const AuthenticationState(
          authenticationStatus: AuthenticationStatus.unAuthenticated,
        ),
      );
    }
  }

  Future<void> deleteAccount(
    DeleteAccount event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));

    try {
      final Either<Failure, bool?> deleteAccount =
          await _userUseCase.deleteAccount();
      await Future.delayed(const Duration(seconds: 1), () async {
        if (deleteAccount.isRight) {
          final value = deleteAccount.right;
          if (value == true) {
            await resetCache();

            emit(
              const AuthenticationState(
                authenticationStatus: AuthenticationStatus.unAuthenticated,
              ),
            );
          }
        }
        if (deleteAccount.isLeft) {
          emit(
            state.copyWith(
              authenticationStatus: AuthenticationStatus.authenticate,
            ),
          );
        }
      });
    } catch (e) {
      emit(
        const AuthenticationState(
          authenticationStatus: AuthenticationStatus.unAuthenticated,
        ),
      );
    }
  }

  Future<void> loggedIn(
    LoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event.save) {
      Storage().token = event.token;
      await _saveToken(event.token);
      await _saveRefreshToken(event.refreshToken);
    }
    emit(
      state.copyWith(authenticationStatus: AuthenticationStatus.authConfirmed),
    );

    emit(
      state.copyWith(authenticationStatus: AuthenticationStatus.authenticate),
    );

    add(AppStarted());
  }

  Future<void> loggedOut(
    LoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    await resetCache();

    emit(
      const AuthenticationState(
        authenticationStatus: AuthenticationStatus.unAuthenticated,
      ),
    );
  }

  Future<void> updateProfile(
    UpdateProfile event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(profile: event.profile));
  }

  Future<void> resetCache() async {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    const FlutterSecureStorage storage = FlutterSecureStorage();
    state.copyWith(profile: const ProfileEntity());

    Storage().token = GlobalGeneralConsts.empty;
    await prefs.clear();
    await _deleteToken();

    await storage.deleteAll();
  }

  /// delete from keystore/keychain
  Future<void> _deleteToken() async {
    await Storage().secureStorage.delete(key: GlobalPrefsConst.accessToken);
    await Storage().secureStorage.delete(key: GlobalPrefsConst.refreshToken);
  }

  Future<void> _saveToken(String token) async {
    if (kDebugMode) {
      print(token);
    }
    await Storage().secureStorage.write(
      key: GlobalPrefsConst.accessToken,
      value: token,
    );
  }

  Future<void> _saveRefreshToken(String refreshToken) async {
    await Storage().secureStorage.write(
      key: GlobalPrefsConst.refreshToken,
      value: refreshToken,
    );
  }

  // Future<bool> checkAppUpdate() async {
  //   final SharedPreferences prefs = getIt<SharedPreferences>();
  //   final String todayString = DateFormat('dd-MM-yyyy').format(DateTime.now());
  //   final isCheckToday = prefs.getString(cachedUpdateCheckDate) ?? '';

  //   if (isCheckToday != todayString) {
  //     await prefs.setString(cachedUpdateCheckDate, todayString);
  //     final checker = InStoreAppVersionChecker();
  //     final status = await checker.checkUpdate();

  //     final bool needsUpdate = status.canUpdate;
  //     return needsUpdate;
  //   }
  //   return false;
  // }
}
