import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/screens/MainScreen.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBarWidget.myAppBar(),
        backgroundColor: Theme.of(context).backgroundColor,
        body: _loading
            ? ProgessBar()
            : Container(
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
                      InputTextFieldWidget("Email", _emailController,
                          Icons.email, TextInputType.emailAddress),
                      InputTextFieldWidget("Password", _passwordController,
                          Icons.security, TextInputType.visiblePassword),
                    ],
                  ),
                ),
              ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              print("hello");
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                _onLoading();
                await Provider.of<Auth>(context, listen: false)
                    .login(_emailController.text, _passwordController.text);
                _onLoading();
                if (Provider.of<Auth>(context, listen: false).isAuth()) {
                  Navigator.of(context)
                      .pushReplacementNamed(MainScreen.routeName);
                } else {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Eroooorr')));
                }
            } else {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Eroooorr')));
              }
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.login),
          );
        }),
      ),
    );
  }
}
