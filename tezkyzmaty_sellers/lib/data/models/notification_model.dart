import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Notify {
  final int id;
  final String title;
  final String body;
  final bool isRead;
  final String date;
  Notify({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'is_read': isRead,
      'created_at': date,
    };
  }

  factory Notify.fromMap(Map<String, dynamic> map) {
    return Notify(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      isRead: map['is_read'] as bool,
      date: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notify.fromJson(String source) =>
      Notify.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Notifys {
  final List<Notify> notifyList;
  const Notifys({
    this.notifyList = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'NotifyList': notifyList.map((x) => x.toMap()).toList(),
    };
  }

  factory Notifys.fromMap(List<dynamic> map) {
    return Notifys(
      notifyList: List<Notify>.from(
        map.map<Notify>(
          (x) => Notify.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());
}
