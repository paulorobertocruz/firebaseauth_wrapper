abstract class UserCredential {
  dynamic get user;
}

abstract class ActionCodeInfo {}

abstract class FirebaseAuth {
  Stream<String> get onUserIdChange;
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future logout();

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password);

  Future sendPasswordResetEmail(String email);
  Future confirmPasswordReset(String code, String password);
  Future<String> verifyPasswordResetCode(String code);
  Future<ActionCodeInfo> checkActionCode(String code);
  Future applyActionCode(String code);
}
