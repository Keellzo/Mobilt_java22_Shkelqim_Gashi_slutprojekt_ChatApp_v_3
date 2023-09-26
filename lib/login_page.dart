// Import required packages
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'chat_page.dart';
import 'chat_service.dart';

// LoginPage widget declaration
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Initialize the AuthService instance to handle authentication
  final AuthService _authService = AuthService();

  // Text controllers for username and password input fields
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();



  // Method to handle the Sign-In functionality
  void _signIn() async {
    final name = _nameController.text;
    final password = _passwordController.text;

    // Use the AuthService class to perform the sign-in
    // This might interact with an API endpoint to validate user credentials
    bool result = await _authService.signInWithUserName(name, password);

    // Evaluate the result of the authentication
    if (result) {
      print("Successfully signed in");

      // Navigate to the ChatPage if sign-in is successful
      // Likely to use user's ID and username from API response in a real-world scenario
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userId: 'someDynamicUserIdHere',
            username: name,
            chatService: ChatService(),
          ),
        ),
      );
    } else {
      print("Failed to sign in");
      // Display an error message (perhaps using a Snackbar or Dialog)
    }
  }

  // Build UI for portrait orientation
  Widget _buildPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _signIn,
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  // Build UI for landscape orientation
  Widget _buildLandscapeLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
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
