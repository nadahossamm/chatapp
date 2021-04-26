import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod
{
  getuserbyusername(String username)
  async {
    return await FirebaseFirestore.instance.collection('users').where('name',isEqualTo: username).get();
  }

  getuserbyuseremail(String email)
  async {
  return await  FirebaseFirestore.instance.collection('users').where('email',isEqualTo: email).get();
  }
  
  adduserinfo(usermap)
  {
    FirebaseFirestore.instance.collection('users').add(usermap).catchError((e){
      print(e.toString());
    });
  }
  
  
  
  createchatroom(String chatroomid,chatroomMap)
  {
    FirebaseFirestore.instance.collection('ChatRoom').doc(chatroomid).set(chatroomMap).catchError((e){
      print(e.toString());
    });

    }
    
    addconversationmessage(String chatroomid,messageMap)
    {
      FirebaseFirestore.instance.collection('chatRoom').doc(chatroomid).collection('chats').add(messageMap).catchError((e){
        print(e.toString());
      });
    }

    getconversationmessage(String chatroomid)
    async {
     return await FirebaseFirestore.instance.collection('chatRoom').doc(chatroomid).collection('chats').orderBy('time').snapshots();
    }
  
}