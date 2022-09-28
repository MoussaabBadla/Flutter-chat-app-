import 'package:chat_app/widget/messageBuble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class message extends StatelessWidget {
  const message({Key? key, required this.to}) : super(key: key);
  final String to;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final docs = snapshot.data?.docs;
          final test = FirebaseAuth.instance.currentUser;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Expanded(
                child: Center(
                    child: CircularProgressIndicator(
          color: Color.fromARGB(211, 251, 179, 97),
        ),));
          }

          return ListView.builder(
            reverse: true,
            itemCount: docs?.length,
            itemBuilder: ((context, index) {
              var kok = DateTime.fromMicrosecondsSinceEpoch(
                  docs?[index]['createdAt'].microsecondsSinceEpoch);

              String readTimestamp(DateTime timestamp) {
                var now = DateTime.now();
                var format = DateFormat('HH:mm a');
                var diff = now.difference(timestamp);
                var time = '';

                if (diff.inSeconds <= 0 ||
                    diff.inSeconds > 0 && diff.inMinutes == 0 ||
                    diff.inMinutes > 0 && diff.inHours == 0 ||
                    diff.inHours > 0 && diff.inDays == 0) {
                  time = format.format(timestamp);
                } else if (diff.inDays > 0 && diff.inDays < 7) {
                  if (diff.inDays == 1) {
                    time = diff.inDays.toString() + ' DAY AGO';
                  } else {
                    time = diff.inDays.toString() + ' DAYS AGO';
                  }
                } else {
                  if (diff.inDays == 7) {
                    time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
                  } else {
                    time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
                  }
                }

                return time;
              }

              final String messa;
              if (docs?[index]['userid'] == test!.uid &&
                      docs?[index]['to'] == to ||
                  docs?[index]['userid'] == to &&
                      docs?[index]['to'] == test.uid) {
                messa = docs?[index]['text'];
                return Bubble(
                  createdAt: readTimestamp(kok),
                  key: ValueKey(docs?[index].id),
                  msg: messa,
                  isme: docs?[index]['userid'] == test.uid,
                );
              }
              return Container();
            }),
          );
        }));
  }
}
// 