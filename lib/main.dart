import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/providers/rent_provider.dart';
import 'package:pinjam_sahabat/src/home/views/detail_payment_page.dart';
import 'package:pinjam_sahabat/src/home/views/payment_succes_page.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/authentication/providers/auth.dart';
import 'package:pinjam_sahabat/src/authentication/views/auth_page.dart';
import 'package:pinjam_sahabat/src/main_wrapper/providers/main_wrapper_provider.dart';
import 'package:pinjam_sahabat/src/main_wrapper/views/main_wrapper.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/delete_user_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/edit_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_rent_user.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_user_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/home/views/detail_post_page.dart';
import 'package:pinjam_sahabat/src/user_post/views/add_post_page.dart';
import 'package:pinjam_sahabat/src/user_post/views/detail_user_post.dart';
import 'package:pinjam_sahabat/src/user_post/views/edit_post_page.dart';
import 'package:pinjam_sahabat/src/user_post/views/google_map_page.dart';
import 'package:pinjam_sahabat/src/splash/views/splash_screen.dart';
import 'package:pinjam_sahabat/src/user_post/views/rent_user.dart';
import 'package:pinjam_sahabat/utils/theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => MainWrapperProvider()),
        ChangeNotifierProvider(create: (_) => AddPostProvider()),
        ChangeNotifierProvider(create: (_) => EditPostProvider()),
        ChangeNotifierProvider(create: (_) => DeleteUserPostProvider()),
        ChangeNotifierProvider(create: (_) => GetUserPostProvider()),
        ChangeNotifierProvider(create: (_) => GetPostProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => RentProvider()),
        ChangeNotifierProvider(create: (_) => GetRentUserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      initialRoute: auth.currentUser == null ? AppRoute.auth : AppRoute.splash,
      routes: {
        AppRoute.auth: (_) => const AuthPage(),
        AppRoute.splash: (_) => const SplashScreen(),
        AppRoute.mainWrapper: (_) => const MainWrapper(),
        AppRoute.detailPost: (_) => DetailPostPage(
              post: ModalRoute.of(_)?.settings.arguments as Post,
            ),
        AppRoute.detailUserPost: (_) => DetailUserPostPage(
              post: ModalRoute.of(_)?.settings.arguments as Post,
            ),
        AppRoute.detailPayment: (_) => DetailPaymentPage(
              post: ModalRoute.of(_)?.settings.arguments as Post,
            ),
        AppRoute.paymentSucces: (_) => const PaymentSuccesPage(),
        AppRoute.addPost: (_) => const AddPostPage(),
        AppRoute.editPost: (_) => EditPostPage(
              post: ModalRoute.of(_)?.settings.arguments as Post,
            ),
        AppRoute.googleMap: (_) => GoogleMapPage(
              post: ModalRoute.of(_)?.settings.arguments as Post?,
            ),
        AppRoute.rentUser: (_) => RentUserPage(
              post: ModalRoute.of(_)?.settings.arguments as Post,
            ),
      },
    );
  }
}
