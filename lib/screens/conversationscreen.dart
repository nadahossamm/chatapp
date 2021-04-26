import 'package:chatapp/services/Database.dart';
import 'package:chatapp/services/constatnts.dart';
import 'package:flutter/material.dart';



class conversation extends StatefulWidget{
  final String chatroomid;

   conversation( this.chatroomid) ;
  @override
  _conversationState createState() => _conversationState();
}

class _conversationState extends State<conversation> {
  DatabaseMethod databaseMethod=DatabaseMethod();
  String message='';
  Stream chatmessagestream;
  @override
  void initState()
  {
    databaseMethod.getconversationmessage(widget.chatroomid).then((val){
            setState(() {
              chatmessagestream=val;

            });

    });
    super.initState();
  }
  Widget chatlist()
  {
          return StreamBuilder(
            stream:chatmessagestream,
            builder: (context,snapshot){
              return snapshot.hasData? ListView.builder(
                  itemCount:snapshot.data.docs.length ,
                  itemBuilder: (context,index){
                    return messagetile(snapshot.data.docs[index]['message'],snapshot.data.docs[index]['sendby']==constants.myname);
                  }):Container();
            }
            ,
          );

  }
  sendmessage()
  {
    Map<String,dynamic> messageMap={
      'message':message,
      'sendby':constants.myname,
      'time':DateTime.now().millisecondsSinceEpoch

    };
    databaseMethod.addconversationmessage(widget.chatroomid, messageMap);
    setState(() {
     //message = "";
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Container(
        child: Stack(

          children: [
            chatlist(),
            Container(
              alignment: Alignment.bottomCenter,

              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(

                      child: TextField(

                        decoration: InputDecoration(
                          hintText: "Massage...",
                        ),
                        onChanged: (val)
                        {
                          setState(() {
                            message=val;
                          });
                        }
                        ,
                      ),
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                        sendmessage();

                      },
                      child: Icon (Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messagetile extends StatelessWidget
{
  final String message;
  final bool issendbyme;
  const messagetile( this.message, this.issendbyme);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: issendbyme?0:5,vertical:issendbyme?5:0),

      width: MediaQuery.of(context).size.width,
      alignment:issendbyme?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:8),
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
        decoration:BoxDecoration(

          color: issendbyme ?  Colors.blueAccent: Colors.black,
            borderRadius: issendbyme? BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23),
            ):
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23),
            )

        ),
          child: Text(message,style: TextStyle(color: Colors.white),),

    ),
      );
  }

}



