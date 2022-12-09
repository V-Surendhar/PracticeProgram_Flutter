import 'package:flutter/material.dart';
import 'package:timetracker/services/auth.dart';

import '../CustomWIdgets/showAlertDialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);

  final AuthBase auth;

  Future <void> _signOut() async{
    try{
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }

  }


  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: "Log out",
        content: "Are you sure that you want to logout ?",
        defaultActionText: "Cancel",
        cancelActionText: "Log out");

    if(didRequestSignOut == false){
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){_confirmSignOut(context);}, child: const Text("Log out", style: TextStyle(color: Colors.white,fontSize: 18.0,),)),
        ],
      ),
    );
  }
}
