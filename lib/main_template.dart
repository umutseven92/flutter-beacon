// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:blocs/blocs.dart';
import 'package:middleware/middleware.dart';
import 'package:flutter_beacon/providers/user_bloc_provider.dart';
import 'package:flutter_beacon/pages/pages.dart';

void main({
  @required UserRepository userRepository,
}) {
  runApp(
    UserBlocProvider(
      bloc:  UserBloc(userRepository),
        child:MaterialApp(
          title: "Flutter Beacon",
          debugShowCheckedModeBanner: false,
          home: LoadingPage(),
        ),
      ),
    );
}
