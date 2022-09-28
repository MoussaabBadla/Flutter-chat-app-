import 'package:chat_app/screens/splachscreen.dart';
import 'package:chat_app/screens/userscreen.dart';
import 'package:chat_app/widget/Search.dart';
import 'package:chat_app/widget/chatwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget/Stories.dart';

class chat extends StatelessWidget {
  chat({
    Key? key,
  }) : super(key: key);
  String userimage='';
  String username='';
  void selectuser(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(userscreen.route,
        arguments: {'username': username, 'userimage': userimage});
  }

  @override
  Widget build(BuildContext context) {
    final thisuser = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('user')
            .doc(thisuser!.uid)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Splach();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if ( snapshot.data?.data()!=null){
              Map<String?, dynamic> data =
                                    snapshot.data?.data() as Map<String?, dynamic>;
                userimage =  data['imageurl'];
            username = data['username'];}
            
            return Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: EdgeInsets.all(0),
                  child: InkWell(
                    onTap: () => selectuser(context),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(left: 7),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(111, 0, 0, 0),
                            blurRadius: 1.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                -2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                          backgroundImage: Image.network(
                        userimage,
                        fit: BoxFit.cover,
                      ).image),
                    ),
                  ),
                ),
                title:  Text(
                  'Chats',
                  style:  TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 27),
                ),
                elevation: 0,
                backgroundColor: Theme.of(context).canvasColor,
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Searchbar(),
                  strotyrow(),
                  SizedBox(
                    height: 5,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chat')
                          .orderBy('createdAt', descending: false)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        final dos = snapshot.data?.docs;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Expanded(
                              child: Center(
                            child: CircularProgressIndicator(
                                color: Color.fromARGB(211, 251, 179, 97)),
                          ));
                        }

                        return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('user')
                                .orderBy('lastmessage', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              final docs = snapshot.data?.docs;
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Expanded(
                                    child: Center(
                                  child: CircularProgressIndicator(
                                      color: Color.fromARGB(211, 251, 179, 97)),
                                ));
                              }

                              return Expanded(
                                  child: ListView.builder(
                                itemCount: docs?.length,
                                itemBuilder: ((context, index) {
                                  final est = FirebaseAuth.instance.currentUser;

                                  int? lastindex(int index) {
                                    
                                     return dos!.lastIndexWhere((element) => element['userid']==est!.uid && element['to']==docs?[index]['id']||element['userid']==docs?[index]['id'] &&
                                            element['to'] == est.uid);
                                 
                                  }

                                  String readTimestamp(DateTime timestamp) {
                                    var now = DateTime.now();
                                    var format = DateFormat('HH:mm a');
                                    var diff = now.difference(timestamp);
                                    var time = '';

                                    if (diff.inSeconds <= 0 ||
                                        diff.inSeconds > 0 &&
                                            diff.inMinutes == 0 ||
                                        diff.inMinutes > 0 &&
                                            diff.inHours == 0 ||
                                        diff.inHours > 0 && diff.inDays == 0) {
                                      time = format.format(timestamp);
                                    } else if (diff.inDays > 0 &&
                                        diff.inDays < 7) {
                                      if (diff.inDays == 1) {
                                        time =
                                            diff.inDays.toString() + ' DAY AGO';
                                      } else {
                                        time = diff.inDays.toString() +
                                            ' DAYS AGO';
                                      }
                                    } else {
                                      if (diff.inDays == 7) {
                                        time = (diff.inDays / 7)
                                                .floor()
                                                .toString() +
                                            ' WEEK AGO';
                                      } else {
                                        time = (diff.inDays / 7)
                                                .floor()
                                                .toString() +
                                            ' WEEKS AGO';
                                      }
                                    }

                                    return time;
                                  }

                                  if (docs?[index]['id'] == est!.uid) {
                                    return Container();
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: chatwidget(
                                      username: docs?[index]['username'],
                                      key: ValueKey(docs?[index].id),
                                      imageurl: docs?[index]['imageurl'],
                                      id: docs?[index]['id'],
                                      CreatedAt: lastindex(index)! < 0
                                          ? ''
                                          : readTimestamp(DateTime
                                              .fromMicrosecondsSinceEpoch(
                                                  dos?[lastindex(index)!]
                                                          ['createdAt']
                                                      .microsecondsSinceEpoch)),
                                      lastmessage: lastindex(index)! < 0
                                          ? 'Send Mesage to ${docs?[index]['username']}'
                                          : (dos?[lastindex(index)!]
                                                      ['userid'] ==
                                                  est.uid)
                                              ? 'You: ${dos?[lastindex(index)!]['text']}'
                                              : '${docs?[index]['username']}:${dos?[lastindex(index)!]['text']}',
                                    ),
                                  );
                                }),
                              ));
                            });
                      }),
                ],
              ),
            );
          }
          return Splach();
        });
  }
}
