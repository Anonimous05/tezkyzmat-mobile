import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_general_constants.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_prefs_consts.dart';
import 'package:tezkyzmaty_sellers/core/utils/extension.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';

void setLocaleToPrefs(String localeCode) {
  final prefs = getIt<SharedPreferences>();
  final localeCodeBack = localeCodeToBack(localeCode);

  prefs.setString(GlobalPrefsConst.lang, localeCode);
  prefs.setString(GlobalPrefsConst.langToBack, localeCodeBack);
}

String getLocaleFromPrefs(bool isBackend) {
  final prefs = getIt<SharedPreferences>();
  if (isBackend) {
    return prefs.getString(GlobalPrefsConst.langToBack) ??
        GlobalGeneralConsts.ru;
  }
  return prefs.getString(GlobalPrefsConst.lang) ?? GlobalGeneralConsts.ru;
}

bool validateInput(String input) {
  if (RegExp(r'^\d{9}').hasMatch(input)) {
    return true;
  }
  return false;
}

String formatPrice(String price) {
  if (price.isEmpty) {
    return '0';
  }

  try {
    // Parse the string to double
    final double parsedPrice = double.parse(price);

    // Check if it's an integer value
    if (parsedPrice == parsedPrice.toInt()) {
      // Format as integer with thousand separators
      return parsedPrice.toInt().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
    } else {
      // Format with up to 2 decimal places and thousand separators
      String formattedPrice = parsedPrice.toStringAsFixed(2);

      // Remove trailing zeros after decimal point
      if (formattedPrice.endsWith('.00')) {
        formattedPrice = formattedPrice.substring(0, formattedPrice.length - 3);
      } else if (formattedPrice.endsWith('0')) {
        formattedPrice = formattedPrice.substring(0, formattedPrice.length - 1);
      }

      // Add thousand separators
      final List<String> parts = formattedPrice.split('.');
      parts[0] = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );

      return parts.length > 1 ? '${parts[0]}.${parts[1]}' : parts[0];
    }
  } catch (e) {
    return '0';
  }
}
