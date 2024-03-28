import 'package:provider/provider.dart';
import 'package:pinjam_sahabat/src/home/providers/rent_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/authentication/providers/auth.dart';
import 'package:pinjam_sahabat/src/main_wrapper/providers/main_wrapper_provider.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/delete_user_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/edit_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_rent_user.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_user_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';

final providers = [
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
];
