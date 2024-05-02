// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_home_travel/firebase/firebase_options.dart';
// import 'package:mobile_home_travel/firebase/notification_services.dart';
// import 'package:mobile_home_travel/screens/login/ui/login_screen.dart';
// import 'package:mobile_home_travel/screens/notifications/ui/notification_screen.dart';
// import 'package:mobile_home_travel/utils/shared_preferences_util.dart';

// final navigatorKey = GlobalKey<NavigatorState>();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SharedPreferencesUtil.init();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await NotificationService().initNotifications();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // String? token;

//   // Future<void> checkToken() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   token = prefs.getString(myToken);
//   //   print('Token dang nhap la: $token');
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   checkToken();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       locale: const Locale('vi', 'VN'),
//       title: 'Home Travel',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: GoogleFonts.lexend().fontFamily,
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color.fromARGB(255, 255, 255, 255)),
//         useMaterial3: true,
//       ),
//       // home: (token != null && token != "")
//       //     ? const NavigatorBar()
//       //     : const LoginScreen(),
//       home: const LoginScreen(),
//       navigatorKey: navigatorKey,
//       routes: {
//         '/notification': (context) => const NotificationScreen(),
//         '/login': (context) => const LoginScreen(),
//       },
//     );
//   }
// }

// @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<UserProvider>(
//           create: (_) => UserProvider(),
//         ),
//       ],
//       child: MaterialApp(
//         locale: const Locale('vi', 'VN'),
//         title: 'Home Travel',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           fontFamily: GoogleFonts.lexend().fontFamily,
//           colorScheme: ColorScheme.fromSeed(
//               seedColor: const Color.fromARGB(255, 255, 255, 255)),
//           useMaterial3: true,
//         ),
//         // home: (token != null && token != "")
//         //     ? const NavigatorBar()
//         //     : const LoginScreen(),
//         home: const LoginScreen(),
//         navigatorKey: navigatorKey,
//         routes: {
//           '/notification': (context) => const NotificationScreen(),
//           '/login': (context) => const LoginScreen(),
//         },
//       ),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/firebase/firebase_options.dart';
import 'package:mobile_home_travel/firebase/firebase_chat_provider.dart';
import 'package:mobile_home_travel/firebase/notification_services.dart';
import 'package:mobile_home_travel/screens/login/ui/login_screen.dart';
import 'package:mobile_home_travel/screens/notifications/ui/notification_screen.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtil.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String? token;

  // Future<void> checkToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString(myToken);
  //   print('Token dang nhap la: $token');
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   checkToken();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FirebaseChatProvider(),
      child: MaterialApp(
        locale: const Locale('vi', 'VN'),
        title: 'Home Travel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.lexend().fontFamily,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        // home: (token != null && token != "")
        //     ? const NavigatorBar()
        //     : const LoginScreen(),
        home: const LoginScreen(),
        navigatorKey: navigatorKey,
        routes: {
          '/notification': (context) => const NotificationScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
