import 'package:flutter/material.dart';
import 'categoryData.dart';
import 'categoryItem.dart';
import 'dart:math' as math;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    final curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceOut);

    animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
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
              print('The button is clicked');
            },
            // icon: AnimatedSwitcher(
            //   duration: Duration(milliseconds: 300),
            //   transitionBuilder: (child, animation) {
            //     return RotationTransition(
            //       turns: Tween(begin: 0.5, end: 1.0).animate(animation),
            //       child: child,
            //     );
            //   },
            //   child: Icon(
            //     Icons.abc_rounded,
            //     key: ValueKey(isClicked),
            //   ),
            // )
            // )
            icon: Transform.rotate(
              angle: animation.value,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      // custom animation using silvers 
            // body : CustomScrollView(slivers: [
           //   SliverAppBar(),
          //   SliverList(delegate: AnimatedBuilder),
         // ],)
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
      ),
    );
  }
}
