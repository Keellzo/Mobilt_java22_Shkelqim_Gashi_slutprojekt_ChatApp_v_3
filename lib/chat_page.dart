import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_service.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String username;
  final ChatService chatService;

  const ChatPage(
      {super.key, required this.userId,
      required this.username,
      required this.chatService});

  @override
  _ChatPageState createState() => _ChatPageState();
}

  class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chats');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: Column(
        children: [
          // StreamBuilder for real-time chat updates
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: chatCollection
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }

                return ListView(
                  reverse: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    String message =
                        data['message'] ?? 'Unknown message'; // Null check
                    String username =
                        data['userName'] ?? 'Unknown user'; // Null check

                    return ListTile(
                      title: Text(message),
                      subtitle: Text(username),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (_messageController.text.isNotEmpty) {
                      await widget.chatService.sendMessage(
                          _messageController.text,
                          widget.userId,
                          widget.username);
                      _messageController.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
