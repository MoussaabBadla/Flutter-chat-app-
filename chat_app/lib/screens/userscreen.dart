import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userscreen extends StatefulWidget {
  const userscreen({Key? key, required this.selectthemes, required this.darkk})
      : super(key: key);
  static String route = '/user';
  final void Function() selectthemes;
  final bool darkk;

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  @override
  Widget build(BuildContext context) {
      InkWell inkfun(
    BuildContext context,
    void Function() Ontap,
    Icon moah,
    String title,
    Color koko,
  ) {
    return InkWell(
      onTap: Ontap,
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: 10, left: 5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: koko, borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  icon: moah,
                  color: Colors.white,
                )),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

    final routedate =
        ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
    final username = routedate['username'];
    final userimage = routedate['userimage'];
    void logout() async {
      await FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      appBar: AppBar(
                  iconTheme: IconThemeData(
    color: Theme.of(context).primaryColorDark,
  ),

        title: Text(
          'Me',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(170, 0, 0, 0),
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(-2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: CircleAvatar(
                  foregroundColor: Colors.black,
                  backgroundImage: Image.network(
                    userimage!,
                    fit: BoxFit.cover,
                  ).image,
                  radius: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  username!,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark, fontSize: 25),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          inkfun(
            context,
            widget.selectthemes,
          widget.darkk?  Icon(Icons.light_mode):Icon(Icons.dark_mode),
            widget.darkk? 'Light Theme' : 'DarkTheme',
            Color(0xFF03A9F1),
          ),
          inkfun(
            context,
            logout,
            Icon(Icons.logout),
            'Logout',
            Color(0xFF00AC83),
          ),
        ],
      ),
    );
  }

}
