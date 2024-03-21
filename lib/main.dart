import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/post/models/post.dart';
import 'package:pinjam_sahabat/src/post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/authentication/providers/auth.dart';
import 'package:pinjam_sahabat/src/authentication/views/auth_page.dart';
import 'package:pinjam_sahabat/src/main_wrapper/providers/main_wrapper_provider.dart';
import 'package:pinjam_sahabat/src/main_wrapper/views/main_wrapper.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/src/post/providers/get_post.dart';
import 'package:pinjam_sahabat/src/post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/post/views/add_post_detail_page.dart';
import 'package:pinjam_sahabat/src/post/views/detail_post_page.dart';
import 'package:pinjam_sahabat/src/post/views/google_map_page.dart';
import 'package:pinjam_sahabat/src/post/views/splash_screen.dart';
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
        ChangeNotifierProvider(create: (_) => GetPostProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 26, 162, 230),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 26, 162, 230),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      initialRoute: auth.currentUser == null ? AppRoute.auth : AppRoute.splash,
      routes: {
        AppRoute.auth: (_) => const AuthPage(),
        AppRoute.splash: (_) => const SplashScreen(),
        AppRoute.mainWrapper: (_) => const MainWrapper(),
        AppRoute.detailPost: (_) => DetailPostPage(
              post: ModalRoute.of(_)?.settings.arguments as Post,
            ),
        AppRoute.addPostDetail: (_) => const AddPostDetailPage(),
        AppRoute.googleMap: (_) => const GoogleMapPage(),
      },
    );
  }
}
