// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezkyzmaty_sellers/core/constants/property.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/theme/font.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.width,
    this.height = 52,
    required this.title,
    required this.onPressed,
    this.icon,
    this.backgroundColor = TezColor.primary,
    this.textColor = TezColor.black,
    this.borderColor = TezColor.primary,
    this.iconSize = 18.0,
    this.borderRadius = 100,
    this.textCenterAlign = true,
    this.iconLeftAlign = true,
    this.spaceBetweenIcon = false,
    this.isRightIcon = false,
    this.withShadow = false,
    this.fontWeight = FontWeight.w900,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
    this.isEnable = true,
    this.picture,
    this.disableColor,
    this.textStyle,
    this.verticalPadding = 7,
    this.fontSize = PropertyConstant.md,
    this.isGradient = true,
    this.isBorder = false,
  });

  final double? width;
  final double height;
  final Function onPressed;
  final String title;
  final Widget? icon;
  final SvgPicture? picture;
  final double iconSize;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color? disableColor;
  final bool isRightIcon;
  final bool textCenterAlign;
  final bool iconLeftAlign;
  final bool spaceBetweenIcon;
  final bool withShadow;
  final FontWeight? fontWeight;
  final EdgeInsets padding;
  final bool isEnable;
  final TextStyle? textStyle;
  final double verticalPadding;
  final double fontSize;
  final bool isGradient;
  final bool isBorder;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _scale;

  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _scale = Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
    _opacity = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(_animationController);
  }

  Future<void> anim({
    required double scale,
    required double opacity,
    Duration duration = Duration.zero,
  }) async {
    _animationController.stop();
    _animationController.duration = duration;

    _scale = Tween<double>(begin: _scale.value, end: scale).animate(
      CurvedAnimation(curve: Curves.ease, parent: _animationController),
    );
    _opacity = Tween<double>(begin: _opacity.value, end: opacity).animate(
      CurvedAnimation(curve: Curves.ease, parent: _animationController),
    );
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> _onTapDown(_) {
    return anim(
      scale: 0.98,
      opacity: 0.99,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> _onTapUp() {
    return anim(
      scale: 1.0,
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> _onTapCancel(_) {
    return _onTapUp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(scale: _scale.value, child: child),
        );
      },
      child: Listener(
        onPointerDown: _onTapDown,
        onPointerCancel: _onTapCancel,
        onPointerUp: (PointerUpEvent event) {
          _onTapUp();
        },
        child: GestureDetector(
          onTap: () {
            if (widget.isEnable) {
              widget.onPressed();
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: widget.width?.w,
              // height: widget.height.h + 0.5.spMax,
              padding: widget.height < 52 ? EdgeInsets.zero : widget.padding,
              decoration: BoxDecoration(
                boxShadow:
                    widget.withShadow
                        ? [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                        ]
                        : null,

                gradient:
                    widget.isEnable && widget.isGradient
                        ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [TezColor.FFE951, TezColor.E6BF00],
                        )
                        : null,
                color:
                    widget.isEnable
                        ? widget.backgroundColor
                        : widget.disableColor ?? TezColor.disableButton,
                border: Border.all(
                  color:
                      widget.isEnable && widget.isBorder
                          ? widget.borderColor
                          : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
              ),
              child: Padding(
                padding:
                    widget.spaceBetweenIcon
                        ? EdgeInsets.symmetric(
                          horizontal: 8.0.w,
                          vertical: 8.0.h,
                        )
                        : EdgeInsets.zero,
                child: Row(
                  mainAxisSize:
                      widget.width == null
                          ? MainAxisSize.min
                          : MainAxisSize.min,
                  mainAxisAlignment:
                      widget.textCenterAlign
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                  children: _buildBlock(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBlock() {
    if (widget.icon != null || widget.picture != null) {
      if (widget.spaceBetweenIcon) {
        return [
          Expanded(child: _buildIcon()),
          Expanded(flex: 2, child: _buildTitle()),
        ];
      } else {
        if (widget.isRightIcon) {
          return [
            const SizedBox(width: 8),
            Center(child: _buildTitle()),
            _buildIcon(),
          ];
        }
        return [_buildIcon(), _buildTitle()];
      }
    }
    return [_buildTitle()];
  }

  Widget _buildTitle() {
    return Flexible(
      child: Text(
        context.tr(widget.title),
        maxLines: 2,
        textAlign: TextAlign.center,
        style:
            widget.textStyle ??
            FontConstant.bodySmallTextStyleFont(
              color:
                  widget.isEnable
                      ? widget.textColor
                      : const Color(0xFF1C1C1C).withAlpha(125),
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildIcon() {
    if (widget.icon != null || widget.picture != null) {
      return Padding(
        padding: EdgeInsets.only(right: widget.isRightIcon ? 0 : 10.w),
        child: widget.icon ?? widget.picture,
      );
    }

    return const SizedBox();
  }
}
