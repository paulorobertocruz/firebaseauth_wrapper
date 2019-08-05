import 'package:firebase/firebase.dart' as fb;
import 'package:firebaseauth_wrapper/firebaseauth_wrapper.dart' as w;

class FirebaseAuth extends w.FirebaseAuth{
  final fb.Auth _auth = fb.Auth.getInstance();

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
    return _auth.onAuthStateChanged.map((firebaseUser){
      return firebaseUser != null? firebaseUser.uid : null;
    });
  }

  @override
  Future logout() {
    _auth.signOut();
    return Future.delayed(Duration.zero);
  }

}