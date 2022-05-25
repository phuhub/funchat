import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FunChatFirebaseUser {
  FunChatFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

FunChatFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FunChatFirebaseUser> funChatFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<FunChatFirebaseUser>(
        (user) => currentUser = FunChatFirebaseUser(user));
