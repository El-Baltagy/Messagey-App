// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../shared/components/widgets.dart';
//
// class VerifyEmail extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text(
//               'News Feed',
//             ),
//           ),
//           body: ConditionalBuilder(
//             condition: SocialCubit.get(context).model != null,
//             builder: (context) {
//               var model = FirebaseAuth.instance.currentUser!.emailVerified;
//               print(model);
//
//               return Column(
//                 children: [
//                   if (!model)
//                     Container(
//                       color: Colors.amber.withOpacity(.6),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0,
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.info_outline,
//                             ),
//                             const SizedBox(
//                               width: 15.0,
//                             ),
//                             const Expanded(
//                               child: Text(
//                                 'please verify your email',
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 15.0,
//                             ),TextButton(child: const Text('Verify'),
//                                 onPressed: () {
//                                   FirebaseAuth.instance.currentUser!.sendEmailVerification().then
//                                     ((value) {
//                                     showToast(text: 'check your mail', state: ToastStates.SUCCESS,
//                                     );});
//                                 }
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//             fallback: (context) => const Center(child: CircularProgressIndicator()),
//           ),
//         );
//       },
//     );
//   }
// }
