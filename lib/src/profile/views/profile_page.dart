import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/res/color.dart';
import 'package:pinjam_sahabat/src/profile/providers/profile_provider.dart';
import 'package:pinjam_sahabat/src/auth/widget/custom_text.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileProvider>().fetchUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.backgroud,
      appBar: AppBar(
        backgroundColor: MyColor.backgroud,
        title: Text(
          'Profile',
          style: TextStyle(color: MyColor.hitam, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final Map<String, dynamic>? data = provider.userData;

          if (data == null) {
            return const Center(
              child: Text('No data found!'),
            );
          }

          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 108,
                    color: MyColor.abu,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () => provider.changeProfilePicture(context),
                      child: Container(
                        margin: const EdgeInsets.only(top: 112 / 2),
                        width: 112,
                        height: 112,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: data['profilePicture'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: CachedNetworkImage(
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                  imageUrl: data['profilePicture'],
                                  placeholder: (context, url) => FaIcon(
                                    FontAwesomeIcons.solidCircleUser,
                                    size: 40,
                                    color: Colors.grey.shade400,
                                  ),
                                  errorWidget: (context, url, error) => FaIcon(
                                    FontAwesomeIcons.solidCircleUser,
                                    size: 40,
                                    color: Colors.grey.shade400,
                                  ),
                                  cacheManager: CacheManager(
                                    Config(
                                      'cache-profile',
                                      stalePeriod: const Duration(minutes: 30),
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircleUser,
                                  size: 112,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(data: 'Username'),
                        CustomText(data: data['username']),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(data: 'No Telp'),
                        CustomText(data: data['phoneNumber']),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(data: 'Email'),
                        CustomText(data: data['email']),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const CustomText(data: 'Lokasi'),
                    const SizedBox(height: 12),
                    const CustomText(data: 'History'),
                    const SizedBox(height: 12),
                    GestureDetector(
                        onTap: () async {
                          await auth.sendPasswordResetEmail(
                              email: data['email']);
                          if (!context.mounted) return;
                          customSnackBarwithClose(
                            context,
                            'Email untuk reset password telah dikirim.',
                          );
                        },
                        child: const CustomText(data: 'Ubah Password')),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => provider.logout(context),
                      child: Text(
                        'LogOut',
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColor.merah,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
