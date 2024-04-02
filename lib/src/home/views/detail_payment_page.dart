import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/providers/rent_provider.dart';
import 'package:pinjam_sahabat/utils/capitalize_first_letter.dart';
import 'package:pinjam_sahabat/utils/format.dart';
import 'package:provider/provider.dart';

class DetailPaymentPage extends StatelessWidget {
  const DetailPaymentPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Rincian Sewa Barang'),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const FaIcon(FontAwesomeIcons.angleLeft),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            capitalizeFirstLetter(post.title),
                            style: context.text.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${priceFormated(post.price, false)}/hari',
                          style: context.text.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.color.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Peraturan :',
                            style: context.text.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: post.rules.length,
                              itemBuilder: (context, index) {
                                final rule = post.rules[index];
                                return Text(
                                  '${index + 1}. $rule',
                                  style: context.text.bodyMedium,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child:
                        Consumer<RentProvider>(builder: (context, rentProv, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jarak Waktu',
                            style: context.text.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      rentProv.pickFirstDate(context),
                                  icon: const FaIcon(FontAwesomeIcons.calendar),
                                  label:
                                      Text(dateFormatted(rentProv.firstDate)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      rentProv.pickLastDate(context),
                                  icon: const FaIcon(FontAwesomeIcons.calendar),
                                  label: Text(dateFormatted(rentProv.lastDate)),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '* tanggal awal tidak boleh lebih dari tanggal akhir begitu juga sebaliknya',
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Consumer<RentProvider>(
                      builder: (context, rentProv, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rincian Pembayaran',
                              style: context.text.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Jumlah barang',
                                  style: context.text.bodyMedium,
                                ),
                                Text(
                                  rentProv.amount.toString(),
                                  style: context.text.bodyMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hari sewa',
                                  style: context.text.bodyMedium,
                                ),
                                Text(
                                  '${rentProv.lastDate.toDate().day - rentProv.firstDate.toDate().day} hari',
                                  style: context.text.bodyMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: context.text.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  priceFormated(
                                          rentProv.amount *
                                              post.price *
                                              (rentProv.lastDate.toDate().day -
                                                  rentProv.firstDate
                                                      .toDate()
                                                      .day),
                                          false)
                                      .toString(),
                                  style: context.text.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            height: 80,
            width: double.infinity,
            child: Row(
              children: [
                const Spacer(),
                Consumer<RentProvider>(
                  builder: (context, rentProv, _) {
                    return ElevatedButton(
                      onPressed: () => rentProv.rentStuff(context, post),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      child: const Text('Buat Pesanan'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Consumer<RentProvider>(
          builder: (context, rentProv, child) {
            if (rentProv.isRentUploading == true) {
              return Container(
                color: const Color.fromARGB(79, 0, 0, 0),
                height: context.height,
                width: context.width,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
