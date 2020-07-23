import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dartz/app/exceptions/login_failure.dart';
import 'package:flutter_dartz/app/repository/i_login_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final ILoginRepository _repository;
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @observable
  bool loading = false;

  @observable
  Option<LoginFailure> failure;

  _LoginControllerBase(this._repository);

  @action
  Future<void> login() async {
    loading = true;
    failure = none();

    final loginResult = await _repository.login(loginController.text, passwordController.text);
    loginResult.fold(
      (failureResult) {
        failure = optionOf(failureResult);
        loading = false;
      },
      (token) async {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('access_token', token);
        loading = false;
        Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
      },
    );
  }
}
