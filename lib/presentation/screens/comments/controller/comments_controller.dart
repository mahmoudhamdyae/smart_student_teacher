import 'package:get/get.dart';

import '../../../../domain/repository/repository.dart';

class CommentsController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  CommentsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getCourses();
  }

  void _getCourses() {
    _status.value = RxStatus.loading();
    try {
      // _repository.getCourses().then((remoteOrders) {
      //   _status.value = RxStatus.success();
      // });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}