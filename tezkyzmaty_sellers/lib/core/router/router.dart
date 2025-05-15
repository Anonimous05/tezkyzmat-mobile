import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/utils/logger.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/about_app_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/analytics/view/analytics_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/enter_new_password/change_password_success.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/enter_new_password/enter_new_password_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/forget_password/restore_password_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/login/login_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/signup/otp_confirm_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authorization/signup/signup_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/home/view/home_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/main_tab/view/main_tab_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/policy_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/profile_main/view/profile_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/profile_settings/view/profile_edit_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/tariffs/tariffs_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/registration/view/registration_block_moderate_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/registration/view/registration_sell_parts_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/registration/view/registration_service_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/registration/view/registration_success_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/registration/view/registration_wait_moderate_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/splash/view/splash_page.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/talker_screen/hide_talker_screen.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/web_widget.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _tabANavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'tabANav',
);

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'splash',
      path: RouterPath.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),

    GoRoute(
      path: RouterPath.signup,
      name: RouterPath.signup,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const SignupScreen(),
      routes: [
        GoRoute(
          path: RouterPath.login,
          name: RouterPath.login,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: RouterPath.restorePassword,
              name: RouterPath.restorePassword,
              parentNavigatorKey: rootNavigatorKey,
              builder: (context, state) => const RestorePasswordPage(),
              routes: [
                GoRoute(
                  path: RouterPath.enterNewPassword,
                  name: RouterPath.enterNewPassword,
                  parentNavigatorKey: rootNavigatorKey,
                  builder:
                      (context, state) => EnterNewPasswordPage(
                        arguments: state.extra as EnterNewPasswordArguments,
                      ),
                  routes: [
                    GoRoute(
                      path: RouterPath.changePasswordSuccess,
                      name: RouterPath.changePasswordSuccess,
                      parentNavigatorKey: rootNavigatorKey,
                      builder:
                          (context, state) => const ChangePasswordSuccess(),
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: RouterPath.otpConfirm,
              name: RouterPath.otpConfirm,
              parentNavigatorKey: rootNavigatorKey,
              builder:
                  (context, state) => OtpConfirmScreen(
                    arguments: state.extra as OtpConfirmArguments,
                  ),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: RouterPath.registrationSuccess,
      name: RouterPath.registrationSuccess,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const RegistrationSuccessPage(),
      routes: [
        GoRoute(
          path: RouterPath.registrationSellParts,
          name: RouterPath.registrationSellParts,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const RegistrationSellPartsPage(),
        ),
        GoRoute(
          path: RouterPath.registrationService,
          name: RouterPath.registrationService,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const RegistrationServicePage(),
        ),
        GoRoute(
          path: RouterPath.registrationWaitModerate,
          name: RouterPath.registrationWaitModerate,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const RegistrationWaitModeratePage(),
        ),
        GoRoute(
          path: RouterPath.registrationBlockModerate,
          name: RouterPath.registrationBlockModerate,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const RegistrationBlockModeratePage(),
        ),
      ],
    ),
    GoRoute(
      path: RouterPath.webView,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        return WebWidget(arguments: state.extra as WebViewArguments);
      },
    ),

    GoRoute(
      path: RouterPath.hideTalker,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final logger = getIt<Logger>();

        return HideTalkerScreen(talker: logger.talker);
      },
    ),

    ///BOTTOM BAR NAVIGATION
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainTabScreen(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _tabANavigatorKey,
          routes: [
            GoRoute(
              path: RouterPath.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouterPath.analytics,
              builder: (context, state) => const AnalyticsScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouterPath.profile,
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                  name: RouterPath.profileEdit,
                  path: RouterPath.profileEdit,
                  builder: (context, state) => const ProfileEditScreen(),
                ),
                GoRoute(
                  name: RouterPath.tariffs,
                  path: RouterPath.tariffs,
                  builder: (context, state) => const TariffsPage(),
                ),
                GoRoute(
                  name: RouterPath.policy,
                  path: RouterPath.policy,
                  builder: (context, state) => const PolicyPage(),
                ),
                GoRoute(
                  name: RouterPath.aboutApp,
                  path: RouterPath.aboutApp,
                  builder: (context, state) => const AboutAppPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
