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
    void _showDialog({ Item? item }) {
      if (item != null) {
        _nameController.text = item.name;
        _pointController.text = item.point.toString();
      } else {
        _nameController.clear();
        _pointController.clear();
      }

      // ---- LETAK PERUBAHAN ---- //
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(item == null ? "Tambah Item" : "Edit Item"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Nama Item"),
                ),
                TextField(
                  controller: _pointController,
                  decoration: const InputDecoration(labelText: "Poin Item"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text;
                  final point = int.tryParse(_pointController.text) ?? 0;

                  // ---- LETAK PERUBAHAN ---- //
                  if (name.isNotEmpty) {
                    if (item == null) {
                      _firestoreService.addItem(name, point);
                    } else {
                      _firestoreService.updateItem(item.id, name, point);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(item == null ? "Simpan" : "Update"),
              ),
            ],
          )
      );
    }
    void _showDeleteConfirmation(String id, String name) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Hapus Item?"),
            content: Text("Apakah Anda yakin ingin menghapus item '$name'? Data tidak akan bisa dikembalikan."),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal")
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    _firestoreService.deleteItem(id);

                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Hapus",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
              )
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
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${item.point} Poin',
                      style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(width: 8,),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => _showDeleteConfirmation(item.id, item.name),
                    )
                  ],
                ),
                onTap: () => _showDialog(item: item),
              ),
            );
          },
        );
      }),
    );
  }
}
