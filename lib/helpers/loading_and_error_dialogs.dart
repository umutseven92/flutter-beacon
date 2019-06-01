import 'package:flutter/material.dart';


abstract class LoadingAndErrorDialogs {

  void startLoading(String message, BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(ctx) => WillPopScope(
        onWillPop: () {},
        child: Dialog(
          child: Container(
            padding: EdgeInsets.only(top:20.0, bottom: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  data: ThemeData(
                    accentColor: Colors.blue
                  ),
                  child: CircularProgressIndicator(),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10.0),),
                Text(
                  "$message...",
                  style: Theme.of(context).textTheme.button.apply(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void stopLoading(BuildContext context){
    Navigator.pop(context);
  }


  void displayError(String message, BuildContext context){
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          padding: EdgeInsets.only(top:20.0, bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: Text(
                    'Error',
                    style: Theme.of(context).textTheme.title,
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "$message",
                  style: Theme.of(context).textTheme.button.apply(color: Theme.of(context).errorColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text('Close'),
                    onPressed: () => Navigator.pop(ctx),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}