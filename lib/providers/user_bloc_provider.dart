// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:blocs/blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserBlocProvider extends StatefulWidget {
  final Widget child;
  final UserBloc bloc;

  UserBlocProvider({Key key, @required this.child, @required this.bloc})
      : super(key: key);

  @override
  _UserBlocProviderState createState() => _UserBlocProviderState();

  static UserBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_UserBlocProvider)
            as _UserBlocProvider)
        .bloc;
  }
}

class _UserBlocProviderState extends State<UserBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _UserBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

class _UserBlocProvider extends InheritedWidget {
  final UserBloc bloc;

  _UserBlocProvider({
    Key key,
    @required this.bloc,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_UserBlocProvider old) => bloc != old.bloc;
}
