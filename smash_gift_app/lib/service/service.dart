import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final db = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getData(DocumentSnapshot? lastDoc) async {
    try {
      final query = db.collection('countries').orderBy('country').limit(25);

      final result = lastDoc == null
          ? await query.get()
          : await query.startAfterDocument(lastDoc).get();

      return result.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
