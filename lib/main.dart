import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'services/auth.dart';
import 'providers/OffersProvider.dart';
import 'providers/coupons_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_coupon_screen.dart';
import 'screens/edit_offer_screen.dart';
import 'screens/manage_offers_screen.dart';
import 'screens/home_screen.dart';
import 'screens/coupon_detail_screen.dart';
import 'screens/manage_coupons_screen.dart';
import 'screens/stores_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        // ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => CouponsProvider()),
        ChangeNotifierProvider(create: (context) => OffersProvider()),
      ],
      child: MaterialApp(
        title: 'Wafar Cash',
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.lightBlue,
          fontFamily: 'Lato',
        ),
        home: AuthenticationWrapper(),
        routes: {
          // AuthScreen.routeName: (ctx) => AuthScreen(),
          CouponDetailScreen.routeName: (ctx) => CouponDetailScreen(),
          ManageCouponsScreen.routeName: (ctx) => ManageCouponsScreen(),
          EditCouponScreen.routeName: (ctx) => EditCouponScreen(),
          ManageOffersScreen.routeName: (ctx) => ManageOffersScreen(),
          EditOfferScreen.routeName: (ctx) => EditOfferScreen(),
          StoresScreen.routeName: (ctx) => StoresScreen(),
        },
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
        print('IDDDDDDDDDDDDDDDDDDDDDD' + currentUser.uid);
      }

      return HomeScreen();
    }
    return AuthScreen();
  }
}
