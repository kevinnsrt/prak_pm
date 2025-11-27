import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prak_pm/screen/beranda.dart';
import 'package:prak_pm/screen/jelajah.dart';
import 'package:prak_pm/screen/profile.dart';
import 'package:prak_pm/screen/tugas.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {

  int _selectedIndex = 0;

  final List<Widget> _screen = [

    BerandaPage(),
    JelajahPage(),
    TugasPage(),
    ProfilePage()
  ];

  void _onTapped (int index){
    setState(() {
      _selectedIndex = index;
      final isSelected = _selectedIndex == index;
      final color = isSelected ? Colors.green : Colors.grey;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(onPressed: () async{
          var status = await Permission.camera.request();

          if(status.isGranted){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("tuntung selayar")));
          }
          else if (status.isDenied){
            await Permission.camera.request();
          }
          else if(status.isDenied){
            openAppSettings();
          }
        },
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

      body: IndexedStack(
        index: _selectedIndex,
        children: _screen,
      ),
    );
  }

  Widget _buildNavItem(String title,IconData icon, int index){
    return  MaterialButton(onPressed: () => _onTapped(index),
      child: Column(
        children: [
          Icon(icon),
          Text(title),
        ],
      ),
    );
  }
}
