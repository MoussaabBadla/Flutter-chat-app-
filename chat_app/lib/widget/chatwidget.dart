import 'package:chat_app/screens/messagescreen.dart';
import 'package:flutter/material.dart';

class chatwidget extends StatelessWidget {
  const chatwidget({
    Key? key,
    required this.imageurl,
    required this.username,
    required this.id,required this.lastmessage,required this.CreatedAt,
  }) : super(key: key);
  final String? imageurl;
  final String? username;
  final String? id;
  final String? lastmessage;
  final String? CreatedAt;
  void selectuser(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(chatscreen.chatroutes, arguments: {'id': id,'username':username,'userimage':imageurl});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => selectuser(context),
      leading: Container( 
            decoration: BoxDecoration(
              shape:  BoxShape.circle,
        boxShadow: [
            BoxShadow(
                color: Color.fromARGB(170, 0, 0, 0),
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(-2.0, 2.0), // shadow direction: bottom right
            )
        ],
    ),

        child: CircleAvatar(
          foregroundColor: Colors.black,
          backgroundImage: Image.network(
            imageurl!,
            fit: BoxFit.cover,
          ).image,
          radius: 30,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          username!,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorDark),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          lastmessage!,
          style: TextStyle(fontSize: 13, color: Colors.grey),
          
        ),
      ),
      trailing: Text(CreatedAt!,style: TextStyle(color:Colors.grey,fontSize: 13 ),),
      
    );
  }
}
