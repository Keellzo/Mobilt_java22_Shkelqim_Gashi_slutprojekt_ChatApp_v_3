import 'package:cloud_firestore/cloud_firestore.dart';

// ChatService class for interacting with Firestore
class ChatService {
  // Create a reference to the 'chats' collection in Firestore
  final CollectionReference chatCollection =
  FirebaseFirestore.instance.collection('chats');

  // Function to send a message to Firestore
  Future<DocumentReference<Object?>> sendMessage(
      String message, String userId, String userName) async {
    // Adding message data to Firestore and setting the server timestamp
    return await chatCollection.add({
      'message': message,
      'userId': userId,
      'userName': userName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Stream to fetch messages in real-time, ordered by timestamp
  Stream<QuerySnapshot> get messages {
    // orderBy is used to sort messages by the 'timestamp' field in descending order
    return chatCollection.orderBy('timestamp', descending: true).snapshots();
  }
}
