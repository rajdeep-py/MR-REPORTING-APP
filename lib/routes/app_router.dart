import 'package:go_router/go_router.dart';

import '../models/chemist_shop.dart';
import '../models/chemist_shop_reporting.dart';
import '../models/dcr.dart';
import '../models/doctor.dart';
import '../models/stockist.dart';
import '../screens/about_us/about_us_screen.dart';
import '../screens/attendance/attendance_record_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/chemist_shop/add_edit_chemist_shop_screen.dart';
import '../screens/chemist_shop/chemist_shop_detail_screen.dart';
import '../screens/chemist_shop/my_chemist_shop_screen.dart';
import '../screens/chemist_shop_reporting/chemist_shop_reporting_screen.dart';
import '../screens/chemist_shop_reporting/create_edit_chemist_shop_reporting_screen.dart';
import '../screens/dcr/create_edit_dcr_screen.dart';
import '../screens/dcr/dcr_screen.dart';
import '../screens/doctor/add_edit_doctor_screen.dart';
import '../screens/doctor/doctor_detail_screen.dart';
import '../screens/doctor/my_doctor_screen.dart';
import '../screens/expense/create_expense_screen.dart';
import '../screens/expense/my_expense_screen.dart';
import '../screens/gift/gift_screen.dart';
import '../screens/gift/request_gift_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/monthly_target/monthly_target_screen.dart';
import '../screens/notification/notification_screen.dart';
import '../screens/order/create_order_screen.dart';
import '../screens/order/my_order_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/routine/routine_screen.dart';
import '../screens/settings/privacy_policy_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/terms_conditions_screen.dart';
import '../screens/stockist/add_edit_stockist_screen.dart';
import '../screens/stockist/my_stockist_screen.dart';
import '../screens/stockist/stockist_detail_screen.dart';
import '../screens/team/my_team_screen.dart';
import '../screens/team/team_details_screen.dart';
import '../screens/visual_ads/visual_ads_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String attendance = '/attendance';
  static const String target = '/target';
  static const String visualAds = '/visual-ads';
  static const String team = '/team';
  static const String teamDetails = '/team-details/:teamId';
  static const String routine = '/routine';
  static const String doctors = '/doctors';
  static const String doctorDetail = '/doctor-detail/:doctorId';
  static const String addEditDoctor = '/add-edit-doctor';
  static const String dcr = '/dcr';
  static const String createEditDcr = '/create-edit-dcr';
  static const String trips = '/trips';
  static const String chemist = '/chemist';
  static const String chemistDetail = '/chemist-detail/:shopId';
  static const String addEditChemist = '/add-edit-chemist';
  static const String stockist = '/stockist';
  static const String stockistDetail = '/stockist-detail/:stockistId';
  static const String addEditStockist = '/add-edit-stockist';
  static const String chemistReporting = '/chemist-reporting';
  static const String createEditChemistReporting =
      '/create-edit-chemist-reporting';
  static const String orders = '/orders';
  static const String createOrder = '/create-order';
  static const String gifts = '/gifts';
  static const String requestGift = '/request-gift';
  static const String expenses = '/expenses';
  static const String createExpense = '/create-expense';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String settings = '/settings';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsConditions = '/terms-conditions';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: attendance,
        builder: (context, state) => const AttendanceRecordScreen(),
      ),
      GoRoute(
        path: target,
        builder: (context, state) => const MonthlyTargetScreen(),
      ),
      GoRoute(
        path: visualAds,
        builder: (context, state) => const VisualAdsScreen(),
      ),
      GoRoute(path: team, builder: (context, state) => const MyTeamScreen()),
      GoRoute(
        path: teamDetails,
        builder: (context, state) {
          final teamId = state.pathParameters['teamId']!;
          return TeamDetailsScreen(teamId: teamId);
        },
      ),
      GoRoute(
        path: routine,
        builder: (context, state) => const RoutineScreen(),
      ),
      GoRoute(
        path: doctors,
        builder: (context, state) => const MyDoctorScreen(),
      ),
      GoRoute(
        path: doctorDetail,
        builder: (context, state) {
          final doctorId = state.pathParameters['doctorId']!;
          return DoctorDetailScreen(doctorId: doctorId);
        },
      ),
      GoRoute(
        path: addEditDoctor,
        builder: (context, state) {
          final doctor = state.extra as DoctorModel?;
          return AddEditDoctorScreen(doctorToEdit: doctor);
        },
      ),
      GoRoute(path: dcr, builder: (context, state) => const DCRScreen()),
      GoRoute(
        path: createEditDcr,
        builder: (context, state) {
          final dcr = state.extra as DCRModel?;
          return CreateEditDCRScreen(dcrToEdit: dcr);
        },
      ),
      GoRoute(
        path: chemist,
        builder: (context, state) => const MyChemistShopScreen(),
      ),
      GoRoute(
        path: chemistDetail,
        builder: (context, state) {
          final shopId = state.pathParameters['shopId']!;
          return ChemistShopDetailScreen(shopId: shopId);
        },
      ),
      GoRoute(
        path: addEditChemist,
        builder: (context, state) {
          final shop = state.extra as ChemistShopModel?;
          return AddEditChemistShopScreen(shopToEdit: shop);
        },
      ),
      GoRoute(
        path: stockist,
        builder: (context, state) => const MyStockistScreen(),
      ),
      GoRoute(
        path: stockistDetail,
        builder: (context, state) {
          final stockistId = state.pathParameters['stockistId']!;
          return StockistDetailScreen(stockistId: stockistId);
        },
      ),
      GoRoute(
        path: addEditStockist,
        builder: (context, state) {
          final stockist = state.extra as StockistModel?;
          return AddEditStockistScreen(stockistToEdit: stockist);
        },
      ),
      GoRoute(
        path: chemistReporting,
        builder: (context, state) => const ChemistShopReportingScreen(),
      ),
      GoRoute(
        path: createEditChemistReporting,
        builder: (context, state) {
          final report = state.extra as ChemistShopReportingModel?;
          return CreateEditChemistShopReportingScreen(reportToEdit: report);
        },
      ),
      GoRoute(path: orders, builder: (context, state) => const MyOrderScreen()),
      GoRoute(
        path: createOrder,
        builder: (context, state) => const CreateOrderScreen(),
      ),
      GoRoute(path: gifts, builder: (context, state) => const GiftScreen()),
      GoRoute(
        path: requestGift,
        builder: (context, state) => const RequestGiftScreen(),
      ),
      GoRoute(
        path: expenses,
        builder: (context, state) => const MyExpenseScreen(),
      ),
      GoRoute(
        path: createExpense,
        builder: (context, state) => const CreateExpenseScreen(),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: notifications,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(path: about, builder: (context, state) => const AboutUsScreen()),
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: privacyPolicy,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: termsConditions,
        builder: (context, state) => const TermsConditionsScreen(),
      ),
    ],
  );
}
