import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/screens/MainScreen.dart';
import 'package:HomeTreatment/widgets/AppBarWidget.dart';
import 'package:HomeTreatment/widgets/ProgessBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/InputTextFieldWidget.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  final TextEditingController _contactController = new TextEditingController();

  final TextEditingController _ageController = new TextEditingController();

  final TextEditingController _genderController = new TextEditingController();

  final TextEditingController _nameController = new TextEditingController();

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
                          "Sign Up",
                          style: Theme.of(context).textTheme.headline4,
                        )),
                      ),
                      InputTextFieldWidget("Name", _nameController,
                          Icons.perm_identity, TextInputType.name),
                      InputTextFieldWidget("Email", _emailController,
                          Icons.email, TextInputType.emailAddress),
                      InputTextFieldWidget("Password", _passwordController,
                          Icons.security, TextInputType.visiblePassword),
                      InputTextFieldWidget("Contact", _contactController,
                          Icons.contact_phone, TextInputType.phone),
                      InputTextFieldWidget("Gender", _genderController,
                          Icons.people, TextInputType.name),
                      InputTextFieldWidget("Age", _ageController,
                          Icons.person_add, TextInputType.number),
                    ],
                  ),
                ),
              ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              print("hello");
              _onLoading();
              await Provider.of<Auth>(context, listen: false).signUp(
                  _nameController.text,
                  _emailController.text,
                  _contactController.text,
                  _passwordController.text,
                  _genderController.text,
                  _ageController.text);
              _onLoading();
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                _onLoading();
                await Provider.of<Auth>(context, listen: false).signUp(
                    _nameController.text,
                    _emailController.text,
                    _contactController.text,
                    _passwordController.text,
                    _genderController.text,
                    _ageController.text);
                _onLoading();
                Navigator.of(context)
                    .pushReplacementNamed(MainScreen.routeName);
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
