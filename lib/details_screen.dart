import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: AnimationLimiter(
        child: GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: List.generate(40, (index) {
            return AnimationConfiguration.staggeredGrid(
                duration: Duration(milliseconds: 3000),
                position: index,
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.deepPurple,
                      child: const Center(
                        child: Text(
                          'Animation',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ));
          }),
        ),
      ),
    );
  }
}
