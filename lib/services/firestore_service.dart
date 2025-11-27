import 'package:cloud_firestore/cloud_firestore.dart';

class Item{
  final String id;
  final String name;
  final int point;

  Item({
  required this.id,
  required this.name, required this.point
});
  factory Item.fromFireStore(DocumentSnapshot doc){
    final data = doc.data() as Map<String,dynamic>;

    if (data == null){
      throw StateError("Dokumen kosong");
    }
    return Item(
      id: doc.id,
      name: data['name'] as String? ?? "Tidak ada nama",
      point: (data['point']as num ?)?.toInt() ?? 0
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream <List<Item>> getItems(){
    return _db.collection('user_items')
        .snapshots()
        .map((snapshots)=> snapshots.docs.map((doc)=> Item.fromFireStore(doc)).toList());
  }

}