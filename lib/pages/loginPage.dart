import 'package:flutter/material.dart';
import 'package:flutter_beacon/helpers/helpers.dart';
import 'package:blocs/blocs.dart';
import 'package:flutter_beacon/providers/user_bloc_provider.dart';
import 'dart:async';
import 'package:middleware/middleware.dart';

class LoginPage extends StatefulWidget  {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoadingAndErrorDialogs {
  
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _appName(),
              _promoMessage(),
              _loginButton(),
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
        _loadingListener(),
        _successListener(),
        _errorListener(),
      ];
    }
  }

  StreamSubscription _loadingListener(){
    return _userBloc.isLoading.listen((loadingStatus) {
      if(loadingStatus){
        startLoading("Logging in", context);
      }
      else{
        stopLoading(context);
      }
    });
  }

  StreamSubscription _successListener(){
    return _userBloc.accountStatus.listen((accountStatus) {
      if(accountStatus !=UserAccountStatus.LOGGED_OUT){
        print('push');
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (ctx) => RouteConverters.getFromAccountStatus(accountStatus)
        ));
      }
    });
  }


  StreamSubscription _errorListener(){
    return _userBloc.hasError.listen((errorMessage) {
      displayError(errorMessage, context);
    });
  }


  Widget _appName(){
    return Text(
      'Flutter Beacon',
      style: Theme.of(context).textTheme.display1,
    );
  }

  Widget _promoMessage(){
    return Text(
      'Join 5000 Flutter Devs worldwide!',
      style: Theme.of(context).textTheme.subhead,
    );
  }

  Widget _loginButton(){
    return RaisedButton(
      child: Text(
        'Log in with Google'
      ),
      color: Colors.white,
      onPressed: _logIn,
    );
  }


  _logIn() => _userBloc.logIn.add(null);
  

}