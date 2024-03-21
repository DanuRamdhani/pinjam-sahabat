import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/post/models/response.dart';
import 'package:pinjam_sahabat/src/post/providers/get_post.dart';
import 'package:pinjam_sahabat/src/post/widgets/post_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final getPostProv = context.read<GetPostProvider>();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await getPostProv.getAllPost(context);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinjam Sahabat'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
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
                            onPressed: () => getPostProv.getAllPost(context),
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    );
                  }

                  if (responseState == ResponseStatePost.succes) {
                    return PostItem(
                      scrollController: _scrollController,
                      getPostProv: getPostProv,
                    );
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
