abstract class SocialRegisterStates {}

class changFormTap extends SocialRegisterStates {}
class passwordChange1 extends SocialRegisterStates {}
class passwordChange2 extends SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {
  final String uId;

  SocialRegisterSuccessState(this.uId);
}

class SocialRegisterErrorState extends SocialRegisterStates
{
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates
{
  final String error;

  SocialCreateUserErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {}
