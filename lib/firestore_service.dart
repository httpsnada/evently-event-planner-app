import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirestoreService {
  static final GoogleSignIn _google = GoogleSignIn.instance;

  static bool isInitialize = false;

  static Future<void> _initSignIn() async {
    if (!isInitialize) {
      await _google.initialize(
        serverClientId:
            "475464336337-2hkebemgl1ehk5fmkdj9565aq90fsbp6.apps.googleusercontent.com",
      );
    }
    isInitialize = true;
  }

  static Future<UserCredential> signInWithGoogle() async {
    _initSignIn();
    // user select an account -> id token/access token
    GoogleSignInAccount account = await _google.authenticate();
    final idToken = account.authentication.idToken;
    final authClient = account.authorizationClient;
    GoogleSignInClientAuthorization? auth = await authClient
        .authorizationForScopes(['email', 'profile']);
    var accessToken = auth?.accessToken;
    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: accessToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
