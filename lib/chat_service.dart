import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chats');

  Future<DocumentReference<Object?>> sendMessage(
      String message, String userId, String userName) async {
    return await chatCollection.add({
      'message': message,
      'userId': userId,
      'userName': userName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> get messages {
    return chatCollection.orderBy('timestamp', descending: true).snapshots();
  }
}
