import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_gp/Model/category.dart';

class StoreCategory {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  addCategory(Category category) {
    _firebaseFirestore.collection('Category').add({
      'name': category.name,
      'image': category.image,
    });
  }

  Stream<QuerySnapshot> loadCategory() {
    return _firebaseFirestore.collection('Category').snapshots();
  }

  listAllPorod(documentId) {
    _firebaseFirestore.collection('Category').doc(documentId).get();
  }

  deleteCategory(documentId) {
    _firebaseFirestore.collection('Category').doc(documentId).delete();
  }

  editCategory(data, documentId) {
    _firebaseFirestore.collection('Category').doc(documentId).update(data);
  }
}
