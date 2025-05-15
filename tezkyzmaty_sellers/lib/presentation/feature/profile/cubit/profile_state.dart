part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  successUpdateName,
  successUpdateAvatar,
  successUpdatePassword,
  successTopUpBalance,
  successStartPromotion,
  failure,
}

class ProfileState extends Equatable {
  const ProfileState({
    this.profile,
    this.errorMessage = '',
    this.status = ProfileStatus.initial,
  });
  final ProfileStatus status;
  final ProfileEntity? profile;
  final String errorMessage;

  @override
  List<Object?> get props => [profile, status, errorMessage];
  ProfileState copyWith({
    ProfileEntity? profile,
    String? errorMessage,
    ProfileStatus? status,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
