import 'package:middleware/middleware.dart';
import 'package:flutter_beacon/pages/pages.dart';
import 'package:flutter/material.dart';

class RouteConverters {

  static Widget getFromAccountStatus(UserAccountStatus accountStatus) {
    switch (accountStatus) {
      case UserAccountStatus.LOGGED_OUT:
        return LoginPage();
      case UserAccountStatus.LOGGED_IN:
        return ProfilePage();
      case UserAccountStatus.PENDING_ONBOARDING:
        return NewAccountPage();
      default:
        return null;
    }
  }
}