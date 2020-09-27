import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_shoping_mall/screeens/home.dart';

class MyService extends StatefulWidget {
  MyService({Key key}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  Widget signOutButton() {
    return IconButton(
        icon: Icon(Icons.exit_to_app),
        tooltip: 'sign out',
        onPressed: () {
          myalert();
        });
  }

  void myalert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want sign out?'),
          actions: [cancelButton(), okButton()],
        );
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('cancel'));
  }

  Widget okButton() {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          processSignout();
        },
        child: Text('ok'));
  }

  Future<void> processSignout() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (context) => Home(),
      );
      Navigator.of(context)
          .pushAndRemoveUntil(materialPageRoute, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My service app'),
        actions: [signOutButton()],
      ),
      body: Text('body'),
    );
  }
}
