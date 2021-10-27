import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wafar_cash/l10n/l10n.dart';
import 'package:wafar_cash/screens/contact_us.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'services/auth.dart';
import 'providers/offers_provider.dart';
import 'providers/coupons_provider.dart';
import 'providers/requests_provider.dart';
import 'providers/locale_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_coupon_screen.dart';
import 'screens/edit_offer_screen.dart';
import 'screens/manage_offers_screen.dart';
import 'screens/home_screen.dart';
import 'screens/coupon_detail_screen.dart';
import 'screens/manage_coupons_screen.dart';
import 'screens/stores_screen.dart';
import 'screens/store_coupons_screen.dart';
import 'screens/categorized_stores_screen.dart';
import 'screens/request_coupon_screen.dart';
import 'screens/manage_requests_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  print("Handling a background message: ${event.messageId}");

  if (event.data['coupId'] != null) {
    Navigator.of(navigatorKey.currentContext).pushNamed(
        CouponDetailScreen.routeName,
        arguments: event.data['coupId']);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Firebase
  await Firebase.initializeApp();
  //Initialize Google Mobile Ads
  MobileAds.instance.initialize();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider of all the coupons
    return MultiProvider(
      providers: [
        Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => CouponsProvider()),
        ChangeNotifierProvider(create: (context) => OffersProvider()),
        ChangeNotifierProvider(create: (context) => RequestsProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, provider, child) => MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Wafar Cash!',
          debugShowCheckedModeBanner: false,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.lightBlue,
            fontFamily: 'Lato',
          ),
          locale: Provider.of<LocaleProvider>(context).locale,
          home: AuthenticationWrapper(),
          routes: {
            // AuthScreen.routeName: (ctx) => AuthScreen(),
            CouponDetailScreen.routeName: (ctx) => CouponDetailScreen(),
            EditCouponScreen.routeName: (ctx) => EditCouponScreen(),
            EditOfferScreen.routeName: (ctx) => EditOfferScreen(),
            RequestCouponScreen.routeName: (ctx) => RequestCouponScreen(),
            ManageCouponsScreen.routeName: (ctx) => ManageCouponsScreen(),
            ManageOffersScreen.routeName: (ctx) => ManageOffersScreen(),
            ManageRequestsScreen.routeName: (ctx) => ManageRequestsScreen(),
            StoresScreen.routeName: (ctx) => StoresScreen(),
            StoreCouponsScreen.routeName: (ctx) => StoreCouponsScreen(),
            ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
            CategorizedStoresScreen.routeName: (ctx) =>
                CategorizedStoresScreen(),
          },
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Listen to the user
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        print('IDDDDDDDDDDDDDDDDDDDDDD:   ' + currentUser.uid);
      }

      return HomeScreen();
    }
    return AuthScreen();
  }
}
