import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthTestFirebaseUser {
  AuthTestFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

AuthTestFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AuthTestFirebaseUser> authTestFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AuthTestFirebaseUser>(
            (user) => currentUser = AuthTestFirebaseUser(user));
