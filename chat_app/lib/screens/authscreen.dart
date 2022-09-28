import 'dart:io';

import 'package:chat_app/widget/authwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class authscreen extends StatefulWidget {
  authscreen({Key? key}) : super(key: key);

  @override
  State<authscreen> createState() => _authscreenState();
}

class _authscreenState extends State<authscreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  Future _submitloginform (String email, String password , BuildContext context)async{
              try {
      setState(() {
        _isLoading = true;
      });
                UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );


     
     
    } on FirebaseException catch (e) {
      String msg = 'Something Wrong';
      if (e.code == 'user-not-found') {
        msg = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password try again';
      }
      ScaffoldMessenger.of(context).showSnackBar(snackbarmethod(msg)
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  Future _submitAuthform(String email, String password, String username,
      bool isLogin, BuildContext ctx, File userimage) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });


     
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = FirebaseAuth.instance.currentUser;
        final ref =
            FirebaseStorage.instance.ref().child("images/${user!.uid}.jpg");

        await ref.putFile(userimage);
        final imageurl = await ref.getDownloadURL();

        CollectionReference users =
            FirebaseFirestore.instance.collection('user');

        await users.doc(user.uid).set({
          'username': username,
          'password': password,
          'imageurl': imageurl,
          'id': user.uid,
          'lastmessage' : Timestamp.now()
        });
      
    } on FirebaseException catch (e) {
      String msg = 'Something Wrong';
      if (e.code == 'weak-password') {
        msg = 'weak password';
      } else if (e.code == 'email-already-in-use') {
        msg = 'The Account already exists for that email';
      } else if (e.code == 'user-not-found') {
        msg = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password try again';
      }
      ScaffoldMessenger.of(ctx).showSnackBar(snackbarmethod(msg));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  SnackBar snackbarmethod(String msg) {
    return SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color.fromARGB(255, 251, 180, 97),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: auth(
        authsubmit: _submitAuthform,
        loading: _isLoading, loginsubmit: _submitloginform,
      ),
    );
  }
}
