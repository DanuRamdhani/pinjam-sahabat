import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/auth/view/login_page.dart';
import 'package:pinjam_sahabat/src/auth/view/lupa_password_page.dart';
import 'package:pinjam_sahabat/src/auth/view/register_page.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/views/detail_payment_page.dart';
import 'package:pinjam_sahabat/src/home/views/detail_post_page.dart';
import 'package:pinjam_sahabat/src/home/views/payment_succes_page.dart';
import 'package:pinjam_sahabat/src/main_wrapper/views/main_wrapper.dart';
import 'package:pinjam_sahabat/src/splash/views/splash_screen.dart';
import 'package:pinjam_sahabat/src/user_post/views/add_post_page.dart';
import 'package:pinjam_sahabat/src/user_post/views/detail_user_post.dart';
import 'package:pinjam_sahabat/src/user_post/views/edit_post_page.dart';
import 'package:pinjam_sahabat/src/user_post/views/google_map_page.dart';
import 'package:pinjam_sahabat/src/user_post/views/rent_user.dart';

final routes = {
  AppRoute.login: (_) => const LoginPage(),
  AppRoute.registration: (_) => const RegisterPage(),
  AppRoute.forgotPassword: (_) => const LupaPasswordPage(),
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
};
