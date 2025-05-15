import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:tezkyzmaty_sellers/data/models/temp_image_item.dart';
import 'package:tezkyzmaty_sellers/generated/locale_keys.g.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';

class ImageGalleryWidget extends StatefulWidget {
  const ImageGalleryWidget({
    super.key,
    required this.images,
    required this.onDelete,
    this.currentIndex = 0,
  });
  final List<TempImageItem> images;
  final void Function(TempImageItem) onDelete;
  final int currentIndex;

  @override
  State<ImageGalleryWidget> createState() => _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends State<ImageGalleryWidget> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    if (_currentIndex != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(_currentIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const Center(child: Text('Нет изображений'));
    }
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 300.h,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.images.length,
                    controller: _pageController,
                    onPageChanged:
                        (i) => this.setState(() => _currentIndex = i),
                    itemBuilder: (context, i) {
                      final item = widget.images[i];
                      return Stack(
                        children: [
                          Center(
                            child:
                                item.imageFile != null
                                    ? Image.file(
                                      item.imageFile!,
                                      fit: BoxFit.contain,
                                    )
                                    : (item.imageNetwork != null
                                        ? Image.network(
                                          item.imageNetwork!,
                                          fit: BoxFit.contain,
                                        )
                                        : const SizedBox()),
                          ),
                          Positioned(
                            top: 64.h,
                            right: 16.w,
                            child: TezMotion(
                              child: Container(
                                width: 45.w,
                                height: 45.w,
                                decoration: BoxDecoration(
                                  color: TezColor.black.withAlpha(170),
                                  borderRadius: BorderRadius.circular(9.r),
                                ),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 32.r,
                                ),
                              ),
                              onPressed: () {
                                CommonUtil.showBaseDialog(
                                  context,
                                  title: tr(LocaleKeys.areYouSureDeletePhoto),
                                  onPressed: () {
                                    widget.onDelete(item);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 20.h),
                SizedBox(
                  height: 70.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.chevron_left,
                          color: Colors.white,
                        ),
                        onPressed:
                            _currentIndex > 0
                                ? () {
                                  this.setState(() {
                                    _currentIndex--;
                                    _pageController.previousPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                }
                                : null,
                      ),
                      SizedBox(
                        width: 192.w,
                        child: Center(
                          child: Wrap(
                            spacing: 4.w,
                            runSpacing: 4.h,
                            alignment: WrapAlignment.center,
                            children: [
                              for (int i = 0; i < widget.images.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    if (i >= 0 && i < widget.images.length) {
                                      this.setState(() {
                                        _currentIndex = i;
                                        _pageController.animateToPage(
                                          i,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 56.w,
                                    height: 56.w,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: Border.all(
                                        color:
                                            i == _currentIndex
                                                ? Colors.yellow
                                                : TezColor.borderPrimary,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.r),
                                      child:
                                          widget.images[i].imageFile != null
                                              ? Image.file(
                                                widget.images[i].imageFile!,
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              )
                                              : (widget
                                                          .images[i]
                                                          .imageNetwork !=
                                                      null
                                                  ? Image.network(
                                                    widget
                                                        .images[i]
                                                        .imageNetwork!,
                                                    width: 60,
                                                    height: 60,
                                                    fit: BoxFit.cover,
                                                  )
                                                  : const SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                  )),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.chevron_right,
                          color: Colors.white,
                        ),
                        onPressed:
                            _currentIndex < widget.images.length - 1
                                ? () {
                                  this.setState(() {
                                    _currentIndex++;
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                }
                                : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
