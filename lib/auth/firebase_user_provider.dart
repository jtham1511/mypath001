import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MyPath001FirebaseUser {
  MyPath001FirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

MyPath001FirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MyPath001FirebaseUser> myPath001FirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<MyPath001FirebaseUser>(
      (user) {
        currentUser = MyPath001FirebaseUser(user);
        return currentUser!;
      },
    );
