import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:tezkyzmaty_sellers/core/utils/common_utils.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  final url0 = Uri.parse(url);
  if (!await launchUrl(url0, mode: LaunchMode.externalApplication)) {
    // <--
    throw Exception('Could not launch $url0');
  }
}

Future<void> launchMailTo(BuildContext context) async {
  String mailLink() {
    return 'mailto:info@tezkyzmaty_sellers.org';
  }

  await launchSupport(
    iosLink: mailLink(),
    androidLink: mailLink(),
    context: context,
  );
}

Future<void> launchSupport({
  required String iosLink,
  required String androidLink,
  required BuildContext context,
}) async {
  Uri uri;
  if (Platform.isIOS) {
    uri = Uri.parse(iosLink);
  } else {
    uri = Uri.parse(androidLink);
  }
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (exc) {
      if (context.mounted) {
        CommonUtil.showSnackBar(context, 'Error');
      }
    }
  }
}
