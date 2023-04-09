import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messagy_app/screens/chat_sc/chat_sc.dart';
import 'package:messagy_app/screens/home.dart';
import 'package:messagy_app/screens/login/cubit/cubit.dart';
import 'package:messagy_app/screens/login/login_screen.dart';
import 'package:messagy_app/shared/network/local/cash_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CashHelper.init();
  //
  // late Widget _widget;
  // var uId;
  //  uId=CashHelper.getData(key: 'uId');
  // if (uId ==null ) {_widget=HomeSc();
  // }else{
  //   _widget=ChatSc();
  // }
  runApp(MyApp(
      // _widget
  ));
}

class MyApp extends StatelessWidget {
  MyApp(
      // this.widget
      );
  // final Widget widget;
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(  create: (context) => SocialLoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: _auth.currentUser==null?'/':'chat',
        routes:
       {
         '/':(context) => HomeSc(),
         'chat':(context) =>ChatSc(),

       }
      ),
    );
  }
}
