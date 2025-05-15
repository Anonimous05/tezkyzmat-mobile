import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/error/error_exception.dart';
import 'package:tezkyzmaty_sellers/domain/entities/entities.dart';
import 'package:tezkyzmaty_sellers/domain/usecases/user_use_case.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.userUseCase) : super(const ProfileState());
  final UserUseCase userUseCase;
  Future<void> initData(ProfileEntity? profile) async {
    emit(state.copyWith(profile: profile));
  }

  Future<void> fetchProfile() async {
    try {
      final response = await userUseCase.fetchProfile();
      if (response.isLeft) {
        return emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: response.left.message,
          ),
        );
      }

      if (response.isRight) {
        getIt<AuthenticationBloc>().add(UpdateProfile(profile: response.right));

        return emit(
          state.copyWith(
            profile: response.right,
            status: ProfileStatus.successUpdateAvatar,
          ),
        );
      }
    } catch (e) {
      if (e is UnauthorizedException) {
        getIt<AuthenticationBloc>().add(LoggedOut());
        return;
      }
      log(e.toString());
      return emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: ProfileStatus.failure));
  }

  Future<void> updateAvatar(File avatar) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final response = await userUseCase.updateProfileFormData(
        avatar: avatar,
        input: {},
      );
      if (response.isLeft) {
        return emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: response.left.message,
          ),
        );
      }

      if (response.isRight) {
        getIt<AuthenticationBloc>().add(UpdateProfile(profile: response.right));

        return emit(
          state.copyWith(
            profile: response.right,
            status: ProfileStatus.successUpdateAvatar,
          ),
        );
      }
    } catch (e) {
      if (e is UnauthorizedException) {
        getIt<AuthenticationBloc>().add(LoggedOut());
        return;
      }
      log(e.toString());
      return emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: ProfileStatus.failure));
  }

  Future<void> updateName(String name) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final Map<String, dynamic> map = {'name': name};
    try {
      final response = await userUseCase.updateProfileFormData(input: map);
      if (response.isLeft) {
        return emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: response.left.message,
          ),
        );
      }

      if (response.isRight) {
        getIt<AuthenticationBloc>().add(UpdateProfile(profile: response.right));

        return emit(
          state.copyWith(
            profile: response.right,
            status: ProfileStatus.successUpdateName,
          ),
        );
      }
    } catch (e) {
      if (e is UnauthorizedException) {
        getIt<AuthenticationBloc>().add(LoggedOut());
        return;
      }
      log(e.toString());
      return emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: ProfileStatus.failure));
  }

  Future<void> updatePassword(String password1, String password2) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final Map<String, dynamic> map = {
      'password': password1,
      'repeat_password': password2,
    };
    try {
      final response = await userUseCase.updateProfileFormData(input: map);
      if (response.isLeft) {
        return emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: response.left.message,
          ),
        );
      }

      if (response.isRight) {
        getIt<AuthenticationBloc>().add(UpdateProfile(profile: response.right));

        return emit(
          state.copyWith(
            profile: response.right,
            status: ProfileStatus.successUpdatePassword,
          ),
        );
      }
    } catch (e) {
      if (e is UnauthorizedException) {
        getIt<AuthenticationBloc>().add(LoggedOut());
        return;
      }
      log(e.toString());
      return emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: ProfileStatus.failure));
  }

  Future<void> topUpBalance(int amount, String paymentMethod) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final Map<String, dynamic> map = {
      'amount': amount,
      // 'payment_method': paymentMethod
    };
    try {
      final response = await userUseCase.topUpBalance(input: map);
      if (response.isLeft) {
        return emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: response.left.message,
          ),
        );
      }

      if (response.isRight) {
        emit(state.copyWith(status: ProfileStatus.successTopUpBalance));
        fetchProfile();
      }
    } catch (e) {
      if (e is UnauthorizedException) {
        getIt<AuthenticationBloc>().add(LoggedOut());
        return;
      }
      log(e.toString());
      return emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(state.copyWith(status: ProfileStatus.failure));
  }
}
