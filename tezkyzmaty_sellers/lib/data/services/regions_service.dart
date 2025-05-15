import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tezkyzmaty_sellers/data/models/classifiers.dart';

class RegionsService {
  factory RegionsService() => _instance;
  RegionsService._internal();
  static final RegionsService _instance = RegionsService._internal();

  List<Region>? _regions;
  List<CityDistrict>? _citiesDistricts = [];
  List<CityVillage>? _cityVillages = [];

  Future<void> loadData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/json/regions.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString) as List<dynamic>;

    _regions =
        jsonData
            .map(
              (region) => Region(
                id: region['region_id'] as int,
                title: region['region_title'] as String,
              ),
            )
            .toList();

    _citiesDistricts = [];
    _cityVillages = [];

    for (final region in jsonData) {
      // Add districts to citiesDistricts
      final districts =
          (region['districts'] as List<dynamic>)
              .map(
                (district) => CityDistrict(
                  id: district['id'] as int,
                  title: district['title'] as String,
                  regionId: region['region_id'] as int,
                  isRegion: true,
                ),
              )
              .toList();
      _citiesDistricts!.addAll(districts);

      // Process cities
      for (final city in region['cities'] as List<dynamic>) {
        final cityDistrict = CityDistrict(
          id: city['id'] as int,
          title: city['title'] as String,
          regionId: region['region_id'] as int,
          districtId: city['district_id'] as int?,
        );

        // Add cities with null district_id to citiesDistricts
        if (city['district_id'] == null) {
          _citiesDistricts!.add(cityDistrict);
        } else {
          // Add cities with non-null district_id to cityVillages
          _cityVillages!.add(
            CityVillage(
              id: city['id'] as int,
              title: city['title'] as String,
              regionId: region['region_id'] as int,
              districtId: city['district_id'] as int?,
            ),
          );
        }
      }
    }
  }

  List<Region> getRegions() {
    return _regions!;
  }

  List<CityDistrict> getCityDistrictByRegionId(int regionId) {
    return _citiesDistricts!
        .where((district) => district.regionId == regionId)
        .toList()
      ..sort((a, b) {
        if (a.isRegion == b.isRegion) {
          return 0;
        }
        return a.isRegion ? 1 : -1;
      });
  }

  List<CityVillage> getCityVillageByDistrictId(int districtId) {
    return _cityVillages!
        .where((village) => village.districtId == districtId)
        .toList();
  }

  List<CityVillage> getCityVillageByRegionId(int regionId) {
    return _cityVillages!
        .where((village) => village.regionId == regionId)
        .toList();
  }
}
