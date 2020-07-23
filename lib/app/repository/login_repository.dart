import 'package:dio/dio.dart';
import 'package:flutter_dartz/app/exceptions/login_failure.dart';

import 'package:dartz/dartz.dart';

import 'i_login_repository.dart';

class LoginRepository implements ILoginRepository {
  
  @override
  Future<Either<LoginFailure, String>> login(String login, String password) async {
    try {
      final response = await Dio().post('http://localhost:8888/auth/login', data: {
        'login': login,
        'password': password
      });
      
      return right(response?.data['token']);

    } on DioError catch (e) {
      print(e);
      if(e?.response?.statusCode == 403) {
        return left(LoginNotFoundFailure());
      }

      return left(LoginServerErrorFailure(error: e.error));
    } catch(e) {
      return left(LoginServerErrorFailure(error: e.toString()));
    }
  }


}