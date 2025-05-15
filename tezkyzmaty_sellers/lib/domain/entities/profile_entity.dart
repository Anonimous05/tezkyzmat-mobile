import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';

@freezed
sealed class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    final int? id,
    final String? email,
    final String? phone,
    final bool? isVerified,
    final DateTime? created,
    final String? name,
    final String? image,
    final String? osoo,
    final String? inn,
  }) = _ProfileEntity;

  const ProfileEntity._();
}
