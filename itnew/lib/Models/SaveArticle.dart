import 'package:cloud_firestore/cloud_firestore.dart';

class SaveArticle {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveArticle(String userId, Map<String, dynamic> article) async {
    await _firestore.collection('users').doc(userId).collection('saved_articles').add(article);
  }

  Future<List<Map<String, dynamic>>> getSavedArticles(String userId) async {
    final QuerySnapshot querySnapshot = await _firestore.collection('users').doc(userId).collection('saved_articles').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  removeSavedArticle(String userId, link) {}
}
