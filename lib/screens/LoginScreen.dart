import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/screens/MainScreen.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/ErrorModel.dart';

import '../widgets/InputTextFieldWidget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.myAppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _loading
          ? ProgessBar()
          : Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                      InputTextFieldWidget(
                        "Email",
                        _emailController,
                        Icons.email,
                        TextInputType.emailAddress,
                      ),
                      InputTextFieldWidget(
                        "Password",
                        _passwordController,
                        Icons.security,
                        TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _onLoading();
                ErrorModel flag =
                    await Provider.of<Auth>(context, listen: false).login(
                  _emailController.text,
                  _passwordController.text,
                );
                print(flag.status);
                _onLoading();
                if (flag.status == true) {
                  Navigator.of(context).pushReplacementNamed(
                    MainScreen.routeName,
                  );
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        flag.message.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                }
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Error",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              }
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.login),
          );
        },
      ),
    );
  }
}
