import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String username, String content) async {
    try {
      await firestore.collection("posts").add({
        'username': username,
        'content': content,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("posts").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List?> read() async {
    QuerySnapshot querySnapshot;
    List? docs = [];
    try {
      querySnapshot = await firestore.collection('posts').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "username": doc['username'],
            "content": doc["content"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update(String id, String username, String content) async {
    try {
      await firestore
          .collection("posts")
          .doc(id)
          .update({'username': username, 'content': content});
    } catch (e) {
      print(e);
    }
  }
}
