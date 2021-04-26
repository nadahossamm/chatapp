import 'package:chatapp/screens/conversationscreen.dart';
import 'package:chatapp/services/Database.dart';
import 'package:chatapp/services/constatnts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class searchscreen extends StatefulWidget {
  // This widget is the root of your application.


  @override
  _searchscreenState createState() => _searchscreenState();
}



class _searchscreenState extends State<searchscreen> {

  DatabaseMethod database=DatabaseMethod();
  String searchname;
  QuerySnapshot searchSnapshot;
  initialsearch()
  {
    database.getuserbyusername(searchname).then((val){
      setState(() {
        searchSnapshot=val;
      });

    });
              print(searchSnapshot);
  }
  @override
  void initialstate() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {




    Widget Userssearch()
    {
      if(searchSnapshot == null)
        return Container();
      else
      { return ListView.builder(
          shrinkWrap: true,
          itemCount:searchSnapshot.docs.length ,
          itemBuilder: (context,index) {
            return  searchlist(
              username: searchSnapshot.docs[index]["name"],
              email: searchSnapshot.docs[index]["email"],


              // email: searchSnapshot.documents[index].data('email'),
            );
          }

      );
      }
    }


    return  Scaffold(
      appBar: AppBar(
        title: Text('Search for friend'),
      ),
      body: Container(
        child: Column(

          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration:new InputDecoration(
                      hintText: 'Seaech by username',

                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (val)
                    {
                      setState(() {

                        searchname=val;

                      });

                    },
                  ),
                ),
                GestureDetector(
                    onTap: (){
                      initialsearch();
                      print(searchSnapshot);
                      print('asdfghj');
                    },


                    child: Icon(Icons.search)
                )
              ],
            ),

            Expanded(child: Userssearch()),


          ],
        ),
      ),
    );

  }


}

class searchlist extends StatelessWidget
{
  final String username;
  final String email;
  searchlist({this.username,this.email});

  @override
  Widget build(BuildContext context) {


    return Container (
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(right: 8),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(username,style: TextStyle(color: Colors.white),),
                Text(email,style: TextStyle(color: Colors.white)),
              ],

            ),
          ),
          Container(

            color: Colors.deepPurple,
            padding: EdgeInsets.all(10),

            child: GestureDetector(

              onTap: (){
                createchatroom(username,context);
              },
              child: Container(

                child: Text("Message",style: TextStyle(color: Colors.white)),
              ),

            ),

          ) ,
        ],

      ),
    );



  }
}

getchatroomid(String a,String b)
{


  if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0))
  {
    return "$b\_$a";
  }
  else
    return "$a\_$b";
}

createchatroom(String username,BuildContext context)
{
  List <String>Users=[username,constants.myname];
  String chatroomid= getchatroomid(username,constants.myname);
  Map <String,dynamic> chatRoomMap=
  {
    'users':Users,
    'Chatroomid':chatroomid
  };
  DatabaseMethod().createchatroom(chatroomid, chatRoomMap);
  Navigator.push(context, MaterialPageRoute(builder: (context )=>conversation(chatroomid)));

}
