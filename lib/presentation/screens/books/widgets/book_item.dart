import 'package:flutter/material.dart';

import '../../../../domain/models/book.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class BookItem extends StatelessWidget {

  final Book book;
  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(
          color: ColorManager.lightGrey,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -32,
            right: -2,
            child: Image.asset(
              ImageAssets.books,
              height: 140,
              width: 110,
            ),
          ),
          Positioned(
            right: 125.0,
            top: 12.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name ?? '',
                  style: getLargeStyle(
                      fontWeight: FontWeight.w400
                  ),
                ),
                const SizedBox(height: 8.0,),
                Text(
                  'أرباحك: 0 د.ك',
                  style: getSmallStyle(
                    color: ColorManager.grey,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12.0,
            left: 8.0,
            child: Text(
              book.classroom ?? '',
              style: getSmallStyle(
                color: const Color(0xff808080),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
