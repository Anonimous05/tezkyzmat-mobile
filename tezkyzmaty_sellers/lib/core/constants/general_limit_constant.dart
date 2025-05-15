class GeneralLimitConstant {
  static const int innLimit = 14;
  static const int legalEntityMaxLimit = 255;
  static const int legalEntityMinLimit = 2;
  static const int baseLimit = 50;

  static bool isMinimumPasswordLength(String input) {
    return input.length >= 8;
  }

  static int getPhoneLimit(String input) {
    if (RegExp(r'^\d+$').hasMatch(input)) {
      return 30;
    }
    return -1;
  }
}
