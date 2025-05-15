part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  const LoggedIn({
    required this.token,
    required this.refreshToken,
    required this.save,
  });

  final String token;
  final String refreshToken;
  final bool save;

  @override
  List<Object> get props => [token, save, refreshToken];
}

class LoggedOut extends AuthenticationEvent {}

class DeleteAccount extends AuthenticationEvent {}

class UpdateProfile extends AuthenticationEvent {
  const UpdateProfile({required this.profile});
  final ProfileEntity? profile;
}
