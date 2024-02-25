import 'package:flutter/material.dart';
import 'package:teacher/core/utils/insets.dart';
import 'package:teacher/presentation/screens/books/widgets/book_item.dart';
import 'package:teacher/presentation/screens/books/widgets/books_counts_widget.dart';

import '../../../../domain/models/book.dart';

class BooksList extends StatelessWidget {

  final List<BooksProfit> books;
  const BooksList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 8.0,),
        const BooksCountsWidgets(),
        const SizedBox(height: 8.0,),
        isWide(context) ? _buildGridView(context) : _buildListView(),
      ],
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return BookItem(book: books[index]);
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      crossAxisCount:(MediaQuery.of(context).size.width ~/ 350).toInt(),
      childAspectRatio: 3.5,
      children: List.generate(books.length, (index) {
        return BookItem(book: books[index]);
      }),
    );
  }
}
