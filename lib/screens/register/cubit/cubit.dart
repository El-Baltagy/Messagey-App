import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messagy_app/screens/register/cubit/states.dart';

import '../../../models/social_model.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
bool isInside=false;
bool isPassword1=true;
bool isPassword2=true;
IconData suffix = Icons.visibility_outlined;
bool isPassword = true;

isTapped(bool value){
  isInside=value;
  emit(changFormTap());
}
obsucre1(){
  isPassword1=!isPassword1;
  emit(passwordChange1());
}
obsucre2(){
    isPassword2=!isPassword2;
    emit(passwordChange2());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
 bool passwordStrong=false;
  passwordChangeState(val){
    passwordStrong=val;
    emit(SocialRegisterInitialState());
  }

  void userRegister({
    required String name,email, password,
  }) {
    debugPrint('hello');

    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {

      debugPrint('xxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      emit(SocialRegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }


String passwordConfirmed='';
savePassword(value){
  passwordConfirmed=value;
  emit(SocialRegisterInitialState());
}

}