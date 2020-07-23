import 'package:dartz/dartz.dart';
import 'package:flutter_dartz/app/exceptions/login_failure.dart';

abstract class ILoginRepository {
  Future<Either<LoginFailure, String>> login(String login, String password);
}