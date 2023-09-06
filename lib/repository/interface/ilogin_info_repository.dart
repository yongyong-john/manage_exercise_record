import 'package:shared_preferences/shared_preferences.dart';

part 'package:manage_exercise_records/repository/login_info_repository.dart';

abstract class ILoginInfoRepository {
  Future<void> setLoginInfo(bool loginState);
  Future<bool> getLoginInfo();
}
