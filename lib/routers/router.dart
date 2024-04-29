import 'package:go_router/go_router.dart';
import 'package:mobile_home_travel/screens/login/ui/login_screen.dart';
import 'package:mobile_home_travel/screens/notifications/ui/notification_screen.dart';
import 'package:mobile_home_travel/utils/navigator/navigator2.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';
import 'package:mobile_home_travel/screens/profile/ui/profile_screen.dart';
import 'package:mobile_home_travel/screens/settings/settings_screen.dart';
import 'package:mobile_home_travel/screens/signup/sign_up_screen.dart';
import 'package:mobile_home_travel/screens/home/home_screen.dart';
import 'package:mobile_home_travel/screens/wallet/ui/wallet_screen.dart';

class RouteName {
  // static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String navigator = '/navigator';
  static const String setting = '/setting';
  static const String profile = '/profile';
  static const String wallet = '/wallet';
  static const String notification = '/notification';

  static const publicRoutes = [
    login,
    signup,
    home,
    navigator,
    profile,
    setting,
    wallet,
    notification,
  ];
}

//nếu không có path cụ thể thì trả về trang login
final router = GoRouter(
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }
    return RouteName.login;
  },
  routes: [
    // GoRoute(
    //   path: RouteName.home,
    //   builder: (context, state) => const HomePage(),
    // ),
    GoRoute(
      path: RouteName.wallet,
      builder: (context, state) => const WalletScreen(),
    ),
    GoRoute(
      path: RouteName.notification,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: RouteName.navigator,
      builder: (context, state) => const NavigatorBar(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteName.signup,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: RouteName.setting,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: RouteName.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
