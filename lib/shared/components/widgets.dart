import 'package:flutter/material.dart';





showSnackBar(
    BuildContext context, String text,{
      int sec=2,
      Color colorText=Colors.white,
      Color backgroundColor=Colors.red
    }) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
      Text(text,
        style: TextStyle(color: colorText,fontSize: 17),),
      duration: Duration(seconds: sec),
      backgroundColor: backgroundColor,
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,

  double radius = 3.0,
  required Function()? function,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Padding Button({
  required Color color,
  required String text,
  required Function() onPressed,
  bool isUpperCase = true,
  double radius = 10,
  double width = double.infinity,
  double height = 42,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Material(
        elevation: 5,
        color:color ,
        borderRadius: BorderRadius.circular(radius),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth:width , height:height ,
          child:  Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
                color: Colors.white
            ),
          ),
        )
    ),
  );
}

// void showToast({
//   required String text,
//   required ToastStates state,
// }) => Fluttertoast.showToast(
//       msg: text,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 5,
//       backgroundColor: chooseToastColor(state),
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );

// enum ToastStates { SUCCESS, ERROR, WARNING }
// Color chooseToastColor(ToastStates state) {
//   Color color;
//
//   switch (state) {
//     case ToastStates.SUCCESS:
//       color = Colors.green;
//       break;
//     case ToastStates.ERROR:
//       color = Colors.red;
//       break;
//     case ToastStates.WARNING:
//       color = Colors.amber;
//       break;
//   }
//
//   return color;
// }

TextFormField buildTextFormField({
  required String labelTitle,
   Function(String)? onChange,
  String? Function(String?)? validator,
   TextEditingController? controller,
  FocusNode? focusNode,
  bool isPassword=false,
   IconData? suffix,
   IconData? prefix,
   VoidCallback? OnTap,
   Function(PointerDownEvent)? OnTapOutside,
   Function(String)? onSubmit,
   Function()? suffixPressed,
TextInputType Type=TextInputType.emailAddress,
  EdgeInsetsGeometry? padding=const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
  InputBorder? border= const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10))
  )
}) {
  return TextFormField(
    // textAlign: TextAlign.center,
    onFieldSubmitted: onSubmit,
    validator: validator ,
    obscureText: isPassword,
    keyboardType:Type,
    controller:controller ,
    focusNode: focusNode,
    onChanged: onChange,
    onTap: OnTap,
    onTapOutside: OnTapOutside,
    decoration: InputDecoration(
      suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffix,color: Colors.orange)),
      prefixIcon: Icon(prefix,color: Colors.orange,) ,
        labelText: labelTitle,labelStyle: TextStyle(
      color: Color(0xff2e386b)
    ),
        contentPadding:  padding,
        border: border,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xff2e386b),width: 1
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color:  Colors.orange,width: 2
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
        )
    ),
  );
}

class GoPage {
  GoPage();

  void navDelete(
      context,
      widget,
      {bool Rt = false}
      ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );

  void navigateAndFinish(
      context,
      widget,
      {bool Rt = false}
      ) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) =>Rt,
      );
  pushNavigation(context, {
    required Widget path,
    var curve = Curves.ease,
    double x=0.2,
    double y=0,
  }) {
    Navigator.of(context).
    push(_createRoute(Sc: path,curve:curve,X:x ,Y:y ));
  }
  void popNavigation(context, {
    required Widget path,
    var curve = Curves.ease,
    double x=0.0,
    double y=0.2,
  }) {
    Navigator.of(context).pop(_createRoute(Sc: path,curve:curve,X:x ,Y:y ));
  }
  _createRoute({
    required Widget Sc,
    required var curve,
    required double X,Y,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Sc,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(X,Y);
        const end = Offset.zero;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

// void getNavigation({required Widget path, Transition transition=Transition.zoom,}){
//   Get.to((context)=>path,transition:transition,);
// }
}

myDivider({
  required Color color,
  double height=1,
  double width=1
}){
  return Container(
    height: height,
    width:width ,
    color: color,
  );
}


