import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezkyzmaty_sellers/core/api_response/api_response.dart';
import 'package:tezkyzmaty_sellers/core/error/failures.dart';
import 'package:tezkyzmaty_sellers/data/models/profile_model.dart';

const cachedProfileKey = 'CACHED_PROFILE';

abstract class LocalUserRepository {
  Future<Either<Failure, ProfileModel?>> fetchProfile();

  Future<bool> saveProfile({required ProfileModel profile});
}

@LazySingleton(as: LocalUserRepository)
class LocalUserRepositoryImpl implements LocalUserRepository {
  LocalUserRepositoryImpl({required SharedPreferences sharedPreferences})
    : _sharedPref = sharedPreferences;
  final SharedPreferences _sharedPref;

  @override
  Future<Either<Failure, ProfileModel?>> fetchProfile() async {
    try {
      final jsonString = _sharedPref.getString(cachedProfileKey);

      if (jsonString != null) {
        final profile = ProfileModel.fromJson(jsonString);
        return Right(profile);
      } else {
        return const Left(Failure.notFoundFailure('Base Error'));
      }
    } catch (e) {
      if (e is NotFoundException) {
        return Left(Failure.notFoundFailure(e.message!));
      } else if (e is ErrorException) {
        return Left(Failure.errorFailure(e.message!));
      } else if (e is UnauthorizedException) {
        rethrow;
      }
      return Left(Failure.errorFailure(e.toString()));
    }
  }

  @override
  Future<bool> saveProfile({required ProfileModel profile}) {
    final jsonString = profile.toJson();
    return _sharedPref.setString(cachedProfileKey, jsonString);
  }
}
