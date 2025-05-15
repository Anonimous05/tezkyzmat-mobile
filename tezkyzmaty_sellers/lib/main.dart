import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezkyzmaty_sellers/bloc_observer.dart';
import 'package:tezkyzmaty_sellers/core/constants/end_point.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_general_constants.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_prefs_consts.dart';
import 'package:tezkyzmaty_sellers/data/services/regions_service.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/home/bloc/home_bloc.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/cubit/profile_cubit.dart';
import 'package:tezkyzmaty_sellers/tezkyzmat_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await configure();
  await EndPointConstant().init();
  await RegionsService().loadData();
  Bloc.observer = AppBlocObserver();

  final prefs = getIt<SharedPreferences>();

  final String defaultLocale = Platform.localeName;
  String systemLanguageCode = '';

  if (defaultLocale.contains(GlobalGeneralConsts.ru)) {
    systemLanguageCode = GlobalGeneralConsts.ru;
  } else if (defaultLocale.contains(GlobalGeneralConsts.ky)) {
    systemLanguageCode = GlobalGeneralConsts.ky;
  } else {
    systemLanguageCode = GlobalGeneralConsts.ru;
  }

  final String languageCode =
      prefs.getString(GlobalPrefsConst.lang) ?? systemLanguageCode;

  prefs.setString(GlobalPrefsConst.lang, languageCode);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return EasyLocalization(
          ignorePluralRules: false,
          supportedLocales: const [Locale('ru'), Locale('ky')],
          path: GlobalGeneralConsts.translationsPath,
          startLocale: Locale(languageCode),
          fallbackLocale: const Locale('ru'),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) => getIt<AuthenticationBloc>(),
              ),

              BlocProvider<ProfileCubit>(
                lazy: false,
                create: (context) => getIt<ProfileCubit>(),
              ),
              BlocProvider<HomeBloc>(
                lazy: false,
                create: (context) => getIt<HomeBloc>(),
              ),
            ],
            child: const TezKyzmatApp(),
          ),
        );
      },
    ),
  );
}
