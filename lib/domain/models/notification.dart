class NotificationModel {
  int? id;
  int? techerId;
  String? from;
  String? title;
  String? body;
  Route? route;
  int? shown;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
        this.techerId,
        this.from,
        this.title,
        this.body,
        this.route,
        this.shown,
        this.createdAt,
        this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    techerId = json['techer_id'];
    from = json['from'];
    title = json['title'];
    body = json['body'];
    route = json['route'] != null ? Route.fromJson(json['route']) : null;
    shown = json['shown'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['techer_id'] = techerId;
    data['from'] = from;
    data['title'] = title;
    data['body'] = body;
    if (route != null) {
      data['route'] = route!.toJson();
    }
    data['shown'] = shown;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Route {
  String? type;
  int? id;

  Route({this.type, this.id});

  Route.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}