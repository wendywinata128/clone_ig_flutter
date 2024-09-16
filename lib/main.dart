import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/providers/post_provider.dart';
import 'package:clone_ig_flutter/presentation/providers/profile_provider.dart';
import 'package:clone_ig_flutter/presentation/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => PostProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Montserrat',
        primaryColor: Colors.black,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
