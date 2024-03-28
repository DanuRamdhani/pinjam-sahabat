import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/models/response.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_rent_user.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/change_status_dialog.dart';
import 'package:pinjam_sahabat/utils/format.dart';
import 'package:provider/provider.dart';

class RentUserPage extends StatefulWidget {
  const RentUserPage({super.key, required this.post});

  final Post post;

  @override
  State<RentUserPage> createState() => _RentUserPageState();
}

class _RentUserPageState extends State<RentUserPage> {
  @override
  void initState() {
    final getPostProv = context.read<GetRentUserProvider>();

    Future.microtask(() => getPostProv.getRentUser(widget.post.postId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pemesan'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const FaIcon(FontAwesomeIcons.angleLeft),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<GetRentUserProvider>(
          builder: (context, rentProv, _) {
            final responseState = rentProv.responseState;

            if (responseState == ResponseState.fail) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ada kesalahan\nSilahkan coba lagi',
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () =>
                          rentProv.getRentUser(widget.post.postId!),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
            }

            if (responseState == ResponseState.succes) {
              if (rentProv.listRentUser.isEmpty) {
                return const Center(
                  child: Text('Belum ada pemesan'),
                );
              }

              return ListView.builder(
                itemCount: rentProv.listRentUser.length,
                itemBuilder: (context, index) {
                  final rentUser = rentProv.listRentUser[index];

                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rentUser.userName,
                              style: context.text.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text('no. Hp : '),
                                Text(
                                  rentUser.ordererPhoneNumber,
                                  style: context.text.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('jumlah barang : '),
                                Text(
                                  rentUser.amountOrder.toString(),
                                  style: context.text.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('total harga : '),
                                Text(
                                  priceFormated(rentUser.totalPrice, false),
                                  style: context.text.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Chip(
                                  label:
                                      Text(dateFormatted(rentUser.firstDate)),
                                  labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Chip(
                                  label: Text(dateFormatted(rentUser.lastDate)),
                                  labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    changeStatusDialog(
                                      context,
                                      rentUser.rentId!,
                                      rentUser.status,
                                      widget.post.postId!,
                                      rentUser.status == false
                                          ? widget.post.amount -
                                              rentUser.amountOrder
                                          : widget.post.amount +
                                              rentUser.amountOrder,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                  ),
                                  child: const Text('Ubah status'),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: rentUser.status
                                        ? Colors.green.shade400
                                        : Colors.redAccent,
                                  ),
                                  child: Text(
                                    rentUser.status
                                        ? 'sudah bayar'
                                        : 'belum bayar',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
