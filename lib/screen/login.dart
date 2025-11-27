import 'package:flutter/material.dart';
import 'package:prak_pm/screen/navbar.dart';
import 'package:prak_pm/screen/profile.dart';
import 'package:prak_pm/screen/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print("Login dibatalkan user");
        return null;
      }

      // 2. Ambil token authentikasi Google
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // 3. Konversi token menjadi credential Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Login ke Firebase
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("exception -> $e");
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/login_header.png"),
            Image.asset("assets/login_logo.png", width: 113, height: 108),
            Column(
              children: [
                Text(
                  "Masuk atau daftar",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: 372,
                  height: 57,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: 370,
                  height: 57,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(6),
                      ),
                      backgroundColor: Color.fromRGBO(0, 148, 33, 1),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: Text("Selanjutnya"),
                  ),
                ),

                SizedBox(height: 9),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4,
                  children: [
                    Container(height: 1, width: 169, color: Colors.black),

                    Text("OR", style: TextStyle(color: Colors.black)),

                    Container(height: 1, width: 169, color: Colors.black),
                  ],
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: 370,
                  height: 57,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(6),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () async {
                      var userCredential = await signInWithGoogle();

                      if (userCredential != null) {
                        print(userCredential.user!.email);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NavbarPage(),
                          ),
                        );
                      } else {
                        print("Google login gagal atau dibatalkan.");
                      }
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Image.asset("assets/google.png", width: 30, height: 30),
                        Text("Lanjutkan dengan Google"),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: 370,
                  height: 57,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(6),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Image.asset(
                          "assets/facebook.png",
                          width: 30,
                          height: 30,
                        ),
                        Text("Lanjutkan dengan Facebook"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: Image.asset("assets/login_footer.png"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const SplashPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
