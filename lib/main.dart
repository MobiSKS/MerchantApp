import 'package:dtplusmerchant/Screens/auth/forgot_password_screen.dart';
import 'package:dtplusmerchant/Screens/financials/batch_details.dart';
import 'package:dtplusmerchant/Screens/dashboard.dart';
import 'package:dtplusmerchant/Screens/erp_detail.dart';
import 'package:dtplusmerchant/Screens/transactions/payment_acceptance.dart';
import 'package:dtplusmerchant/Screens/profile/profile.dart';
import 'package:dtplusmerchant/Screens/receivable_payable.dart';
import 'package:dtplusmerchant/Screens/transactions/scan_qr.dart';
import 'package:dtplusmerchant/Screens/financials/transaction_details.dart';
import 'package:dtplusmerchant/Screens/transactions/type_of_sale_screen.dart';
import 'package:dtplusmerchant/provider/financials_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Screens/auth/auth_view_model.dart';
import 'Screens/auth/login_page.dart';
import 'const/injection.dart';
import 'preferences/shared_preference.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'provider/transactions_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.initInjection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  SharedPref sharedPref = Injection.injector.get<SharedPref>();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    bool isLoggedin = await sharedPref.readBool(SharedPref.isLogin);       
    setState(() {
      isLogin = isLoggedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => TransactionsProvider()),
        ChangeNotifierProvider(create: (context) => FinancialsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(600, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ],
        ),
        home: isLogin ? const Dashboard() : const LoginPage(),
        routes: {
          "/login": (context) => const LoginPage(),
          "/dashboard": (context) => const Dashboard(),
          "/typeofSale": (context) => const TypeOfSale(),
          "/editProfile": (context) => const EditProfile(),
          "/forgotPassword": (context) =>const ForgotPassword(),
          "/paymentAcceptance": (context) => const PaymentAcceptance(),
          "/scanQRcode": (context) => const ScanQRCode(),
          "/transactionDetails": (context) => const TransactionDetails(),
          "/receivablePayable": (context) => const ReceivablePayable(),
          "/erpDetail": (context) => const ERPDetail(),
          "/batchDetails": (context) => const BatchDetails(),
        },
      ),
    );
  }
}
