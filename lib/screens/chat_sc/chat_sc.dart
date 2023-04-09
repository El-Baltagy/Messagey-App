import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagy_app/shared/colors.dart';
import 'package:messagy_app/shared/network/local/cash_helper.dart';

import '../../shared/components/widgets.dart';
import '../home.dart';

final _fireStore=FirebaseFirestore.instance;
late User signInUser;

class ChatSc extends StatefulWidget {

  @override
  State<ChatSc> createState() => _ChatScState();
}
 class _ChatScState extends State<ChatSc> {

   final _auth = FirebaseAuth.instance;
   String? _messaegeText;
   final _messageTextController=TextEditingController();

   @override
   void initState() {
     // TODO: implement initState
     getCurrentUser();
     super.initState();
   }
   void getCurrentUser() {
     try {
       final user = _auth.currentUser;
       if (user != null) {
         signInUser = user;
         print(signInUser.email);
       }
     } catch (e) {
       print(e.toString());
     }
   }
   // void getData()async{
   //   final messages=await _fireStore.collection('messages').get();
   //   for(var message in messages.docs){
   //     print(message.data());
   //   }
   // }
   // void messageStream()async{
   //   await for(var snapShot in _fireStore.collection('messages').snapshots()){
   //     for(var snapShot in snapShot.docs ){
   //       print(snapShot.data());
   //     }
   //   }
   // }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.yellow[900],
         title: Row(
           children: [
             Image.asset('assets/images/logo.png', height: 25,),
             const SizedBox(
               width: 10,
             ),
             const Text('Messagey App',
             style: TextStyle(
               color: primaryco1
             ),)
           ],
         ),
         actions: [
           IconButton(
             icon: const Icon(Icons.close,color: primaryco1),
             onPressed: () {
               _auth.signOut();
               CashHelper.removeData(key: 'uId');
               GoPage().navigateAndFinish(context, HomeSc());
             },
           ),
         ],
       ),
       body: SafeArea(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             MessageStreamBuilder(),
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 const SizedBox(
                   width: 5,
                 ),
                 Expanded(
                     child: buildTextFormField(
                         labelTitle: 'Write Your Message Here....',
                         onChange: (value) {
                           _messaegeText=value;
                         },
                         border: InputBorder.none,
                         controller: _messageTextController,
                     )
                 ),
                 TextButton(onPressed: () {
                   if (_messaegeText!=null) {
                     _fireStore.collection('messages').add({
                       'text':_messaegeText,
                       'sender':signInUser.email,
                       'time':FieldValue.serverTimestamp(),
                     });
                   }
                   _messageTextController.clear();
                 },
                  child: const Text('Send',
                       style: TextStyle(
                           color: primaryco1,
                           fontWeight: FontWeight.bold,
                           fontSize: 18
                       ),))
               ],
             ),
           ],
         ),
       ),
     );
   }
 }


class MessageStreamBuilder extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('messages').orderBy('time').snapshots(),
        builder: (context ,snapShot){
          List<Padding> _messageWidgets=[];

          final messages =snapShot.data!.docs.reversed;
          for(var message in messages){
            final messageText=message.get('text');
            final messageSender=message.get('sender');
            final currentUser=signInUser.email;

            final messageWidget=buildMessage(
            messageSender: messageSender,messageText:messageText,
              isMe:currentUser==messageSender );
            _messageWidgets.add(messageWidget);
          }
          if (!snapShot.hasData) {
            return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  child: ListView(
                    reverse: true,
                    children: _messageWidgets,
                  ),
                ));
          }else{
            return Container();
          }

        }
    );
  }
}
Padding buildMessage({
  required String messageText,
  required String messageSender,
  required bool isMe,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
       crossAxisAlignment:isMe? CrossAxisAlignment.end :CrossAxisAlignment.start,
      children: [
        Text(messageSender,
          style: TextStyle(
              fontSize: 12,color: Colors.yellow[900]
          ),),
        Material(
          elevation: 5,
          borderRadius: isMe? const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ):
          const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color:isMe?  primaryco1 :primaryco2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
            child: Text(messageText,
              style:  TextStyle(
                  fontSize: 15,color: isMe? Colors.white:Colors.black45
              ),
            ),
          ),
        ),
      ],
    ),
  );
}