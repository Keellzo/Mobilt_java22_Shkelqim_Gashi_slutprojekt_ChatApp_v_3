import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'chat_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'navigation_service.dart';
import 'service_locator.dart';
import 'chat_service.dart';


void main() async {
  setupLocator(); // Initialize service locator
  final NavigationService _navigationService = locator<NavigationService>();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ChatService chatService = ChatService();

  MyApp({super.key});  // Initialize a ChatService object

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey, // Use navigation service
      title: 'Flutter Chat App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),  // Define your routes
        '/home': (context) => const HomePage(),
        '/chat': (context) => ChatPage(
            userId: '',  // You will replace these with actual values
            username: '',  // You will replace these with actual values
            chatService: chatService  // Pass the initialized ChatService
        ),
      },
    );
  }
}
