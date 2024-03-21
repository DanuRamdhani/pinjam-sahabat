import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: db
          .collection('post')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .orderBy('createdAt', descending: true)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                const Text('Something went wrong'),
                IconButton(
                  onPressed: () async {
                    await db
                        .collection('post')
                        .where('userId', isEqualTo: auth.currentUser!.uid)
                        .orderBy('createdAt')
                        .get();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasData && snapshot.data == null) {
          return const Center(
            child: Text('No data'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final post = snapshot.data!.docs[index];

                if (!post.exists) {
                  return const Center(
                    child: Text('No data'),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(post['title']),
                        IconButton(
                          onPressed: () => post.reference.delete(),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    Image.network(post['image']),
                    Text(post['desc']),
                    Text(post['price'].toString()),
                  ],
                );
              },
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
