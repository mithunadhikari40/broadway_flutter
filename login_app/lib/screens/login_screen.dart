import 'package:flutter/material.dart';
import 'package:login_app/mixing/validation_mixing.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixing {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(12.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _buildEmailTextField(),
            _buildPasswodTextField(),
            Container(
              margin: EdgeInsets.only(top: 12.0),
            ),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "someone@example.com",
        labelText: "Email",
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget _buildPasswodTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "password",
        labelText: "Password",
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print("The email is $email and the password is $password");
        }
      },
      child: Text("Submit"),
    );
  }
}
