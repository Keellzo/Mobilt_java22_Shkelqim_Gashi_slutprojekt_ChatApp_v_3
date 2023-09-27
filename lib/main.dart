import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'chat_page.dart';
import 'chat_service.dart';
import 'default_firebase_options.dart';
import 'home_page.dart';
import 'login_page.dart';

void main() async {
  // Ensure that the widgets binding is properly initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with default options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.current,
  );

  // Run the Flutter app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger Chat App',

      // Build the UI based on the orientation of the device
      builder: (context, child) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return child!;
          },
        );
      },

      // Define initial route of the application
      initialRoute: '/home',

      // Define the routes and their corresponding widgets
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/chat': (context) => ChatPage(
              userId: 'SomeUserId', // Dummy user ID
              username: 'SomeUsername', // Dummy username
              chatService: ChatService(),
            ),
      },
    );
  }
}
