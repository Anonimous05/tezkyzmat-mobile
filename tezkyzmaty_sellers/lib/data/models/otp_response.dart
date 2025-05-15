import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class  SendOTPSerializerOut {
  final String token;
  final String? status;
  final String description;
  SendOTPSerializerOut({
    required this.token,
    required this.status,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'status': status,
      'description': description,
    };
  }

  factory SendOTPSerializerOut.fromMap(Map<String, dynamic> map) {
    return SendOTPSerializerOut(
      token: map['token'] as String,
      status: map['status']?.toString(),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendOTPSerializerOut.fromJson(String source) =>
      SendOTPSerializerOut.fromMap(json.decode(source) as Map<String, dynamic>);
}
