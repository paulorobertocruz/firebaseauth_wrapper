abstract class FirebaseAuth{
  Stream<String> get onUserIdChange;
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future logout();
}