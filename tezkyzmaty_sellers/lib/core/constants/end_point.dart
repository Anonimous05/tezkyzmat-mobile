class EndPointConstant {
  //Factory constructor, use the factory keyword when you need the constructor to not create a new object each time.
  factory EndPointConstant() => _instance;

  //Internal constructor
  EndPointConstant._internal();
  static final EndPointConstant _instance = EndPointConstant._internal();

  late String baseUrlNoVersion,
      baseUrlNoVersion2,
      authUrl,
      sendCodeUrl,
      verifyCodeUrl,
      forgotPasswordUrl,
      resetPasswordUrl,
      login,
      refreshTokenUrl,
      verifyTokenUrl,
      profileUrl,
      deleteProfileUrl,
      updatePasswordUrl,
      notificationUrl,
      topUpBalanceUrl,
      restorePasswordUrl,
      enterNewPasswordUrl,
      otpVerifyRestorePasswordUrl;

  late Map<String, dynamic> baseHeader;

  Future<void> init() async {
    _collectionOfApi(
      baseUrl: 'https://api.tezkyzmat.com.kg',
      apiVersionPublic: 'api/public/v1',
      apiVersionPrivate: 'api/private/v1',
    );
  }

  void _collectionOfApi({
    required String baseUrl,
    required String apiVersionPublic,
    required String apiVersionPrivate,
  }) {
    baseUrlNoVersion = baseUrl;
    baseUrlNoVersion2 = 'https://api.tezkyzmat.com.kg';

    authUrl = '$baseUrl/$apiVersionPublic/auth';
    sendCodeUrl = '$authUrl/send-code/';
    verifyCodeUrl = '$authUrl/verify-code/';
    forgotPasswordUrl = '$authUrl/forgot-password/';
    resetPasswordUrl = '$authUrl/reset-password/';
    login = '$authUrl/login/';

    refreshTokenUrl = '$authUrl/refresh';
    verifyTokenUrl = '$authUrl/verify';

    profileUrl = '$baseUrl/$apiVersionPrivate/users/me';
    deleteProfileUrl = '$baseUrl/$apiVersionPrivate/users/me';
    updatePasswordUrl = '$baseUrl/$apiVersionPrivate/users/me/set_password';

    notificationUrl =
        '$baseUrl/$apiVersionPrivate/notifications/notifications/';

    topUpBalanceUrl = '$profileUrl/top_up/';

    restorePasswordUrl = '$authUrl/forgot_password';
    enterNewPasswordUrl = '$authUrl/reset_password';
    otpVerifyRestorePasswordUrl = '$authUrl/validate_reset_otp';
  }
}
