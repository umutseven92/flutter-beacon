import 'package:flutter/material.dart';
import 'package:blocs/blocs.dart';
import 'package:middleware/middleware.dart';
import '../providers/user_bloc_provider.dart';
import 'package:flutter_beacon/helpers/helpers.dart';
import 'dart:async';
class NewAccountPage extends StatefulWidget {
  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> with LoadingAndErrorDialogs {

  UserBloc _userBloc;
  List<StreamSubscription<dynamic>> _subscriptions;


  NewUser newUserData = NewUser();

  @override
  dispose(){
    _subscriptions?.forEach((subscription) => subscription.cancel());
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _initBlocs();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => _userBloc.logOut.add(null),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _userBloc.register.add(newUserData),
          ) 
        ],
        title: Text('Create account'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // _nameInput(),
            // _emailInput(),
            // _locationInput(),
            // _bioInput(),
          ],
        )
      ),
    );
  }



  _initBlocs(){
    if(_userBloc == null){
      _userBloc = UserBlocProvider.of(context);
      _subscriptions = <StreamSubscription<dynamic>>[
        _listenForChangesToAuthStatus(),
        _listenForOnboardCompletion(),
      ];
    }
  }

  StreamSubscription _listenForChangesToAuthStatus(){
    return _userBloc.accountStatus.listen((accountStatus) {
      if(accountStatus !=UserAccountStatus.PENDING_ONBOARDING){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (ctx) => RouteConverters.getFromAccountStatus(accountStatus)
        ));
      }
    });
  }

  StreamSubscription _listenForOnboardCompletion(){
    return _userBloc.isLoading.listen((loadingStatus) {
      if(loadingStatus){
        startLoading('Creating account', context);
      }
      else{
        stopLoading(context);
      }
    });
  }
}