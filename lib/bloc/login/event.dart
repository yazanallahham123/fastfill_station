import 'package:equatable/equatable.dart';
import '../../model/login/login_body.dart';

abstract class LoginEvent extends Equatable{

  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class InitLoginEvent extends LoginEvent {
  const InitLoginEvent();
}

class LoginUserEvent extends LoginEvent{
  final LoginBody loginBody;

  const LoginUserEvent(this.loginBody);

  @override
  List<Object?> get props => [this.loginBody];
}

class GetShowSignupInStationApp extends LoginEvent {
  const GetShowSignupInStationApp();
}