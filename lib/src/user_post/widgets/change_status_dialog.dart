import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_rent_user.dart';
import 'package:provider/provider.dart';

void changeStatusDialog(BuildContext context, String rentId, bool status,
    String postId, int amountAfter) {
  final rentProv = context.read<GetRentUserProvider>();

  showDialog(
    context: context,
    builder: (context) {
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
          onPressed: () => rentProv.updateStatus(
            context,
            rentId,
            status,
            postId,
            amountAfter,
          ),
          child: const Text('Ubah'),
        ),
      );
    },
  );
}
