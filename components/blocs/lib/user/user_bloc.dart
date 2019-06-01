import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:middleware/middleware.dart';

class UserBloc {
  final UserRepository repository;

  List<StreamSubscription<dynamic>> _subscriptions;

  final _currentUserController =  BehaviorSubject<User>(seedValue: null);
  Stream<User> get currentUser => _currentUserController.stream; 
  
  final _existingAuthController = BehaviorSubject<String>(seedValue: null);
  Stream<String> get existingAuthId => _existingAuthController.stream; 

  Observable<UserAccountStatus> _accountStatusController;
  Stream<UserAccountStatus> get accountStatus => _accountStatusController;

  final _createAccountController = PublishSubject<NewUser>();
  Sink<NewUser> get register => _createAccountController;

  final _logInController = PublishSubject<Null>();
  Sink<Null> get logIn => _logInController;

  final _logOutController = PublishSubject<void>();
  Sink<void> get logOut => _logOutController;

  final _loadingController = PublishSubject<bool>();
  Observable<bool> get isLoading => _loadingController.stream;

  final _errorController = PublishSubject<String>();
  Observable<String> get hasError => _errorController.stream;

  final _successController = PublishSubject<bool>();
  Observable<bool> get isSuccessful => _successController.stream;

  UserBloc(this.repository) {
    _updateCurrentAuthId();


    _accountStatusController = Observable.combineLatest2<String, User, UserAccountStatus>(existingAuthId, _currentUserController, _redirectPath).asBroadcastStream();
    
    _subscriptions = <StreamSubscription<dynamic>>[
      _logInController.listen(_logInUser),
      _logOutController.listen(_logOutUser),
      _createAccountController.listen(_onboardUser),
      _currentUserController.listen((user) => print('got user: $user')),
      _existingAuthController.listen((user) => print('got auth: $user')),
      _accountStatusController.listen((state) => print('got state: $state')),
    ];
  }

  _loadCurrentUser()async{
    String userId = _existingAuthController.value;
    User currentUser = await repository.getUser(userId);
    _currentUserController.add(currentUser);
  }
  UserAccountStatus _redirectPath(String authId, User currentUser){
    if(authId == null){
      return UserAccountStatus.LOGGED_OUT;
    }else{
      if(currentUser == null){
        return UserAccountStatus.PENDING_ONBOARDING;
      }else{
        return UserAccountStatus.LOGGED_IN;
      }
    }
  }

  _updateCurrentAuthId() async {
      String userId = await repository.existingAuthId();
      _existingAuthController.add(userId);
      _loadCurrentUser();
    }

  _logInUser([_]) async {
    _loadingController.add(true);
    bool success = await repository.logIn();
    _updateCurrentAuthId();
    _loadingController.add(false);
    if(success){
      _successController.add(true);
    }else{
      _errorController.add('Failed to log in');
    }
  } 

  _logOutUser([_]) async {
      _existingAuthController.add(null);
      await repository.logOut();
  }


  _onboardUser(NewUser newUserData) async {
    _loadingController.add(true);
    bool success = await repository.createAccount(newUserData);
    _loadingController.add(false);
    if(success){
      _successController.add(true);
    }else{
      _errorController.add('Failed to create, this might be because the username has now been taken.');
    }
  } 


  // _loadCurrentUser([_]) async {
  //   _loadingController.add(true);

  //   String userId = await existingAuthId.first;
  //   await repository.getCurrentUser(userId);

  //   BehaviorSubject<User> userStream = BehaviorSubject<User>();
  //   userStream.addStream(repository.getUser(userId));
  //   await userStream.isEmpty; 
  //   _loadingController.add(false);
  //   _currentUserController.add(userStream);
  // }

  void dispose() {
    _currentUserController.close();
    _existingAuthController.close();
    _loadingController.close();
    _logInController.close();
    _logOutController.close();
    _errorController.close();
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}