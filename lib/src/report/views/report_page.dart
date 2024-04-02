import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/report/list_report.dart';
import 'package:pinjam_sahabat/src/report/providers/report_provider.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const FaIcon(FontAwesomeIcons.angleLeft),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ReportProvider>(
          builder: (context, reportProv, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih jenis laporan:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: reportDescriptions.length,
                    itemBuilder: (context, index) {
                      final option = reportDescriptions[index];
                      return RadioListTile(
                        title: Text(option),
                        value: option,
                        groupValue: reportProv.selectedOption,
                        onChanged: (value) => reportProv.onChangedRadio(value),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                if (reportProv.selectedOption == reportDescriptions.last)
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi Lainnya',
                    ),
                    onChanged: (value) => reportProv.onChanged(value),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: reportProv.isLoading
                      ? null
                      : () => reportProv.report(context, post.postId!),
                  child: reportProv.isLoading
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text('Submit'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
