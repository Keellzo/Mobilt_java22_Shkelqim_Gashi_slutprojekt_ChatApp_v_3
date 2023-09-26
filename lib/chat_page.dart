import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_service.dart';

// ChatPage Widget - the main chat interface
class ChatPage extends StatefulWidget {
  // User's unique ID and username
  final String userId;
  final String username;

  // ChatService instance to perform chat operations
  final ChatService chatService;

  // Constructor to initialize required variables
  const ChatPage(
      {Key? key,
      required this.userId,
      required this.username,
      required this.chatService})
      : super(key: key);

  // Create state for this StatefulWidget
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Controller for the text field to input messages
  final TextEditingController _messageController = TextEditingController();

  // Reference to the Firestore 'chats' collection
  // API endpoint: Firestore Database "chats" collection
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chats');

  // Build UI for portrait orientation
  Widget _buildPortraitLayout() {
    return Column(
      children: [
        // Chat messages stream
        Expanded(
          child: _buildChatStream(),
        ),
        // Input area for new messages
        _buildMessageInput()
      ],
    );
  }

  // Build UI for landscape orientation
  Widget _buildLandscapeLayout() {
    return Column(
      children: [
        // Chat messages stream
        Expanded(
          child: _buildChatStream(),
        ),
        // Input area for new messages
        _buildMessageInput(),
      ],
    );
  }

  // StreamBuilder to display chat messages in real-time
  Widget _buildChatStream() {
    return StreamBuilder<QuerySnapshot>(
      // API endpoint: Firestore Database ordered by 'timestamp'
      stream: chatCollection.orderBy('timestamp', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        // Map data from Firestore to ListView
        return ListView(
          reverse: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String message = data['message'] ?? 'Unknown message';
            String username = data['userName'] ?? 'Unknown user';
            return ListTile(
              title: Text(message),
              subtitle: Text(username),
            );
          }).toList(),
        );
      },
    );
  }

  // Build the bottom message input area
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Text field for message input
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Enter your message...',
              ),
            ),
          ),
          // Send button
          IconButton(
            icon: const Icon(Icons.send),
            // API call to send message when button pressed
            onPressed: () async {
              if (_messageController.text.isNotEmpty) {
                await widget.chatService.sendMessage(
                    _messageController.text, widget.userId, widget.username);
                _messageController.clear();
              }
            },
          )
        ],
      ),
    );
  }

  // Build the overall UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      // Adaptive layout based on orientation
      body: OrientationBuilder(
        builder: (context, orientation) {
          return (orientation == Orientation.portrait)
              ? _buildPortraitLayout()
              : _buildLandscapeLayout();
        },
      ),
    );
  }
}
