import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/cubit/profile_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = getIt<AuthenticationBloc>();
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        if (state.authenticationStatus == AuthenticationStatus.authenticate) {
          context.read<ProfileCubit>().initData(state.profile);
          context.go(RouterPath.home);
        }
        if (state.authenticationStatus ==
            AuthenticationStatus.unAuthenticated) {
          context.go(RouterPath.signup);
        }
      },
      builder:
          (_, state) => Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstant.splash),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
    );
  }
}
