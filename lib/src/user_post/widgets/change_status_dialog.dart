import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_rent_user.dart';
import 'package:provider/provider.dart';

void changeStatusDialog(
  BuildContext context,
  String rentId,
  bool status,
  String postId,
  int amountAfter,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer<GetRentUserProvider>(
        builder: (context, rentProv, _) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(right: 8, left: 24, top: 8),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ubah status'),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            content: ElevatedButton(
              onPressed: rentProv.isLoading == true
                  ? null
                  : () => rentProv.updateStatus(
                        context,
                        rentId,
                        status,
                        postId,
                        amountAfter,
                      ),
              child: rentProv.isLoading == true
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text('Ubah'),
            ),
          );
        },
      );
    },
  );
}
