abstract class LoginEvent {}

class CheckMatchPassword extends LoginEvent {
  final String? password;
  CheckMatchPassword(this.password);
}

class LoadLoginInfo extends LoginEvent {
  LoadLoginInfo();
}
