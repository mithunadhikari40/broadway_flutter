import 'dart:async';

class ValidationMixing {
  final emailTransformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains("@") && email.contains(".")) {
        sink.add(email);
      } else {
        sink.addError("Invalid email address");
      }
    },
  );

  final passwordTransformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 4) {
        sink.add(password);
      } else {
        sink.addError("Password must be at least 5 charactes long");
      }
    },
  );
}
