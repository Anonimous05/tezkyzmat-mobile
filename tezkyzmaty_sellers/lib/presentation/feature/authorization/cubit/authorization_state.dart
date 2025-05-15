// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authorization_cubit.dart';

enum AuthorizationStatus {
  initial,
  loading,
  error,
  registrationSendOTPConfirmed,
  registrationOTPConfirmed,
  forgotPasswordSendOTPConfirmed,
  forgotPasswordOTPConfirmed,
  enterNewPasswordConfirmed,

  loginConfirmed,
}

class AuthorizationState extends Equatable {
  const AuthorizationState({
    this.authorizationStatus = AuthorizationStatus.initial,
    this.phone = '',
    this.errorMessage = '',
    this.token = '',
    this.isNewUser = false,
  });
  final AuthorizationStatus authorizationStatus;
  final String phone;
  final String errorMessage;
  final String token;
  final bool isNewUser;

  @override
  List<Object> get props => [authorizationStatus, phone, errorMessage];

  AuthorizationState copyWith({
    AuthorizationStatus? authorizationStatus,
    String? phone,
    String? errorMessage,
    String? token,
    bool? isNewUser,
  }) {
    return AuthorizationState(
      authorizationStatus: authorizationStatus ?? this.authorizationStatus,
      phone: phone ?? this.phone,
      errorMessage: errorMessage ?? this.errorMessage,
      token: token ?? this.token,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }
}
