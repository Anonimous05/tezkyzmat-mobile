import 'package:flutter/material.dart';
// ignore_for_file: avoid_unused_constructor_parameters

class PaginationResponseResult<T> {
  const PaginationResponseResult(
      {required this.count, required this.results, this.page, this.pages});
  factory PaginationResponseResult.empty() =>
      PaginationResponseResult<T>(count: 0, results: []);

  final int count;
  final int? page;
  final int? pages;
  final List<T> results;
  PaginationResponseResult<T> copyWith(
      {int? count,
      ValueGetter<int?>? page,
      ValueGetter<int?>? pages,
      List<T>? results}) {
    return PaginationResponseResult(
        count: count ?? this.count,
        page: page != null ? page() : this.page,
        pages: pages != null ? pages() : this.pages,
        results: results ?? this.results);
  }
}

class PaginationResponseFactory {
  static PaginationResponseResult<T> fromJson<T>(
      Map<String, dynamic> jsonString,
      T Function(Map<String, dynamic>) fromJsonT) {
    final Map<String, dynamic> json;
    try {
      json = jsonString;
    } catch (e) {
      throw FormatException('Error parsing JSON: $e');
    }

    // Проверка на наличие обязательных полей и их типов
    if (json['count'] is! int) {
      throw const FormatException('Expected "count" to be an int');
    }
    final int count = json['count'] as int;

    // Проверка типа для необязательных строковых полей
    final int? page = json['page'] is int ? json['page'] as int : null;
    final int? pages = json['pages'] is int ? json['pages'] as int : null;

    // Проверка и преобразование results
    final List<dynamic> jsonResults =
        json['results'] is List ? json['results'] as List : [];
    final List<T> results;
    try {
      results = jsonResults
          .map((jsonItem) => fromJsonT(jsonItem as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw FormatException('Error converting results: $e');
    }

    return PaginationResponseResult<T>(
      count: count,
      page: page,
      pages: pages,
      results: results,
    );
  }
}
