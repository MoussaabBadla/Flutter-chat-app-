import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({Key? key}) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();

}

class _SearchbarState extends State<Searchbar> {
      final controller = TextEditingController();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(  horizontal: 8.0),
      child: Container(
        height: 40,
        margin: EdgeInsets.only(top: 8, bottom: 10),
        padding: EdgeInsets.only(
          left: 30,
          right: 30
        ),
        child: Row(children: [
           
          Expanded(
              child: TextField(
            controller: controller,
                                      style:  TextStyle(color: Theme.of(context).primaryColorDark),

            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).splashColor,
              label: Text(
                'Search...',
                style: TextStyle(color: Color(0xFF9E9E9E)),
              ),
              floatingLabelStyle: TextStyle(color: Color(0xFF9E9E9E)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Theme.of(context).hoverColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Theme.of(context).hoverColor)),
              hintStyle: TextStyle(color: Colors.grey[500]),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).hoverColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onChanged: ((value) {
              setState(() {
                text = value;
              });
            }),
          )),
 Container(
            margin: EdgeInsets.only(right: 10 ,left: 5),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Color(0xFF565E70),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              onPressed: (){    FocusScope.of(context).unfocus();
},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ) ,
        ]),
      ),
    );
    
  }
}
