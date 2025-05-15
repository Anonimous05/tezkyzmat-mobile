import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/home/bloc/home_bloc.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/app_unfocuser.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  HomeBloc get pageBloc => context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (currentScroll == maxScroll) {
        pageBloc.add(const FetchApplicationNextPageEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppUnfocuser(
          child: Scaffold(
            backgroundColor: TezColor.black1c,
            appBar: AppBar(
              toolbarHeight: 70.h,
              forceMaterialTransparency: true,
              backgroundColor: TezColor.black1c,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: TezMotion(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: TezColor.baseContainer,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(SVGConstant.icFilter),
                              SizedBox(width: 10.w),
                              Text(
                                tr(LocaleKeys.filter),
                                style: FontConstant.bodyLargeTextStyleFont(
                                  color: TezColor.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    TezMotion(
                      onPressed: () {},
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: TezColor.baseContainer,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: SvgPicture.asset(SVGConstant.icNotification),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  pageBloc.add(const RefreshHomePageEvent());
                },
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  decoration: BoxDecoration(
                    color: TezColor.container,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 40.h,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

int getItemCount(bool isLoading, int length, bool hasReachedEnd) {
  if (isLoading && length == 0) {
    return 6;
  }
  return length + (hasReachedEnd ? 0 : 6);
}
