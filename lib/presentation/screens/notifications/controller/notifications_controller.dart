import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teacher/domain/models/notification.dart';

import '../../../../domain/repository/repository.dart';

class NotificationsController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;
  final Rx<RxStatus> _addCommentStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get addCommentStatus => _addCommentStatus.value;

  final TextEditingController commentEditText = TextEditingController();
  final RxList<NotificationModel> notifications = RxList.empty();
  final Rx<NotificationModel> selectedNotification = NotificationModel().obs;

  final Repository _repository;
  NotificationsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.getNotifications().then((remoteNotifications) {
        _status.value = RxStatus.success();
        notifications.value = remoteNotifications;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  Future<void> addComment() async {
    try {
      _addCommentStatus.value = RxStatus.loading();
      await _repository.addComment(commentEditText.text, selectedNotification.value.route?.id ?? -1).then((value) {
        _addCommentStatus.value = RxStatus.success();
        commentEditText.text = '';
      });
    } on Exception catch (e) {
      _addCommentStatus.value = RxStatus.error(e.toString());
    }
  }

  void updateComment(String comment) {
    commentEditText.text = comment;
  }

  void delNotification(int notificationId, int index) {
    _repository.delNotification(notificationId);
    notifications.removeAt(index);
  }

  @override
  void onClose() {
    super.onClose();
    commentEditText.dispose();
  }
}