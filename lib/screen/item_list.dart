import 'package:flutter/material.dart';
import 'package:prak_pm/services/firestore_service.dart';

class ItemListScreen extends StatelessWidget {
  ItemListScreen({super.key});

  final FirestoreService _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
