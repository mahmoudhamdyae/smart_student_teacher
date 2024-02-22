import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../domain/models/comment.dart';
import '../../../../domain/models/notification.dart';
import '../../../../domain/repository/repository.dart';

class NotificationsController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;
  final Rx<RxStatus> _addCommentStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get addCommentStatus => _addCommentStatus.value;

  final TextEditingController commentEditText = TextEditingController();
  final RxList<Comment> comments = RxList.empty();
  final Rx<Comment> selectedComment = Comment().obs;

  final RxList<NotificationModel> notifications = RxList.empty();

  final Repository _repository;
  NotificationsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getSubscriptions();
    getComments();
  }

  Future<void> getSubscriptions() async {
    _status.value = RxStatus.loading();
    try {
      // await _repository.getSubscriptions().then((remoteOrders) {
        _status.value = RxStatus.success();
      // });
      notifications.value = List.generate(20, (index) => NotificationModel(
          text: 'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص',)
      );
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  Future<void> getComments() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.getComments().then((remoteComments) {
        _status.value = RxStatus.success();
        comments.value = remoteComments;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  Future<void> addComment() async {
    try {
      _addCommentStatus.value = RxStatus.loading();
      await _repository.addComment(commentEditText.text, selectedComment.value.video?.id ?? -1).then((value) {
        _addCommentStatus.value = RxStatus.success();
      });
    } on Exception catch (e) {
      _addCommentStatus.value = RxStatus.error(e.toString());
    }
  }

  void updateComment(String comment) {
    commentEditText.text = comment;
  }

  @override
  void onClose() {
    super.onClose();
    commentEditText.dispose();
  }
}