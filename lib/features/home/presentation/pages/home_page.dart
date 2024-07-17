import 'package:flutter/material.dart';
import 'package:zaha/core/routes/routes_name.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              //<HomeViewModel>(context, listen: false).signOut();
              Navigator.pushNamed(context, RoutesName.signInScreen);
            },
          )
        ],
      ),
      body: Center(child: Text('Welcome Home!')),
    );
  }
}
