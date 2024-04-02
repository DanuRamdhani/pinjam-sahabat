import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/providers/rating_provider.dart';
import 'package:provider/provider.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key, required this.post});

  final Post post;

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Produk'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const FaIcon(FontAwesomeIcons.angleLeft),
        ),
      ),
      body: Consumer<RatingProvider>(
        builder: (context, ratingProv, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => IconButton(
                    icon: Icon(
                      Icons.star,
                      color: index < ratingProv.rating
                          ? Colors.yellow
                          : Colors.grey,
                    ),
                    onPressed: () => ratingProv.setRating(index + 1),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ratingProv.isLoading
                    ? null
                    : () {
                        final ratingProv = context.read<RatingProvider>();
                        ratingProv.giveRating(
                            context, widget.post.postId!, ratingProv.rating);
                      },
                child: ratingProv.isLoading
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
    );
  }
}
