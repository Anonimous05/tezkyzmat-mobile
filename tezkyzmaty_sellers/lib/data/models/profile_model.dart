// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tezkyzmaty_sellers/core/constants/end_point.dart';
import 'package:tezkyzmaty_sellers/domain/entities/profile_entity.dart';

class ProfileModel {
  ProfileModel({
    this.id,
    this.email,
    this.phone,
    this.isVerified,
    this.created,
    this.name,
    this.image,
  });
  final int? id;
  final String? email;
  final String? phone;
  final bool? isVerified;
  final DateTime? created;
  final String? name;
  final String? image;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'phone': phone,
      'is_verified': isVerified,
      'created': created?.millisecondsSinceEpoch,
      'name': name,
      'image': image,

    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      isVerified:
          map['is_verified'] != null ? map['is_verified'] as bool : null,
      created:
          map['created'] != null
              ? DateTime.parse(map['created'] as String).toUtc()
              : null,
      name: map['name'] != null ? map['name'] as String : null,
      image:
          map['image'] != null
              ? (map['image'] as String).contains('http')
                  ? map['image'] as String
                  : '${EndPointConstant().baseUrlNoVersion}/${map['image'] as String}'
              : null,

    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension ProfileExtension on ProfileModel {
  ProfileEntity toDomain() => ProfileEntity(
    id: id,
    email: email,
    phone: phone,
    isVerified: isVerified,
    created: created,
    name: name,
    image: image,

  );
}
