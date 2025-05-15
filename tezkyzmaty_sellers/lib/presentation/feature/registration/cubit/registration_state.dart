part of 'registration_cubit.dart';

enum RegistrationStatus {
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

class RegistrationState extends Equatable {
  const RegistrationState({
    this.registrationStatus = RegistrationStatus.initial,
    this.phone = '',
    this.profile,
    this.errorMessage = '',
  });
  final RegistrationStatus registrationStatus;
  final String phone;
  final ProfileEntity? profile;
  final String errorMessage;

  @override
  List<Object?> get props => [registrationStatus, phone, errorMessage, profile];

  RegistrationState copyWith({
    RegistrationStatus? registrationStatus,
    String? phone,
    String? errorMessage,
    ProfileEntity? profile,
  }) {
    return RegistrationState(
      registrationStatus: registrationStatus ?? this.registrationStatus,
      phone: phone ?? this.phone,
      errorMessage: errorMessage ?? this.errorMessage,
      profile: profile ?? this.profile,
    );
  }
}
