import 'package:get/get.dart';
import 'package:teacher/domain/models/notification.dart';

import '../../../../domain/repository/repository.dart';

class CommentsController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final RxList<NotificationModel> notifications = RxList.empty();

  final Repository _repository;
  CommentsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getComments();
  }

  Future<void> getComments() async {
    _status.value = RxStatus.loading();
    try {
      // await _repository.getComments().then((remoteOrders) {
        _status.value = RxStatus.success();
      // });
      notifications.value = List.generate(20, (index) => NotificationModel(
          'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص',
          '3 ساعة')
      );
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}