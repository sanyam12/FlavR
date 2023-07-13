import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService{
  Future<UserCredential?> signInWithGoogle() async{
    //open the page to select email
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if(gUser != null)
      {
        final GoogleSignInAuthentication gAuth =
          await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken,
            idToken: gAuth.idToken
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    return null;
    // authenticate the email
  }
}