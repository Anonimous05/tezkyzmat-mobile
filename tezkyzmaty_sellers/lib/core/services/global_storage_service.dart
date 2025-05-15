import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_general_constants.dart';
import 'package:tezkyzmaty_sellers/core/constants/global_prefs_consts.dart';

class Storage {
  factory Storage() => _instance;

  Storage._internal();

  static final Storage _instance = Storage._internal();

  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String token = GlobalGeneralConsts.empty;

  Future<void> deleteTokens() async {
    await Storage().secureStorage.delete(key: GlobalPrefsConst.accessToken);
  }
}
