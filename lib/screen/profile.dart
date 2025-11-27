import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prak_pm/components/profile_widget/menu_list.dart';
import 'package:prak_pm/screen/item_list.dart';
import 'package:prak_pm/screen/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> signOutGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      print('User signed out successfully from Google and Firebase.');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(child:
      SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: signOutGoogle, icon: Icon(Icons.logout,color: Colors.white,)),
                  Text(
                    "Profil",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 19),

            Container(
              padding: EdgeInsets.only(top: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 99,
                    height: 97,
                    child: Image.asset("assets/profile_pic.png"),
                  ),

                  Text(
                    "Kevin Namalo Sirait",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "kevinnamalo@students.usu.ac.id",
                    style: TextStyle(fontSize: 14),
                  ),

                  SizedBox(height: 32),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(blurRadius: 2)],
                      color: Colors.white,
                    ),
                    width: 372,
                    height: 68,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 42,
                              height: 34,
                              child: Image.asset("assets/coin.png"),
                            ),

                            Text("9999"),
                            SizedBox(
                              width: 6,
                            ),
                            Text("E-Point",),

                            SizedBox(width: 30),

                            Image.asset("assets/line.png"),

                            SizedBox(width: 30),

                            SizedBox(
                              width: 126,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadiusGeometry.circular(12),
                                  ),
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {},
                                child: Text("Tukarkan"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32),

                  Container(
                    width: 372,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 1), blurRadius: 2),
                      ],
                      color: Colors.white,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 24),
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: Image.asset("assets/history.png"),
                            ),

                            SizedBox(width: 10),

                            Text(
                              "Histori Transaksi",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_arrow_right_rounded),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemListScreen()));
                    },
                    child: MenuList(title: "Daftar Item",file: "tugas.png"),
                  ),
                  SizedBox(height: 10,),
                  MenuList(title: "Tugas",file: "tugas.png"),

                  SizedBox(height: 10),
                  MenuList(title: "Peringkat",file: "peringkat.png"),

                  SizedBox(height: 10),
                  MenuList(title: "Notifikasi",file: "notifikasi.png"),

                  SizedBox(height: 10),
                  MenuList(title: "Kebijakan Privasi",file: "kebijakan_privasi.png"),

                  SizedBox(height: 10),
                  MenuList(title: "Medaliku",file: "medali.png"),


                ],
              ),
            ),
          ],
        ),
      ),)
    );
  }
}
