import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/post/models/response.dart';
import 'package:pinjam_sahabat/src/post/providers/get_post.dart';
import 'package:pinjam_sahabat/src/post/widgets/post_category_item.dart';
import 'package:pinjam_sahabat/utils/categories.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    final getPostProv = context.read<GetPostProvider>();
    getPostProv.getPostByCategory(
      context,
      getPostProv.selectedCategory,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Consumer<GetPostProvider>(
                        builder: (context, getPostProv, _) {
                      return ChoiceChip.elevated(
                        selected: getPostProv.selectedCategory == category,
                        label: Text(category),
                        onSelected: (value) async {
                          await getPostProv.getPostByCategory(
                            context,
                            category,
                          );
                        },
                      );
                    }),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<GetPostProvider>(
                builder: (context, getPostProv, _) {
                  final responseState = getPostProv.responseState;

                  if (responseState == ResponseStatePost.fail) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Something went wrong'),
                          IconButton(
                            onPressed: () => getPostProv.getPostByCategory(
                              context,
                              getPostProv.selectedCategory,
                            ),
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    );
                  }

                  if (responseState == ResponseStatePost.succes) {
                    return PostCategoryItem(getPostProv: getPostProv);
                  }

                  return Container(
                    margin: const EdgeInsets.only(top: 16),
                    alignment: Alignment.topCenter,
                    child: const CircularProgressIndicator(strokeWidth: 1),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
