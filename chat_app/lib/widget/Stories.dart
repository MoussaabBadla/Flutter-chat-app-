import 'package:chat_app/screens/messagescreen.dart';
import 'package:chat_app/widget/storywidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class strotyrow extends StatelessWidget {
  strotyrow({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final docs = snapshot.data?.docs;
          final thisuser = FirebaseAuth.instance.currentUser;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          return Container(
            height: 150,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: docs?.length,
              itemBuilder: ((context, index) {
                if (docs?[index]['id'] == thisuser!.uid) {
                  return Container();
                }

                return story(
                  image: docs?[index]['imageurl'],
                  name: docs?[index]['username'], 
                  id : docs?[index]['id']
                );
              }),
            ),
          );
        });
  }
}
