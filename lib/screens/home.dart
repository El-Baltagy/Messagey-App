import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messagy_app/screens/register/register_screen.dart';
import 'package:messagy_app/shared/components/tabs.dart';
import '../../shared/components/size_config.dart';
import '../../shared/components/widgets.dart';
import '../../shared/network/local/cash_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'login/cubit/cubit.dart';
import 'login/cubit/states.dart';
import 'login/login_screen.dart';


class HomeSc extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SocialLoginCubit, SocialLoginStates>(

      builder: (context, state) {
        SizeConfig().init(context);
        final cubit=SocialLoginCubit.get(context);
        return  Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode:AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 180,
                                child: Image.asset('assets/images/logo.png'),
                              ),
                              VerticalSpacing(of: 10),
                              Text(
                                'Messagey App',
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: Color(0xff2e386b),fontSize: 30
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      VerticalSpacing(of: 50),
                      Container(
                        width: SizeConfig.screenWidth * 0.8, // 80%
                        decoration: BoxDecoration(
                          color: Color(0xff2e386b),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DefaultTabController(
                          length: 2,
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            indicatorColor: Colors.white,
                            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            labelColor: Color(0xff2e386b),
                            unselectedLabelColor:Colors.orange,
                            onTap: (value){
                              cubit.changeTab(value);
                            },
                            tabs: [Tab(text: "Login"), Tab(text: "Register")],
                          ),
                        ),
                      ),
                      VerticalSpacing(of: 30),
                      Text(
                        '${cubit.isLogin?'Login':'Register'} now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Color(0xff2e386b),
                        ),
                      ),
                      VerticalSpacing(of: 20),
                      cubit.isLogin? Login( formKey: formKey):
                      RegisterScreen(formKey: formKey)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

