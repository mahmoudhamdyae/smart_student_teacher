import 'package:get/get.dart';
import 'package:teacher/domain/models/book.dart';

import '../../../../domain/repository/repository.dart';

class BooksController extends GetxController {

  final RxList<Book> books = RxList.empty();
  final RxInt usersCount = 0.obs;
  final RxDouble totalEarn = 0.0.obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  BooksController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getBooks();
  }

  Future<void> getBooks() async {
    _status.value = RxStatus.loading();
    try {
      // await _repository.getBooks().then((remoteBooksResponse) {
      //   _status.value = RxStatus.success();
      //   books.value = remoteBooksResponse.books ?? [];
      //   totalEarn.value = remoteBooksResponse.totalEarn ?? 0;
      //   _getUsersCount();
      // });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void _getUsersCount() {
    for (var singleBook in books) {
      usersCount.value += singleBook.userCount ?? 0;
    }
  }
}