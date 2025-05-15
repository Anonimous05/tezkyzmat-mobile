import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/domain/repository/user_repository.dart';

@LazySingleton()
class ApplicationUseCase {
  ApplicationUseCase(this.repository);
  final UserRepository repository;
}
