import 'package:flutter/material.dart';
import 'categoryData.dart';
import 'categoryItem.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isClicked = true;
                  });
                },
                icon: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.abc_rounded,
                    key: ValueKey(isClicked),
                  ),
                ))
          ],
        ),
        body: AnimatedBuilder(
          animation: _animationController,
          child: GridView(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              // categoryData.map((item) => CategoryItem(categoryItem: item)).toList(),
              for (final item in categoryData)
                CategoryItem(
                  categoryData: item,
                ),
            ],
          ),
          // builder: (context, child) => Padding(
          //     padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
          //     child: child)),
          builder: (context, child) => SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
        ));
  }
}
