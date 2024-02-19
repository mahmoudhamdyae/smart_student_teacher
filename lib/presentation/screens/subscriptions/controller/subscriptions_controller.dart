import 'package:get/get.dart';

import '../../../../domain/models/notification.dart';
import '../../../../domain/repository/repository.dart';

class SubscriptionsController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final RxList<NotificationModel> notifications = RxList.empty();

  final Repository _repository;
  SubscriptionsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getSubscriptions();
  }

  Future<void> getSubscriptions() async {
    _status.value = RxStatus.loading();
    try {
      // await _repository.getSubscriptions().then((remoteOrders) {
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