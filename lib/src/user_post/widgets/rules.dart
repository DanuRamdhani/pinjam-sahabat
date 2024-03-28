import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:provider/provider.dart';

class Rules extends StatefulWidget {
  const Rules({super.key, required this.rules});

  final List<String> rules;

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostProvider>(builder: (context, addPostProv, _) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.rules.length,
              itemBuilder: (context, index) {
                if (widget.rules.isEmpty) {
                  return const Center(child: Text('Belum ada aturan'));
                }

                return Card(
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0)
                            .copyWith(right: 0),
                    dense: true,
                    title: Text(
                      '${index + 1}. ${widget.rules[index]}',
                      style: context.text.bodyLarge,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.rules.removeAt(index);
                        });
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.xmark,
                        size: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: addPostProv.rulesCtrl,
                  decoration: const InputDecoration(
                    labelText: 'tambah rule',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (addPostProv.rulesCtrl.text.trim().isEmpty) {
                    return;
                  }
                  setState(() {
                    widget.rules.add(addPostProv.rulesCtrl.text);
                    addPostProv.rulesCtrl.clear();
                  });
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      );
    });
  }
}
