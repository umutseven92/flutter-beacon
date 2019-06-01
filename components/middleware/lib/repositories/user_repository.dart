import 'dart:async';
import '../middleware.dart';

enum LogInMethod { email, facebook, twitter, google }
enum UserAccountStatus { LOGGED_OUT, PENDING_ONBOARDING, LOGGED_IN,}

abstract class UserRepository {

  Future<String> existingAuthId();

  Future<bool> logIn();

  Future<bool> createAccount(NewUser onboardUser);
  
  Future<void> logOut();



  // Future<void> registerNotificationToken(String userId);
  Future<User> getUser(String userId);
}