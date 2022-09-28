import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newMassge extends StatefulWidget {
  const newMassge({Key? key, required this.sendto}) : super(key: key);
  final String sendto;
  @override
  State<newMassge> createState() => _newMassgeState();
}

class _newMassgeState extends State<newMassge> {
  final _controller = TextEditingController();
  String _entredMessage = '';
  _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    final userdate = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    FocusScope.of(context).unfocus();
    try {
      FirebaseFirestore.instance.collection('chat').add({
        'text': _entredMessage,
        'createdAt': Timestamp.now(),
        'username': userdate['username'],
        'userid': user.uid,
        'image': userdate['imageurl'],
        'to': widget.sendto,
      }); 
              CollectionReference users =
            FirebaseFirestore.instance.collection('user');

        await users.doc(widget.sendto).update({
          'lastmessage' : Timestamp.now()
        });
        await users.doc(user.uid).update({
          'lastmessage' : Timestamp.now()
        });



      
    } catch (e) {
      print(e);
    }

    _controller.clear();
    setState(() {
      _entredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 8,bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 30,),
      child: Row(children: [
        Expanded(
            child: TextField(
              
      
          controller: _controller,
                                    style:  TextStyle(color: Theme.of(context).primaryColorDark),

          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).splashColor,
              label: Text(
            'Send Message ...',style: TextStyle(color: Color(0xFF9E9E9E )),
     
            
          ),
          
          floatingLabelStyle: TextStyle(color: Color(0xFF9E9E9E )),
          enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),

        borderSide: BorderSide(color: Theme.of(context).hoverColor)), 
          border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Theme.of(context).hoverColor)),
      hintStyle: TextStyle(color: Colors.grey[500]),
      focusedBorder: OutlineInputBorder(
       borderSide: BorderSide(
          
          color: Color(0xFF1F232F)
        ),
        
        borderRadius: BorderRadius.circular(10.0),
      ),
),
      

        
        
          onChanged: ((value) {
            setState(() {
              _entredMessage = value;
            });
          }),
        )),
        Container(
          margin: EdgeInsets.only(left: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
             color: Color(0xFF837DFF),
            borderRadius: BorderRadius.circular(15)
          ),
          child: IconButton(
              onPressed: _entredMessage.trim().isEmpty ? null : _sendMessage,
              icon: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
        ),
                Container(
          margin: EdgeInsets.only(left: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
             color: Color(0xFF00AC83),
            borderRadius: BorderRadius.circular(15)
          ),
          child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.camera_alt,color: Colors.white,)),
        )

      ]),
    );
  }
}
