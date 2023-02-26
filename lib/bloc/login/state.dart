import 'package:equatable/equatable.dart';

import '../../model/login/login_user.dart';


abstract class LoginState extends Equatable{

  const LoginState();

  @override
  List<Object?> get props => [];
}

class InitLoginState extends LoginState{
  const InitLoginState();
}

class LoadingLoginState extends LoginState{
  const LoadingLoginState();
}

class ErrorLoginState extends LoginState{
  final String error;

  const ErrorLoginState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class SuccessLoginState extends LoginState{
  final LoginUser loginUser;

  const SuccessLoginState(this.loginUser);

  @override
  List<Object?> get props => [this.loginUser];
}

class GotShowSignupInStationApp extends LoginState{
  final bool showSignupInStationApp;

  const GotShowSignupInStationApp(this.showSignupInStationApp);

  @override
  List<Object?> get props => [this.showSignupInStationApp];
}
