import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:snest/components/reaction/data/example_data.dart' as Example;
import 'package:snest/components/reaction/item.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Flutter Reaction Button'),
        actions: [
          Builder(
            builder: (ctx) {
              return ReactionButton<String>(
                onReactionChanged: (String? value) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(
                      content: Text('Selected value: $value'),
                    ),
                  );
                },
                reactions: Example.flagsReactions,
                initialReaction: Reaction<String>(
                  value: null,
                  icon: const Icon(
                    Icons.language,
                  ),
                ),
                boxColor: Colors.black.withOpacity(0.5),
                boxRadius: 10,
                boxDuration: const Duration(milliseconds: 500),
                itemScaleDuration: const Duration(milliseconds: 200),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Builder(
        builder: (_) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 5),
            children: [
              Item(
                'image 1',
                'images/reactions/img1.jpg',
                Example.reactions,
              ),
              Item(
                'image 2',
                'images/reactions/img2.jpg',
                Example.reactions,
              ),
              Item(
                'image 3',
                'images/reactions/img3.jpg',
                Example.reactions,
              ),
              Item(
                'image 4',
                'images/reactions/img4.jpg',
                Example.reactions,
              ),
              Item(
                'image 5',
                'images/reactions/img5.jpg',
                Example.reactions,
              ),
            ],
          );
        },
      ),
    );
  }
}
