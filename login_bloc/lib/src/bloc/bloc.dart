import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validation_mixing.dart';

class Bloc with ValidationMixing {
  final _emailController = new BehaviorSubject<String>();
  final _passwordController = new BehaviorSubject<String>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get emailStream =>
      _emailController.stream.transform(emailTransformer);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordTransformer);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(emailStream, passwordStream,
          (String email, String password) {
        return true;
      });

  void login() {
    String email = _emailController.value;
    String password = _emailController.value;
    print("Email address $email and password is $password");
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
