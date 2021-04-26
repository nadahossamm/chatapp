import 'package:chatapp/screens/LoginPage.dart';
import 'package:chatapp/screens/searchscreen.dart';
import 'package:chatapp/services/constatnts.dart';
import 'package:chatapp/services/sharedprefrance.dart';
import 'package:flutter/material.dart';


class chat extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  void initState()
  {
    getuserinfo();
    super.initState();
  }

  getuserinfo()async
  {
    constants.myname=await HelperFunctions.getusername();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context )=>searchscreen()));

          },
            child: Text('Search'),
          ),
        ),

    );
  }
}




