import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

Logger log = Logger();
Future<UserCredential> signInWithEmail(String email, String password) async {
  try {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  } on FirebaseAuthException catch (e) {
    log.e('Code: ${e.code}');
    log.e('Message: ${e.message}');
    rethrow;
  }
}

Future<UserCredential> signUpWithEmail(String email, String password) async {
  return await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
