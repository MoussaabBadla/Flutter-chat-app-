import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    required this.key,
    required this.msg,
    required this.isme,
    required this.createdAt,
  }) : super(key: key);
  final Key key;
  final String msg;
  final bool isme;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    if (isme) {
      return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              padding: const EdgeInsets.all(9),
              margin: const EdgeInsets.only(right: 8, bottom: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8)

                ],
                begin: Alignment.topCenter,end: Alignment.bottomCenter),
                        boxShadow: [
            BoxShadow(
                color: Color.fromARGB(170, 0, 0, 0),
                blurRadius: 0.5,
                spreadRadius: 0.0,
                offset: Offset(0, 1.0), // shadow direction: bottom right
            )
        ],

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color:  Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Text(msg,style: TextStyle(fontSize: 14,color: Colors.white),),

                    SizedBox(
                      height: 8,
                    ),
                    Text(createdAt,style: TextStyle(fontSize: 10,color: Colors.grey))
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Row(
          
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              padding: const EdgeInsets.all(9),
              margin: const EdgeInsets.only(left: 8, bottom: 8),
              decoration: BoxDecoration(
                        boxShadow: [
            BoxShadow(
                color: Color.fromARGB(170, 0, 0, 0),
                blurRadius: 0.5,
                spreadRadius: 0.0,
                offset: Offset(0, 1.0), // shadow direction: bottom right
            )
        ],

                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color:  Theme.of(context).primaryColorLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(msg,style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColorDark),),

                  SizedBox(
                    height: 8,
                  ),
                  Text(createdAt,style: TextStyle(fontSize: 10,color: Colors.grey))
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
