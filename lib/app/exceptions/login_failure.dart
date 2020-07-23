
class LoginFailure implements Exception{}

class LoginServerErrorFailure extends LoginFailure{
  final String error;
  LoginServerErrorFailure({this.error});
}

class LoginNotFoundFailure extends LoginFailure {}