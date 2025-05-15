// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Region {
  const Region({
    required this.id,
    required this.title,
    this.createdAt,
    this.updatedAt,
  });
  final int id;
  final String title;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      id: map['id'] as int,
      title: map['title'] as String,
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'] as String)
              : null,
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'] as String)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) =>
      Region.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CityDistrict {
  const CityDistrict({
    required this.id,
    required this.title,
    required this.regionId,
    this.districtId,
    this.createdAt,
    this.updatedAt,
    this.isRegion = false,
  });

  final int id;
  final String title;
  final int regionId;
  final int? districtId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isRegion;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'region_id': regionId,
      'district_id': districtId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory CityDistrict.fromMap(Map<String, dynamic> map) {
    return CityDistrict(
      id: map['id'] as int,
      title: map['title'] as String,
      regionId: map['region_id'] as int,
      districtId: map['district_id'] as int?,
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'] as String)
              : null,
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'] as String)
              : null,
      isRegion: !map.containsKey('district_id'),
    );
  }

  String toJson() => json.encode(toMap());

  factory CityDistrict.fromJson(String source) =>
      CityDistrict.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CityVillage {
  const CityVillage({
    required this.id,
    required this.title,
    required this.regionId,
    this.districtId,
    this.createdAt,
    this.updatedAt,
    this.isRegion = false,
  });

  final int id;
  final String title;
  final int regionId;
  final int? districtId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isRegion;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'region_id': regionId,
      'district_id': districtId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory CityVillage.fromMap(Map<String, dynamic> map) {
    return CityVillage(
      id: map['id'] as int,
      title: map['title'] as String,
      regionId: map['region_id'] as int,
      districtId: map['district_id'] as int?,
      createdAt:
          map['created_at'] != null
              ? DateTime.parse(map['created_at'] as String)
              : null,
      updatedAt:
          map['updated_at'] != null
              ? DateTime.parse(map['updated_at'] as String)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityVillage.fromJson(String source) =>
      CityVillage.fromMap(json.decode(source) as Map<String, dynamic>);
}
