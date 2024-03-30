import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/routes.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/auth/provider/login_provider.dart';
import 'package:pinjam_sahabat/src/auth/provider/regis_provider.dart';
import 'package:pinjam_sahabat/src/home/providers/rent_provider.dart';
import 'package:pinjam_sahabat/src/profile/providers/profile_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/main_wrapper/providers/main_wrapper_provider.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/delete_user_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/edit_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_rent_user.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_user_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';
import 'package:pinjam_sahabat/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String initialRoute = isLoggedIn ? AppRoute.splash : AppRoute.login;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
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
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinjam.co',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
