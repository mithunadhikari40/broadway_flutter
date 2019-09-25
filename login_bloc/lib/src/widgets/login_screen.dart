import 'package:flutter/material.dart';
import 'package:login_bloc/src/bloc/bloc.dart';
import 'package:login_bloc/src/bloc/bloc_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          buildEmailField(bloc),
          buildPasswordField(bloc),
          Container(
            margin: EdgeInsets.only(top: 12.0),
          ),
          buildSubmitButton(bloc),
        ],
      ),
    );
  }

  Widget buildEmailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'someone@example.com',
            labelText: 'Email',
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget buildPasswordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'password',
            errorText: snapshot.error,
          ),
          obscureText: true,
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget buildSubmitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return RaisedButton(
          child: Text("Submit"),
          color: Colors.blue,
          onPressed: snapshot.hasData
              ? () {
                  bloc.login();
                }
              : null,
        );
      },
    );
  }
}
