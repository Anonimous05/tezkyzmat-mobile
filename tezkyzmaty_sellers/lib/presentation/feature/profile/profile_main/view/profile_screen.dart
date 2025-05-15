// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/constants/property.dart';
import 'package:tezkyzmaty_sellers/core/router/router_path.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/text_diver.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  bool isOpenLanguage = false;

  @override
  void initState() {
    _initPackageInfo();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: TezColor.black1c,
          appBar: AppBar(
            toolbarHeight: 70.h,
            forceMaterialTransparency: true,
            backgroundColor: TezColor.black1c,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                children: [
                  state.profile?.image != null
                      ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: state.profile!.image!,
                          width: 56.r,
                          height: 56.r,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (
                            context,
                            child,
                            loadingProgress,
                          ) {
                            return Shimmer(
                              color: TezColor.surfaceTertiary,
                              child: Container(
                                width: 56.r,
                                height: 56.r,
                                color: TezColor.surfaceTertiary,
                              ),
                            );
                          },
                          errorWidget: (context, error, stackTrace) {
                            return Container(
                              width: 56.r,
                              height: 56.r,
                              color: TezColor.surfaceTertiary,
                            );
                          },
                        ),
                      )
                      : Image.asset(
                        ImageConstant.emptyAvatar,
                        height: 56.r,
                        width: 56.r,
                      ),

                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.profile?.name ?? tr(LocaleKeys.nameSurname),
                          style: FontConstant.titleMediumTextStyleFont(
                            fontSize: PropertyConstant.md2,
                            color: TezColor.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${tr(LocaleKeys.tariff)}:',
                              style: FontConstant.labelSmallTextStyleFont(
                                color: TezColor.white50,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Image.asset(
                              ImageConstant.vip,
                              height: 20.r,
                              width: 50.r,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  TezMotion(
                    onPressed: () {
                      context.pushNamed(RouterPath.profileEdit);
                    },
                    child: SvgPicture.asset(SVGConstant.icEdit),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: ProfileAuthScreen(state: state, packageInfo: _packageInfo),
          ),
        );
      },
    );
  }
}

class ProfileAuthScreen extends StatelessWidget {
  const ProfileAuthScreen({
    super.key,
    required this.state,
    required this.packageInfo,
  });

  final AuthenticationState state;
  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
      decoration: BoxDecoration(
        color: TezColor.container,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const BaseProfileListItem(),

            ListItemDeleteLogout(
              name: tr(LocaleKeys.logout),
              iconPath: SVGConstant.icLogout,
              onTapLogout: () {
                CommonUtil.showBaseDialog(
                  context,
                  title: tr(LocaleKeys.areYouSureLogout),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(LoggedOut());
                  },
                );
              },
              onTapDelete: () {
                CommonUtil.showBaseDialog(
                  context,
                  title: tr(LocaleKeys.deleteAccountConfirm),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(DeleteAccount());
                    context.read<AuthenticationBloc>().add(LoggedOut());
                  },
                );
              },
              secondText: tr(LocaleKeys.deleteAccount),
            ),
            SizedBox(height: 24.h),

            if (packageInfo.version != 'Unknown')
              Center(
                child: GestureDetector(
                  onLongPress: () {
                    context.push(RouterPath.hideTalker);
                  },
                  child: Text(
                    '${packageInfo.version} (${packageInfo.buildNumber})',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.name,
    required this.iconPath,
    required this.onTap,
    this.isDelete = false,
    this.secondText = '',
    this.isNeedChevron = true,
  });
  final String name;
  final String secondText;
  final String iconPath;
  final Function() onTap;
  final bool isDelete;
  final bool isNeedChevron;

  @override
  Widget build(BuildContext context) {
    return TezMotion(
      onPressed: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: TezColor.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 23.r, horizontal: 20.w),
        child: Row(
          children: [
            if (iconPath.isNotEmpty) SvgPicture.asset(iconPath),
            if (iconPath.isNotEmpty) SizedBox(width: 10.w),
            Expanded(
              child:
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontConstant.labelMediumTextStyleFont(
                      fontWeight: FontWeight.w500,
                      color:
                          isDelete ? TezColor.textError : TezColor.textHeading,
                    ),
                  ).tr(),
            ),
            if (secondText.isNotEmpty)
              Text(
                secondText,
                style: FontConstant.bodyMediumTextStyleFont(
                  color: TezColor.textBody,
                ),
              ),
            if (secondText.isNotEmpty) SizedBox(width: 8.w),
            if (!isDelete)
              if (isNeedChevron)
                Icon(
                  CupertinoIcons.chevron_right,
                  color:
                      isDelete
                          ? TezColor.textError
                          : TezColor.iconOnActionSecondary,
                  size: 12.r,
                ),
          ],
        ),
      ),
    );
  }
}

class ListItemDeleteLogout extends StatelessWidget {
  const ListItemDeleteLogout({
    super.key,
    required this.name,
    required this.iconPath,
    required this.onTapLogout,
    required this.onTapDelete,

    required this.secondText,
  });
  final String name;
  final String secondText;
  final String iconPath;
  final Function() onTapLogout;
  final Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: TezColor.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 23.r, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TezMotion(
            onPressed: onTapLogout,
            child: Row(
              children: [
                SvgPicture.asset(iconPath),
                SizedBox(width: 10.w),
                Expanded(
                  child:
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FontConstant.labelMediumTextStyleFont(
                          fontWeight: FontWeight.w500,
                          color: TezColor.textHeading,
                        ),
                      ).tr(),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          const CustomDivider(),
          SizedBox(height: 20.h),
          TezMotion(
            onPressed: onTapDelete,
            child: Text(
              secondText,
              style: FontConstant.bodySmallTextStyleFont(color: TezColor.error),
            ),
          ),
        ],
      ),
    );
  }
}

class BaseProfileListItem extends StatelessWidget {
  const BaseProfileListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListItem(
          name: LocaleKeys.myBusiness,
          iconPath: SVGConstant.icMyBusiness,
          onTap: () {},
        ),
        ListItem(
          name: LocaleKeys.analytics_title,
          iconPath: SVGConstant.icAnalytics,
          onTap: () {},
        ),
        ListItem(
          name: LocaleKeys.filterByAutoParts,
          iconPath: SVGConstant.icFilterByAutoParts,
          onTap: () {},
        ),
        ListItem(
          name: LocaleKeys.tarrifs_title,
          iconPath: SVGConstant.icTarrifs,
          onTap: () {
            context.pushNamed(RouterPath.tariffs);
          },
        ),
        ListItem(
          name: LocaleKeys.aboutApp,
          iconPath: SVGConstant.icAboutUs,
          onTap: () {
            context.pushNamed(RouterPath.aboutApp);
          },
        ),
        ListItem(
          name: LocaleKeys.privacyPolicy,
          iconPath: SVGConstant.icPrivacyP,
          onTap: () {
            context.pushNamed(RouterPath.policy);
          },
        ),
      ],
    );
  }
}
