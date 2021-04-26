import 'package:chatapp/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Authmethods
{
  FirebaseAuth _auth= FirebaseAuth.instance;

  userclass _userFromfirebaseuser(User user)
  {
    return user !=null? userclass (userId:user.uid):null;
  }



  Future signupWithEmailAndPassword (String email,String password)
  async {
    try
    {
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user=result.user;
      return _userFromfirebaseuser(user);
    }
    catch(ex)
    {
      print (ex.toString());
      return null;
    }

  }

  Future signInWithEmailAndPassword (String email,String password)
  async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromfirebaseuser(user);
    }
    catch (ex) {
      print(ex.toString());
      return null;
    }
  }



}