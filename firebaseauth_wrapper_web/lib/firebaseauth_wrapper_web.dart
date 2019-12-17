import 'package:firebase/firebase.dart' as fb;
import 'package:firebaseauth_wrapper/firebaseauth_wrapper.dart' as w;

class UserCredential extends w.UserCredential {
  fb.UserCredential _r;
  UserCredential(this._r);

  get user => this._r.user;
}

class ActionCodeInfo extends w.ActionCodeInfo {
  fb.ActionCodeInfo _r;
  ActionCodeInfo(this._r);

  dynamic get data => this._r.data;
}


class FirebaseAuth extends w.FirebaseAuth {
  final fb.Auth _auth = fb.auth();

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email, password);
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

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    var r = await _auth.createUserWithEmailAndPassword(email, password);
    return UserCredential(r);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    _auth.sendPasswordResetEmail(email);
  }

  @override
  Future confirmPasswordReset(String code, String password) {
    return _auth.confirmPasswordReset(code, password);
  }

  @override
  Future<String> verifyPasswordResetCode(String code) {
    return _auth.verifyPasswordResetCode(code);
  }

  @override
  Future<ActionCodeInfo> checkActionCode(String code) async {
    var r = await _auth.checkActionCode(code);
    return ActionCodeInfo(r);
  }

  @override
  Future applyActionCode(String code) {
    return _auth.applyActionCode(code);
  }
}
