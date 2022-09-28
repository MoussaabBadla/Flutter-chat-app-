import 'package:chat_app/screens/splachscreen.dart';
import 'package:chat_app/screens/userscreen.dart';

import './screens/authscreen.dart';
import 'screens/chatscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/messagescreen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color darkthem = Color(0xff292F3F);

  Color lightthem = Colors.white;

  Color darkthem2 = Color(0xFF272A35);
  Color lightteme2 = Color(0xF1837DFF);

  Color darkthem3 = Color(0xFF373E4E);
  Color darktheme4 = Color(0xFF1F232F);

  bool dark = true;

  void Selecttheme() {
    setState(() {
      dark = !dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chat app',
      theme: ThemeData(
        canvasColor: dark ? darkthem : lightthem,
        primaryColor: dark ? darkthem2 : lightteme2,
        primaryColorLight: dark ? darkthem3 : Colors.grey[300],
        primaryColorDark: dark ? Colors.white : Colors.black,
        splashColor: dark? darktheme4 : Colors.white,
        hoverColor: dark? darktheme4 : Colors.grey[600],
        cardColor: dark ? darkthem : lightthem ,
        shadowColor: dark? Colors.white :lightteme2 ,
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Splach();
            }

            if (snapshot.hasData) {
              return chat();
            } else {
              return authscreen();
            }
          })),
      routes: {
        chatscreen.chatroutes: (context) => chatscreen(),
        userscreen.route: ((context) => userscreen(selectthemes: Selecttheme, darkk: dark,))
      },
    );
  }
}
