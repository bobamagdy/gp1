import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String name;
  String image;
  String id;

  Category({
    this.name,
    this.image,
    this.id,
  });

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> loadCategory() {
    return _firebaseFirestore.collection('Category').snapshots();
  }
}
