import 'package:flutter/material.dart';
import 'package:slut_projekt/service_locator.dart';
import 'auth_service.dart';
import 'chat_page.dart';
import 'chat_service.dart';
import 'navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  void _signIn() async {
    final name = _nameController.text;
    final password = _passwordController.text;

    bool result = await _authService.signInWithUserName(name, password);  // Expect a bool

    if (result) {
      print("Successfully signed in");

      // Navigate to chat page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userId: 'someDynamicUserIdHere',  // Replace with the real user ID
            username: name,  // Using the 'name' variable to pass the username
            chatService: ChatService(),
          ),
        ),
      );
    } else {
      print("Failed to sign in");
      // Show error dialog or snackbar
    }
  }

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
