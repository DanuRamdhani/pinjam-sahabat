import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/utils/categories.dart';
import 'package:provider/provider.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          if (index + 1 == categories.length) {
            return const SizedBox(width: 8);
          }

          return Consumer<GetPostProvider>(
            builder: (context, getPostProv, _) {
              return ChoiceChip.elevated(
                avatar: getPostProv.selectedCategory == category
                    ? null
                    : categoriesIcon[index],
                selected: getPostProv.selectedCategory == category,
                label: Text(category),
                onSelected: (value) async {
                  if (category == categories.first) {
                    await getPostProv.getAllPost(context);
                  } else {
                    await getPostProv.getPostByCategory(
                      context,
                      category,
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
