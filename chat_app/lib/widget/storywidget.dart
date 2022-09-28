import 'package:chat_app/screens/messagescreen.dart';
import 'package:flutter/material.dart';

class story extends StatelessWidget {
  const story({
    Key? key,
    required this.image,
    required this.name, required this.id,
  }) : super(key: key);
  final String image;
  final String name;
  final String id; 
  void selectuser(
      BuildContext ctx) {
    Navigator.of(ctx).pushNamed(chatscreen.chatroutes,
        arguments: {'id': id, 'username': name, 'userimage': image});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        
        highlightColor: Theme.of(context).canvasColor,
        onTap: () => selectuser(context),
        child: Card(
          
          elevation: 5,
          shadowColor: Colors.black,
          color: Theme.of(context).canvasColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
            
            
          ),
          child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)
                     
                    ),
                    child: Image.network(
                      image,
                      height: double.infinity,
                      width: 95,
                      fit: BoxFit.cover,
                    ),
                  ),
            Container(
              
                      width: 95,
                      height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(41, 47, 63, 255).withOpacity(0),
                  Color.fromRGBO(41, 47, 63, 255).withOpacity(0.8),
                ],
              )
            ),
        
                      padding: EdgeInsets.only(
        top: 80,
        left: 15,                  ),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  
                ],
              ),
        ),
      ),
    );
  }
}
