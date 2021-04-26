import 'package:chatapp/screens/chatpage.dart';
import 'package:chatapp/services/Database.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/sharedprefrance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'SignupPage.dart';



class login extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
Authmethods auth=Authmethods();
DatabaseMethod databaseMethod=DatabaseMethod();
  String error='';
  String email='';
  String password='';
  final _formkey=GlobalKey<FormState>();
  QuerySnapshot querySnapshotuserinfo;
  login(email,password)
  {
    if(_formkey.currentState.validate())
    {
      auth.signInWithEmailAndPassword(email, password).then((val){
        if(val!=null)
        {

          HelperFunctions.saveuserlogin(true);
          HelperFunctions.saveuseremail(email);
          databaseMethod.getuserbyuseremail(email).then((val){
            querySnapshotuserinfo=val;
            HelperFunctions.saveusername(querySnapshotuserinfo.docs[0]['name']);
          });
          Navigator.push(context, MaterialPageRoute(builder: (context )=>chat()));
        }
        else
          {
            return error='Invalid email or passsord';
          }
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar:  AppBar(
        backgroundColor: Colors.indigo[300],

        title: Text('Login'),

      ),
             body: Container(

              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Column(

                    children: [

                      Text("Scholar Chat",style: TextStyle(color: Colors.white,fontSize: 30),),

                      Form(
                        key: _formkey,
                          child:Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Text("Login",style: TextStyle(color: Colors.white,fontSize: 25),),
                                SizedBox(height: 20,),

                                TextFormField(



                                  decoration: new InputDecoration(

                                    hintText: 'Enter mail',
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),

                                  ),
                                  onChanged: (val){
                                    setState(() {
                                      email=val;
                                    });
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) =>val.isEmpty?"Email can't be empty":null,

                                ),
                                SizedBox(height: 10,),

                                TextFormField(

                                  validator: (val) =>val.isEmpty?"Password can't be empty":null,

                                  decoration: new InputDecoration(

                                    hintText: 'Enter Password',
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),


                                  ),
                                  onChanged: (val){
                                    setState(() {
                                      password=val;
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: true,

                                ),
                                // SizedBox(height: 10,),
                                Center(

                                  child:  Text(error,style: TextStyle(color: Colors.red,fontSize: 17),),

                                ),
                                Container(
                                  child: RaisedButton(onPressed: () async{

                                          login(email, password);
                                  }
                                    ,child: Text("Login",style: TextStyle(fontSize: 20),),color: Colors.white,
                                    shape: (
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                    ),),
                                  //height: 30,
                                  width: double.infinity,
                                ),

                                Row(

                                  // crossAxisAlignment:CrossAxisAlignment.end ,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text("Don't have an acoount?",style: TextStyle(fontSize:18,color: Colors.white),),
                                    FlatButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){return signup();}));
                                    }, child:Text('SignUp',style: TextStyle(fontSize:18,color: Colors.white),),),

                                  ],
                                )

                              ],

                            ),
                          )
                      ),

                    ],
                  ),
                ],
              )

          )
    );
  }
}
