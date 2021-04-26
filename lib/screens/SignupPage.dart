import 'package:chatapp/services/Database.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/sharedprefrance.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chatpage.dart';

class signup extends StatefulWidget{
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  Authmethods auth=Authmethods();
  DatabaseMethod database=DatabaseMethod();
String error='';
String email='';
String password='';
String name='';
final _formkey=GlobalKey<FormState>();
 // HelperFunctions helperFunctions=HelperFunctions();
  bool isValidEmail(email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
  signup()
  {
    if(_formkey.currentState.validate())
    {

      Map<String,String> userInfomap={
        'name':name,
        'email':email
      };
      database.adduserinfo(userInfomap);
      HelperFunctions.saveuserlogin(true);
      HelperFunctions.saveusername(name);
      HelperFunctions.saveuseremail(email);
      auth.signupWithEmailAndPassword(email, password).then((value) =>

          Navigator.push(context, MaterialPageRoute(builder: (context){
            return chat();
          })));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],

        title: Text('Signup'),

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

                            Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 25),),
                            SizedBox(height: 20,),
                            TextFormField(
                              decoration: new InputDecoration(

                                hintText: 'Enter your Name',
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),

                              ),

                              keyboardType: TextInputType.text,

                              onChanged: (val)
                              {
                                    setState(() {
                                      name=val;
                                    });
                              },

                              validator: (val) =>val.isEmpty?'Enter Your name':null,


                            ),
                            SizedBox(height: 10,),


                            TextFormField(

                              validator: (val) => isValidEmail(val) ? null : "Email should as 'example@gmail.com'",
                              decoration: new InputDecoration(

                                hintText: 'Enter mail',
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),


                              ),
                              onChanged: (val){
                                setState(() {
                                  email=val;
                                });
                              }
                              ,
                              keyboardType: TextInputType.emailAddress,

                            ),
                            SizedBox(height: 10,),

                            TextFormField(


                              validator: (val) =>val.length<6?'Password lengh should be bigger than or equal 6':null,


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
                            SizedBox(height: 10,),
                            Container(
                              child: RaisedButton(
                                onPressed: () async {

                                  signup();

                                },child: Text("Sign Up",style: TextStyle(fontSize: 20),),color: Colors.white,
                                shape: (
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                                ),),
                              //height: 30,
                              width: double.infinity,
                            ),


                          ],

                        ),
                      )
                  ),

                ],
              ),
            ],
          )

      ),
    );
  }
}
