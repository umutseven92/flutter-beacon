// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'main_template.dart' as app;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:back_end_impl/back_end_impl.dart';

void main() async {
  
  CloudFunctions functions = CloudFunctions.instance;
  Firestore firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  
  FirebaseUserRepository userRepository= FirebaseUserRepository(
    auth: auth,
    firestore: firestore,
    cloudFunctions: functions,
  );

  app.main(
    userRepository: userRepository,
  );
}
