import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teacher/domain/models/book.dart';
import 'package:teacher/presentation/screens/books/controller/books_controller.dart';
import 'package:teacher/presentation/screens/books/widgets/books_list.dart';

import '../../../resources/strings_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/loading_screen.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          HomeAppBar(),
          RefreshIndicator(
            onRefresh: () async => await Get.find<BooksController>().getBooks(),
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                GetX<BooksController>(
                  init: Get.find<BooksController>(),
                  builder: (BooksController controller) {
                    if (controller.status.isLoading) {
                      return const LoadingScreen();
                    } else if (controller.status.isError) {
                      return ErrorScreen(error: controller.status.errorMessage ?? '');
                    } else if (controller.books.isEmpty){
                      return const EmptyScreen(emptyString: AppStrings.noBooks);
                    }
                    final List<BooksProfit> books = controller.books;
                    return BooksList(
                      books: books,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
