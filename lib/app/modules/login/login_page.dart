import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dartz/app/exceptions/login_failure.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  void initState() {
    super.initState();
    reaction((_) => controller.failure, (_) {
      // controller.failure.fold(
      //   () => null,
      //   (a) => null,
      // );
      controller.failure.map((failure) {
        String message;
        if(failure is LoginNotFoundFailure) {
          message = 'Login ou senha inválidos';
        }else {
          message = 'Erro ao realizar Login';
        }

        EdgeAlert.show(
          context,
          title: 'Erro',
          description: message,
          gravity: EdgeAlert.TOP,
          duration: EdgeAlert.LENGTH_SHORT,
          backgroundColor: Colors.red,
          icon: Icons.error
        );

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: controller.loginController,
                decoration: InputDecoration(labelText: 'Login'),
              ),
              TextFormField(
                controller: controller.passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              RaisedButton(
                onPressed: () => controller.login(),
                child: Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
