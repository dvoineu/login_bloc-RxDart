import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to the stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  // RxDart added to combine two streams
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // perform action on SubmitButton after submition of password and email.
  // For example, send data to the server
  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('This is a valid email $validEmail');
    print('This is a valid password $validPassword');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
