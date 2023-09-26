import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'chat_page.dart';
import 'chat_service.dart';
import 'default_firebase_options.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'navigation_service.dart';
import 'service_locator.dart';

void main() async {
  GetIt.I.registerLazySingleton(() => NavigationService());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.current,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      title: 'Flutter Chat App',
      builder: (context, child) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return child!;
          },
        );
      },
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/chat': (context) => ChatPage(
          userId: 'SomeUserId',
          username: 'SomeUsername',
          chatService: locator<ChatService>(),
        ),
      },
    );
  }
}
