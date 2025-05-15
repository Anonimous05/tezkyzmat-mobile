part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  initial,
  loading,
  error,
  authenticate,
  authConfirmed,
  unAuthenticated,
}

class AuthenticationState extends Equatable {
  const AuthenticationState(
      {this.authenticationStatus = AuthenticationStatus.initial, this.profile});
  final AuthenticationStatus authenticationStatus;
  final ProfileEntity? profile;

  AuthenticationState copyWith(
      {AuthenticationStatus? authenticationStatus, ProfileEntity? profile}) {
    return AuthenticationState(
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [authenticationStatus, profile];
}
