import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/attendance/attendance_record_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/notification/notification_screen.dart';
import '../screens/about_us/about_us_screen.dart';
import '../screens/routine/routine_screen.dart';
import '../screens/team/my_team_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String attendance = '/attendance';
  static const String target = '/target';
  static const String visualAds = '/visual-ads';
  static const String team = '/team';
  static const String routine = '/routine';
  static const String doctors = '/doctors';
  static const String dcr = '/dcr';
  static const String trips = '/trips';
  static const String chemist = '/chemist';
  static const String stockist = '/stockist';
  static const String orders = '/orders';
  static const String gifts = '/gifts';
  static const String expenses = '/expenses';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String settings = '/settings';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: attendance,
        builder: (context, state) => const AttendanceRecordScreen(),
      ),
      GoRoute(
        path: target,
        builder: (context, state) => _placeholder('Monthly Target'),
      ),
      GoRoute(
        path: visualAds,
        builder: (context, state) => _placeholder('Visual Ads'),
      ),
      GoRoute(
        path: team,
        builder: (context, state) => const MyTeamScreen(),
      ),
      GoRoute(
        path: routine,
        builder: (context, state) => const RoutineScreen(),
      ),
      GoRoute(
        path: doctors,
        builder: (context, state) => _placeholder('My Doctors'),
      ),
      GoRoute(
        path: dcr,
        builder: (context, state) => _placeholder('DCR'),
      ),
      GoRoute(
        path: trips,
        builder: (context, state) => _placeholder('My Trips'),
      ),
      GoRoute(
        path: chemist,
        builder: (context, state) => _placeholder('My Chemist Shops'),
      ),
      GoRoute(
        path: stockist,
        builder: (context, state) => _placeholder('My Stockists'),
      ),
      GoRoute(
        path: orders,
        builder: (context, state) => _placeholder('My Orders'),
      ),
      GoRoute(
        path: gifts,
        builder: (context, state) => _placeholder('Request Gifts'),
      ),
      GoRoute(
        path: expenses,
        builder: (context, state) => _placeholder('Expense Tracker'),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: notifications,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: about,
        builder: (context, state) => const AboutUsScreen(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => _placeholder('Settings'),
      ),
    ],
  );

  static Widget _placeholder(String title) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text(title)),
  );
}
