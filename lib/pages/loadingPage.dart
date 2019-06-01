import 'package:flutter/material.dart';
import 'package:flutter_beacon/helpers/helpers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:blocs/blocs.dart';
import 'package:flutter_beacon/providers/user_bloc_provider.dart';
import 'package:flutter_beacon/providers/user_bloc_provider.dart';
import 'dart:async';
import 'package:middleware/middleware.dart';

class LoadingPage extends StatefulWidget  {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with LoadingAndErrorDialogs {
  
  UserBloc _userBloc;
  List<StreamSubscription<dynamic>> _subscriptions;

  @override
  dispose(){
    _subscriptions?.forEach((subscription) => subscription.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initBlocs();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _appName(),
              Expanded(child: _loginButton()),
            ],
          ),
        ),
      ),
    );
  }

  
  _initBlocs(){
    if(_userBloc == null){
      _userBloc = UserBlocProvider.of(context);
      _subscriptions = <StreamSubscription<dynamic>>[
        _pageNavigatorListener(),
      ];
    }
  }
  StreamSubscription _pageNavigatorListener(){
    return _userBloc.accountStatus.listen((accountStatus) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (ctx) => RouteConverters.getFromAccountStatus(accountStatus)
      ));
    });
  }



  Widget _appName(){
    return Text(
      'Flutter Beacon',
      style: Theme.of(context).textTheme.display1,
    );
  }
  Widget _loginButton(){
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }


}