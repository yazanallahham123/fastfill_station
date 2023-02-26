import 'package:equatable/equatable.dart';


abstract class OTPState extends Equatable{

  const OTPState();

  @override
  List<Object?> get props => [];
}

class InitOTPState extends OTPState{
  const InitOTPState();
}

class LoadingOTPState extends OTPState{
  const LoadingOTPState();
}

class ErrorOTPState extends OTPState{
  final String error;

  const ErrorOTPState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class OTPResendCodeState extends OTPState{
  final String registerId;

  const OTPResendCodeState(this.registerId);

  @override
  List<Object?> get props => [this.registerId];
}