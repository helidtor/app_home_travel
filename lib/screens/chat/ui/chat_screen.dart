// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_home_travel/firebase/firebase_provider.dart';
// import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
// import 'package:mobile_home_travel/screens/chat/ui/chat_row.dart';
// import 'package:provider/provider.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   void initState() {
//     Provider.of<FirebaseProvider>(context, listen: false);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<UserChatModel> listUser = [];

//     return Scaffold(
//       appBar: AppBar(
//         surfaceTintColor: Colors.white,
//         shadowColor: Colors.grey,
//         automaticallyImplyLeading: false,
//         // centerTitle: true,
//         title: const Text(
//           "Tin nhắn",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(182, 0, 0, 0),
//             fontSize: 25,
//           ),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: Consumer<FirebaseProvider>(
//         builder: (context, value, child) {
//           return ListView.separated(
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: value.users.length,
//             separatorBuilder: (context, index) => const SizedBox(
//               height: 10,
//             ),
//             itemBuilder: (context, index) =>
//                 value.users[index].uid != FirebaseAuth.instance.currentUser?.uid
//                     ? ChatRow(userChatModel: value.users[index])
//                     : const SizedBox(),
//           );
//         },
//       ),
//     );
//   }
// }
