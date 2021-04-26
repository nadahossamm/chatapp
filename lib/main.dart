import 'package:chatapp/screens/LoginPage.dart';
import 'package:chatapp/screens/SignupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return StreamProvider<userclass>.value(
      child: MaterialApp(

        home:login()
        // home: Conversation()
        ,
      ),
    );
  }
}






