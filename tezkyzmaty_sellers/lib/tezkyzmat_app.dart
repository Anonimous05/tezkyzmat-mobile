import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tezkyzmaty_sellers/core/router/router.dart';
import 'package:tezkyzmaty_sellers/core/services/firebase_messaging_service.dart';
import 'package:tezkyzmaty_sellers/core/theme/app_theme.dart';

class TezKyzmatApp extends StatefulWidget {
  const TezKyzmatApp({super.key});

  @override
  State<TezKyzmatApp> createState() => _TezKyzmatAppState();
}

class _TezKyzmatAppState extends State<TezKyzmatApp> {
  @override
  void initState() {
    super.initState();
    // initFire();
  }

  Future<void> initFire() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        return;
      }
      await NotificationHandlerService(
        context,
      ).initializeFcmNotification(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: FlutterSmartDialog.init(
        builder: (context, child) {
          return MediaQuery.withNoTextScaling(
            child: LoaderOverlay(
              overlayColor: Colors.white.withValues(alpha: 0.05),
              overlayWidgetBuilder: (p0) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              },
              child: child!,
            ),
          );
        },
      ),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      title: 'Tez Kyzmat',
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
    );
  }
}
