import 'package:easy_localization/easy_localization.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_general_constants.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

final phoneInputFormatter = MaskTextInputFormatter(
  mask: '+996 ### ## ## ##',
  filter: {'#': RegExp(r'[0-9]')},
);

String? convertDateToBackEndFormat(String? inputDate) {
  if (inputDate != null && inputDate.isNotEmpty) {
    // Parse the input date string into a DateTime object using the initial format
    final DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(inputDate);

    // Format the DateTime object into the desired output format
    final String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    return formattedDate;
  }
  return null;
}

String? convertDateToFrontEndFormat(String? inputDate) {
  if (inputDate != null) {
    // Parse the input date string into a DateTime object using the initial format
    final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(inputDate);

    // Format the DateTime object into the desired output format
    final String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);

    return formattedDate;
  }
  return null;
}

String localeCodeToBack(String locale) {
  if (locale.contains(GlobalGeneralConsts.ru)) {
    return GlobalGeneralConsts.ru;
  } else if (locale.contains(GlobalGeneralConsts.ky)) {
    return GlobalGeneralConsts.ky;
  } else {
    return GlobalGeneralConsts.ru;
  }
}
