// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:middleware/middleware.dart';

class FirebaseUserRepository implements UserRepository {
  static const String dbPath = 'user';
  
  final FirebaseAuth auth;
  final CloudFunctions cloudFunctions;
  final Firestore firestore;


  FirebaseUserRepository({
    @required this.auth, 
    @required this.cloudFunctions,
    @required this.firestore,
  });


  
  Future<String> existingAuthId() async {
    final user = await auth.currentUser();
    final hasAuth = user!=null;
    if(!hasAuth){
      return null;
    }
    return user.uid;
  }


  Future<bool> logIn() {
    return auth.signInAnonymously() 
      .then((user) async {
        return true;
      })
      .catchError((err) {
        print('catchError :$err');
        print(err.message);
        return false;
      });
  }


  Future<bool> createAccount(NewUser onboardUser) async {
    return true;
  }

  Future<void> logOut() async {
    auth.signOut();
  }

  Future<User> getUser(String userId){
    return firestore.document('user/$userId').snapshots().map((doc) {
      if(doc.data == null){
        return null;
      }
      return User.fromMap(doc.data);
    }).first;
  }

}

