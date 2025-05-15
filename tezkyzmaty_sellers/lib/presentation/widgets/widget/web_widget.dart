// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tezkyzmaty_sellers/core/constants/asset_image.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';
import 'package:tezkyzmaty_sellers/presentation/widgets/widget/dealz_motion.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewArguments {
  final String url;
  final String title;
  WebViewArguments({required this.url, required this.title});
}

class WebWidget extends StatefulWidget implements PreferredSizeWidget {
  const WebWidget({super.key, required this.arguments});

  final WebViewArguments arguments;

  @override
  State<WebWidget> createState() => _WebWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _WebWidgetState extends State<WebWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams(),
        );

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('Page is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.arguments.url));
    // setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(Colors.white);
    }
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        forceMaterialTransparency: true,
        toolbarHeight: widget.preferredSize.height,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 4),
          child: TezMotion(
            onPressed: () {
              context.pop();
            },
            child: SvgPicture.asset(
              SVGConstant.icBack,
              width: 20.h,
              height: 20.h,
              fit: BoxFit.none,
              colorFilter: const ColorFilter.mode(
                TezColor.iconPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: Text(widget.arguments.title),
        actions: <Widget>[NavigationControls(webViewController: _controller)],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TezMotion(
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {}
          },
          child: SvgPicture.asset(
            SVGConstant.icBack,
            width: 20.h,
            height: 20.h,
            fit: BoxFit.none,
            colorFilter: const ColorFilter.mode(
              TezColor.iconPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
        TezMotion(
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {}
          },
          child: Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              SVGConstant.icBack,
              width: 20.h,
              height: 20.h,
              fit: BoxFit.none,
              colorFilter: const ColorFilter.mode(
                TezColor.iconPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.replay, color: TezColor.iconPrimary, size: 19.h),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
