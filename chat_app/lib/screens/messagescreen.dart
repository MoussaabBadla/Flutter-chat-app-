import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/Textfieldmessage.dart';
import '../widget/message.dart';

class chatscreen extends StatefulWidget {
  const chatscreen({Key? key}) : super(key: key);
  static String chatroutes = '/chatroute';

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen>  {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    final to_id = routeArgs['id'];
    final name = routeArgs['username'];
    final image = routeArgs['userimage'];

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
    color: Theme.of(context).primaryColorDark,
  ),

        title:  Row(
            children: [
              Padding(
              padding: EdgeInsets.only(right: 10,),
              child: InkWell(
                
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(111, 0, 0, 0),
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(-2.0, 2.0), // shadow direction: bottom right
                  )],
                   
                    shape: BoxShape.circle,
                  ),
                  child: 
                     CircleAvatar(
                        backgroundImage: Image.network(
                      image!,
                      fit: BoxFit.cover,
                    ).image),
                  
                ),
              ),
        ),
        Text(
          
          name!,
          style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 23),
        ),
            ],
          ),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
         IconButton(onPressed: (){}, icon: Icon(Icons.call,color: Theme.of(context).shadowColor,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.video_call,color: Theme.of(context).shadowColor,))

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: message(
              to: to_id!,
            ),
          ),
          newMassge(
            sendto: to_id,
          )
        ],
        
      ),
    );
  }
}
