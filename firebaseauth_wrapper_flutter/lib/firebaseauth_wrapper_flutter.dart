import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:firebaseauth_wrapper/firebaseauth_wrapper.dart' as w;

class UserCredential extends w.UserCredential {
  fa.AuthResult _r;
  UserCredential(this._r);

  get user => this._r.user;
}

class ActionCodeInfo extends w.ActionCodeInfo {}

class ActionCodeSettings extends w.ActionCodeSettings {}

class FirebaseAuth extends w.FirebaseAuth {
  final fa.FirebaseAuth _auth = fa.FirebaseAuth.instance;

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<String> get onUserIdChange {
    return _auth.onAuthStateChanged.map((firebaseUser) {
      return firebaseUser != null ? firebaseUser.uid : null;
    });
  }

  @override
  Future logout() {
    _auth.signOut();
    return Future.delayed(Duration.zero);
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    var r = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserCredential(r);
  }

  Future<void> sendPasswordResetEmail(String email,
      [ActionCodeSettings actionCodeSettings]) {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future confirmPasswordReset(String code, String password) {
    return Future.value(false);
  }

  Future<String> verifyPasswordResetCode(String code) {
    return Future.value(null);
  }

  Future<ActionCodeInfo> checkActionCode(String code) {
    return Future.value(null);
  }

  Future applyActionCode(String code) {
    return Future.value(null);
  }
}
