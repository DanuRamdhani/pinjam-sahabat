import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:pinjam_sahabat/utils/categories.dart';
import 'package:provider/provider.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostProvider>(
      builder: (context, addPostProv, _) {
        final categoriesWithoutFirst = categories.skip(1).toList();

        return MultiSelectDialogField(
          buttonIcon: const Icon(
            FontAwesomeIcons.angleDown,
            size: 18,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: context.color.surfaceTint),
            borderRadius: BorderRadius.circular(4),
          ),
          items:
              categoriesWithoutFirst.map((e) => MultiSelectItem(e, e)).toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            addPostProv.selectedCategory = values;
          },
          title: const Text('Pilih Kategori Barang'),
          buttonText: Text('Kategori', style: context.text.bodyLarge),
          chipDisplay: MultiSelectChipDisplay(
            chipColor: context.color.primaryContainer,
            textStyle: TextStyle(
              color: context.color.onPrimaryContainer,
            ),
            items: addPostProv.selectedCategory
                .map((e) => MultiSelectItem(e, e))
                .toList(),
            onTap: (value) => addPostProv.deleteSelectedCategory(value),
          ),
        );
      },
    );
  }
}
