import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    super.key,
    required this.raduis,
    required this.networkImage,
  });
  final double raduis;
  final String networkImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: raduis,
      width: raduis,
      child:
          networkImage.isNotEmpty
              ? CircleAvatar(
                radius: raduis,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: networkImage,
                    height: raduis,
                    width: raduis,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (
                      context,
                      child,
                      loadingProgress,
                    ) {
                      return Shimmer(
                        color: TezColor.surfaceTertiary,
                        child: Container(
                          height: raduis,
                          width: raduis,
                          color: TezColor.surfaceTertiary,
                        ),
                      );
                    },
                    errorWidget: (context, error, stackTrace) {
                      return CircleAvatar(
                        radius: raduis,
                        backgroundColor: Colors.black,
                        child: SvgPicture.asset(SVGConstant.icProfile),
                      );
                    },
                  ),
                ),
              )
              : CircleAvatar(
                radius: raduis,
                child: SvgPicture.asset(
                  SVGConstant.icProfile,
                  height: raduis,
                  width: raduis,
                  fit: BoxFit.fill,
                ),
              ),
    );
  }
}
