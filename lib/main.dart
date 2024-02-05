import 'package:basic_registration_form/views/login_view.dart';
import 'package:basic_registration_form/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(FirebaseAuth.instance.currentUser);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // if (snapshot.connectionState == ConnectionState.active) {
          //   if (snapshot.hasData) {
          //     return const HomePage();
          //   }

          //   if (snapshot.hasError) {
          //     return Center(
          //       child: Text('${snapshot.error}'),
          //     );
          //   }
          // }
          if (FirebaseAuth.instance.currentUser != null) {
            return HomePage(userName: FirebaseAuth.instance.currentUser!.email);
          }

          return const LoginView();
        }
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String? userName;
  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home Page"),
      ),
      body: Center(child: Text("Hello $userName"),)
    );
  }
}