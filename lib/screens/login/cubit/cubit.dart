import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messagy_app/screens/login/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../shared/colors.dart';
import '../../../shared/components/widgets.dart';
import '../../../shared/network/local/cash_helper.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  bool isLogin=true;
  bool isPassword = true;

  void changeTab(value){
    if (value==0) {
      isLogin=true;
    } else{
      isLogin=false;
    }
    emit(WelcomeInitialState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          emit(SocialLoginSuccessState(value.user!.uid));
    })
        .catchError((error)
    {
      emit(SocialLoginErrorState(error.toString()));
    });
  }


  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(SocialChangePasswordVisibilityState());

  }
  Future<bool>GoogleSignIn(context){
    return SignInMethods().signInWithGoogle(context);

  }
  SignOut(){
    SignInMethods().signOut();
  }

  showMessgae(context){
    showSnackBar(
      context, 'تم تسجيل الدخول بنجاح',
      backgroundColor:Colors.green ,
      colorText: primaryco1,
    );
  }

}


class SignInMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
          });
          // CashHelper.saveData(
          //   key: 'uId',
          //   value:  user.uid,
          // );
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}