import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homekeeper/pages/navigationpage.dart';

import '../app_config.dart';

class PreLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to HomeKeeper'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Go to Login Page'),
                onPressed: () {}
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              RaisedButton(
                child: Text(
                    'Continue as ${AppConfig.of(context).globalState.accountName}',textAlign: TextAlign.center,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NavigationPage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
