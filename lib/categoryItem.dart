import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryData});

  final CategoryModel categoryData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      splashColor: Colors.blueGrey,
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [
            categoryData.color.withOpacity(1),
            categoryData.color.withOpacity(0.6)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          categoryData.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 18),
        ),
      ),
    );
  }
}
