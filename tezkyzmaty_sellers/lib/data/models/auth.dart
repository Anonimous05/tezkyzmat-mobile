// ignore_for_file: avoid_bool_literals_in_conditional_expressions

class Auth {
  const Auth({
    required this.access,
    required this.refresh,
    required this.isNewUser,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      access: json['access_token'] as String,
      refresh: json['refresh_token'] as String,
      isNewUser: json['new_user'] != null ? json['new_user'] as bool : false,
    );
  }
  final String access;
  final String refresh;
  final bool isNewUser;
}
