import 'package:climbingpals/models/user.dart';
import 'package:climbingpals/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

    final FirebaseAuth _auth = FirebaseAuth.instance; //under score means it is private to this file

    // function to create user object based on firebase user
    User _userFromFirebaseUser(FirebaseUser user) {
        return user != null ? User(uid: user.uid) : null;
    }

    // auth change user stream
    Stream<User> get user {
        return _auth.onAuthStateChanged
        //    .map((FirebaseUser user) => _userFromFirebaseUser(user));   same as below
        .map(_userFromFirebaseUser);
    }

    // sign in anonymous user
    Future signInAnon() async {
        try {
            AuthResult result = await _auth.signInAnonymously();
            FirebaseUser user = result.user;
            return _userFromFirebaseUser(user);
        } catch(e) {
            print(e.toString());
            return null;
        }
    }

    // sign in with email and password
    Future signInWithEmailAndPassword(String email, String password) async {
        try {
            AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
            FirebaseUser user = result.user;
            return _userFromFirebaseUser(user);
        } catch(e) {
            print(e.toString());
            return null;
        }
    }

    // register with email and password
    Future registerWithEmailAndPassword(String email, String password) async {
        try {
            AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
            FirebaseUser user = result.user;
            // create new document for user with uid from firebase
            await DatabaseService(uid: user.uid).updateUserData('0', 'New Customer', 100);
            return _userFromFirebaseUser(user);
        } catch(e) {
            print(e.toString());
            return null;
        }
    }

    // sign out
    Future signOut() async {
        try {
            return await _auth.signOut();
        } catch (e) {
            print(e.toString());
            return null;
        }
    }
}