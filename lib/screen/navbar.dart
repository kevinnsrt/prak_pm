import 'package:flutter/material.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(onPressed: (){},
          shape: CircleBorder(),
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 65,
            height: 65,
            child: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.qr_code_scanner,color: Colors.white,size: 40,),
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem("Beranda", Icons.home, 0),
           _buildNavItem("Jelajahi", Icons.search, 1),
           // MaterialButton(onPressed: (){},child:Text("E-Scan"),),
            SizedBox(width: 8,),
            _buildNavItem("Tugas", Icons.task, 2),
           _buildNavItem("Profil", Icons.person, 3)
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title,IconData icon, int index){
    return  MaterialButton(onPressed: (){},
      child: Column(
        children: [
          Icon(icon),
          Text(title),
        ],
      ),
    );
  }
}
