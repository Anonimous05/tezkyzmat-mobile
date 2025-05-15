// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:tezkyzmaty_sellers/core/api/api.dart' as _i1037;
import 'package:tezkyzmaty_sellers/core/api/client.dart' as _i407;
import 'package:tezkyzmaty_sellers/core/api/client_impl.dart' as _i179;
import 'package:tezkyzmaty_sellers/core/utils/logger.dart' as _i662;
import 'package:tezkyzmaty_sellers/data/source/local/local_user_repository.dart'
    as _i810;
import 'package:tezkyzmaty_sellers/data/source/notifications_repository_impl.dart'
    as _i1053;
import 'package:tezkyzmaty_sellers/data/source/remote/remote_notifications_repository.dart'
    as _i560;
import 'package:tezkyzmaty_sellers/data/source/remote/remote_user_repository.dart'
    as _i262;
import 'package:tezkyzmaty_sellers/data/source/user_repository_impl.dart'
    as _i640;
import 'package:tezkyzmaty_sellers/domain/repository/notifications_repository.dart'
    as _i250;
import 'package:tezkyzmaty_sellers/domain/repository/user_repository.dart'
    as _i283;
import 'package:tezkyzmaty_sellers/domain/usecases/application_use_case.dart'
    as _i471;
import 'package:tezkyzmaty_sellers/domain/usecases/login_use_case.dart'
    as _i523;
import 'package:tezkyzmaty_sellers/domain/usecases/notifications_use_case.dart'
    as _i910;
import 'package:tezkyzmaty_sellers/domain/usecases/usecases.dart' as _i754;
import 'package:tezkyzmaty_sellers/domain/usecases/user_use_case.dart' as _i677;
import 'package:tezkyzmaty_sellers/injectable_singleton_module.dart' as _i329;
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart'
    as _i323;
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/cubit/authorization_cubit.dart'
    as _i99;
import 'package:tezkyzmaty_sellers/presentation/feature/home/bloc/home_bloc.dart'
    as _i49;
import 'package:tezkyzmaty_sellers/presentation/feature/profile/cubit/profile_cubit.dart'
    as _i552;
import 'package:tezkyzmaty_sellers/presentation/feature/registration/cubit/registration_cubit.dart'
    as _i700;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i662.Logger>(() => _i662.Logger());
    gh.lazySingleton<_i407.Client>(() => _i179.ClientImpl());
    gh.lazySingleton<_i262.RemoteUserRepository>(
      () => _i262.RemoteUserRepositoryImpl(apiClient: gh<_i1037.Client>()),
    );
    gh.lazySingleton<_i810.LocalUserRepository>(
      () => _i810.LocalUserRepositoryImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i560.RemoteNotificationsRepository>(
      () => _i560.RemoteNotificationsRepositoryImpl(
        apiClient: gh<_i1037.Client>(),
      ),
    );
    gh.lazySingleton<_i283.UserRepository>(
      () => _i640.UserRepositoryImpl(
        remoteUserRepository: gh<_i262.RemoteUserRepository>(),
        localUserRepository: gh<_i810.LocalUserRepository>(),
      ),
    );
    gh.lazySingleton<_i471.ApplicationUseCase>(
      () => _i471.ApplicationUseCase(gh<_i283.UserRepository>()),
    );
    gh.lazySingleton<_i523.LoginUseCase>(
      () => _i523.LoginUseCase(gh<_i283.UserRepository>()),
    );
    gh.lazySingleton<_i677.UserUseCase>(
      () => _i677.UserUseCase(gh<_i283.UserRepository>()),
    );
    gh.lazySingleton<_i250.NotificationsRepository>(
      () => _i1053.NotificationsRepositoryImpl(
        remoteNotificationsRepository:
            gh<_i560.RemoteNotificationsRepository>(),
      ),
    );
    gh.factory<_i49.HomeBloc>(
      () => _i49.HomeBloc(gh<_i471.ApplicationUseCase>()),
    );
    gh.lazySingleton<_i323.AuthenticationBloc>(
      () => _i323.AuthenticationBloc(gh<_i754.UserUseCase>()),
    );
    gh.factory<_i700.RegistrationCubit>(
      () => _i700.RegistrationCubit(gh<_i523.LoginUseCase>()),
    );
    gh.factory<_i99.AuthorizationCubit>(
      () => _i99.AuthorizationCubit(gh<_i754.LoginUseCase>()),
    );
    gh.lazySingleton<_i910.NotificationsUseCase>(
      () => _i910.NotificationsUseCase(gh<_i250.NotificationsRepository>()),
    );
    gh.factory<_i552.ProfileCubit>(
      () => _i552.ProfileCubit(gh<_i677.UserUseCase>()),
    );
    return this;
  }
}

class _$InjectionModule extends _i329.InjectionModule {}
