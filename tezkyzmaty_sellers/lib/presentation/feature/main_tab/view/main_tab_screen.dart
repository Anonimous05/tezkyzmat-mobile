import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/profile/cubit/profile_cubit.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/components/custom_bottom_nav_bar_item.dart';

class MainTabScreen extends StatelessWidget {
  MainTabScreen(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;
  final CustomBottomNavBarItem customBottomNavBarItem =
      CustomBottomNavBarItem();

  @override
  Widget build(
    BuildContext context,
  ) => BlocListener<AuthenticationBloc, AuthenticationState>(
    listener: (context, state) {
      if (state.authenticationStatus == AuthenticationStatus.authenticate) {
        // context.go(RouterPath.home);
        context.read<ProfileCubit>().initData(state.profile);
      }
      if (state.authenticationStatus == AuthenticationStatus.authConfirmed) {
        context.go(RouterPath.home);
      }
      if (state.authenticationStatus == AuthenticationStatus.unAuthenticated) {
        context.go(RouterPath.signup);
        context.read<ProfileCubit>().initData(null);
      }
    },
    child: Scaffold(
      body: navigationShell,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _bottomNavigationBarWidget(context),
    ),
  );

  Widget _bottomNavigationBarWidget(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(color: TezColor.disableButton, width: 1.r),
      ),
    ),
    child: Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        onTap: (value) {
          _onDestinationSelected(value, context);
        },

        backgroundColor: TezColor.white,
        currentIndex: navigationShell.currentIndex,
        iconSize: 24.r,
        showSelectedLabels: true,
        unselectedFontSize: 12.sp,
        showUnselectedLabels: true,
        unselectedItemColor: TezColor.inActiveTab,
        selectedItemColor: TezColor.black1c,
        selectedFontSize: 12.sp,
        selectedLabelStyle: FontConstant.bodySmallTextStyleFont(
          color: TezColor.black1c,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: FontConstant.bodySmallTextStyleFont(
          color: TezColor.black70,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          customBottomNavBarItem.getItem(
            selectedIndex: navigationShell.currentIndex,
            activeImageName: SVGConstant.icHome,
            itemIndex: 0,
            label: LocaleKeys.applications,
          ),
          customBottomNavBarItem.getItem(
            selectedIndex: navigationShell.currentIndex,
            activeImageName: SVGConstant.icAnalyticsTab,
            itemIndex: 1,
            label: LocaleKeys.analytics_title,
          ),

          customBottomNavBarItem.getItem(
            selectedIndex: navigationShell.currentIndex,
            activeImageName: SVGConstant.icProfile,
            itemIndex: 2,
            label: LocaleKeys.profile,
          ),
        ],
      ),
    ),
  );

  Future<void> _onDestinationSelected(int index, BuildContext context) async {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
