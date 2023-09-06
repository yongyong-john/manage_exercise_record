part of 'package:manage_exercise_records/repository/interface/ilogin_info_repository.dart';

class LoginInfoRepository extends ILoginInfoRepository {
  final String _keyLoginInfo = 'isLoginInfo';
  @override
  Future<bool> getLoginInfo() async {
    final prefsLoginInfo = await SharedPreferences.getInstance();
    var loginInfo = prefsLoginInfo.getBool(_keyLoginInfo) ?? false;
    return loginInfo;
  }

  @override
  Future<void> setLoginInfo(bool loginState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoginInfo, loginState);
  }
}
