import 'package:flutter/material.dart';
import 'package:prak_pm/services/firestore_service.dart';

class ItemListScreen extends StatefulWidget {
  ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _pointController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    void _showDialog(){
      _nameController.clear();
      _pointController.clear();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Tambah Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama item",

                ),
              ),

              TextField(
                controller: _pointController,
                decoration: InputDecoration(
                  labelText: "Poin item",
                ),
              )
            ],
          ),

          actions: [
            TextButton(onPressed: (){
            Navigator.pop(context);
            }, child: Text("Batal")),

            ElevatedButton(onPressed: (){
              final String name = _nameController.text;
              final int point = int.tryParse(_pointController.text)?? 0;

              if(name.isNotEmpty){
                _firestoreService.addItem(name, point);
                Navigator.pop(context);
              }
            }, child: Text('Simpan'))
          ],
        )
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _showDialog,
        backgroundColor: Colors.white,
        child: Icon(Icons.add,color: Colors.green,),
      ),
      appBar: AppBar(
        title: Text("Daftar Item"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: StreamBuilder(stream: _firestoreService.getItems(), builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(snapshot.hasError){
          return Center(child: Text("Terjadi kesalahan"),);
        }

        final List<Item> items = snapshot.data ?? [];
        if(items.isEmpty){
          return Center(
            child: Text("Tidak ada item yang ditampilkan"),
          );
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
            final Item item = items[index];

            return Card(
              child: ListTile(
                title: Text(item.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(item.id),
                trailing: Text("${item.point}",style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w600
                ),),
              )
            );
          },
        );
      }),
    );
  }
}
