import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import '../../shared/colors.dart';
import '../../shared/components/size_config.dart';
import '../../shared/components/widgets.dart';
import '../../shared/network/local/cash_helper.dart';
import '../home.dart';
import '../login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    required this.formKey
});
  final GlobalKey<FormState> formKey;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterSuccessState) {
            CashHelper.saveData(key: 'uId', value:state.uId );
            // GoPage().navigateAndFinish(context, SocialLoginScreen(),);
          }
        },
        builder: (context, state) {
          final cubit=SocialRegisterCubit.get(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFormField(
                controller: nameController,Type:TextInputType.name ,
                labelTitle:'User Name' ,prefix:Icons.person,
                validator:( value) {
                  if (value!.isEmpty) {
                    return 'please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              buildTextFormField(
                  controller: emailController,Type:TextInputType.emailAddress ,
                  labelTitle:'Email Address' ,prefix:Icons.email_outlined,
                  validator:( value) {
                    if (value!.isEmpty) {
                      return 'please enter your email address';
                    }
                    return null;
                  },
                  OnTap:(){
                    cubit.isTapped(false);
                  }
              ),
              const SizedBox(
                height: 15.0,
              ),
              buildTextFormField(
                  controller: passwordController,
                  Type:TextInputType.visiblePassword ,
                  labelTitle:'Password' ,prefix:Icons.lock_outline,
                  isPassword: cubit.isPassword1,
                  suffix: cubit.isPassword1?
                  Icons.visibility_off:Icons.visibility_outlined,
                  suffixPressed: (){
                    cubit.obsucre1();
                  },
                  validator:( value) {
                    if (value!.isEmpty) {
                      return 'password must not be Empty';
                    }else if (!cubit.passwordStrong) {
                      return 'password must be Strong';
                    }
                    return null;
                  },
                  OnTap:(){
                    cubit.isTapped(true);
                  },
                onChange: (p0) {
                  cubit.savePassword(p0);
                },
              ),
              cubit.isInside?Column(
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 200,
                    child: FlutterPwValidator(
                        controller: passwordController,
                        minLength: 6,
                        uppercaseCharCount: 1,
                        numericCharCount: 3,
                        specialCharCount: 1,
                        width: 400,
                        height: 150,
                        onSuccess: (){
                          cubit.passwordChangeState(true);
                        },
                      onFail: (){
                        cubit.passwordChangeState(false);
                      },
                    ),
                  ),
                ],
              ):
              Container(),
              const SizedBox(
                height: 15.0,
              ),
              buildTextFormField(
                  controller: passwordController2,
                  Type:TextInputType.visiblePassword ,
                  labelTitle:'Confirm Password' ,prefix:Icons.lock_outline,
                  isPassword: cubit.isPassword2,
                  suffix: cubit.isPassword2?
                  Icons.visibility_off:Icons.visibility_outlined,

                  suffixPressed: (){
                    cubit.obsucre2();
                  },
                  validator:( value) {
                    if (value!.isEmpty) {
                      return 'password must not be Empty';
                    }else if (value!=cubit.passwordConfirmed) {
                      return 'Non identical password';
                    }
                    return null;
                  },
                  OnTap:(){
                    cubit.isTapped(false);
                  }

              ),
              const SizedBox(
                height: 40.0,
              ),

              ConditionalBuilder(
                condition: state is! SocialRegisterLoadingState,
                builder: (context) =>
                    Button(
                      color:Color(0xff2e386b),text: 'register'.toUpperCase(),radius: 10,
                      onPressed:() {
                        if (formKey.currentState!.validate()) {
                          cubit.userRegister(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                    ),
                fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        },
      ),
    );
  }
}
