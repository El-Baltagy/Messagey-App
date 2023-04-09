import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messagy_app/shared/components/tabs.dart';
import '../../shared/colors.dart';
import '../../shared/components/size_config.dart';
import '../../shared/components/widgets.dart';
import '../../shared/network/local/cash_helper.dart';
import '../chat_sc/chat_sc.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class Login extends StatelessWidget {
   Login({
    required this.formKey,
  });

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLoginCubit, SocialLoginStates>(
      listener: (context, state) {
        if (state is SocialLoginErrorState) {
          showSnackBar(
             context, state.error,
            backgroundColor:Colors.red ,
            colorText: primaryco2,
          );}
        if(state is SocialLoginSuccessState ) {
          showSnackBar(
              context, 'تم تسجيل الدخول بنجاح',
              backgroundColor:Colors.green ,
              colorText: primaryco1,
          );

          CashHelper.saveData(
            key: 'uId',
            value: state.uId,
          ).then((value)
          {
            GoPage().navDelete(context, ChatSc());
          });

        }

      },
      builder: (context, state) {
        final cubit=SocialLoginCubit.get(context);
        return Column(
          children: [
            buildTextFormField(
              controller:emailController ,
              Type:TextInputType.emailAddress,
              validator: ( value) {
                if (value!.isEmpty) {
                  return 'please enter your email address';
                }
                return null;
                },
              labelTitle:'Email Address',
              prefix: Icons.email_outlined,
            ),
            VerticalSpacing(),
            buildTextFormField(
              controller:passwordController ,
              Type:TextInputType.visiblePassword,
              labelTitle:'Password',
              prefix: Icons.lock_outline,
              suffix: cubit.isPassword?
              Icons.visibility_off:Icons.visibility_outlined,
              isPassword: cubit.isPassword,
              suffixPressed:() {
                cubit.changePasswordVisibility();
              },
              onSubmit: (value) {
                if (formKey.currentState!.validate()) {
                  SocialLoginCubit.get(context).userLogin(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                }},
              validator: ( value) {
                if (value!.isEmpty) {
                  return 'password is too short';}return null;},
            ),
            ConditionalBuilder(
              condition: state is! SocialLoginLoadingState,
              builder: (context) =>Button(
                color:primaryco1,text: 'login',radius: 10,
                onPressed:() {
                  if (formKey.currentState!.validate()) {
                    SocialLoginCubit.get(context).userLogin(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  }
                },
              ),
              fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0,top: 5),
              child: Row(
                children: [
                  myDivider(
                    color: primaryco2,
                    width: MediaQuery.of(context).size.width/4
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Or Continue With'),
                  ),
                  myDivider(
                      color: primaryco2,
                      width: MediaQuery.of(context).size.width/4
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                cubit.GoogleSignIn(context).then((value) {
                  if (value) {
                    showSnackBar(
                      context, 'تم تسجيل الدخول بنجاح',
                      backgroundColor:Colors.green ,
                      colorText: primaryco1,
                    );
                    GoPage().navDelete(context, ChatSc());
                  }
                });
              },
              child: SvgPicture.asset(
                "assets/icons/google-color-svgrepo-com.svg",
              ),
            ),
          ],
        );
      },
    );
  }
}
