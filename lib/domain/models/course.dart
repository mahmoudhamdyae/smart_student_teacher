class CoursesResponse {
  List<Course>? courses;
  Teacher? teacher;
  double? totalEarn;

  CoursesResponse({this.courses, this.teacher, this.totalEarn});

  CoursesResponse.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Course>[];
      json['courses'].forEach((v) {
        courses!.add(Course.fromJson(v));
      });
    }
    teacher =
    json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    totalEarn = json['totalEarn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    data['totalEarn'] = totalEarn;
    return data;
  }
}

class Course {
  int? id;
  String? subjectName;
  int? techerId;
  String? stage;
  String? classroom;
  String? expiryDate;
  String? type;
  dynamic teacherRatioCourse;
  int? termPrice;
  int? monthlySubscriptionPrice;
  String? termType;
  int? active;
  String? createdAt;
  String? updatedAt;
  int? userCount;

  Course(
      {this.id,
        this.subjectName,
        this.techerId,
        this.stage,
        this.classroom,
        this.expiryDate,
        this.type,
        this.teacherRatioCourse,
        this.termPrice,
        this.monthlySubscriptionPrice,
        this.termType,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.userCount});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    techerId = json['techer_id'];
    stage = json['stage'];
    classroom = json['classroom'];
    expiryDate = json['expiry_date'];
    type = json['type'];
    teacherRatioCourse = json['Teacher_ratio_course'];
    termPrice = json['term_price'];
    monthlySubscriptionPrice = json['monthly_subscription_price'];
    termType = json['term_type'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userCount = json['user_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['techer_id'] = techerId;
    data['stage'] = stage;
    data['classroom'] = classroom;
    data['expiry_date'] = expiryDate;
    data['type'] = type;
    data['Teacher_ratio_course'] = teacherRatioCourse;
    data['term_price'] = termPrice;
    data['monthly_subscription_price'] = monthlySubscriptionPrice;
    data['term_type'] = termType;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_count'] = userCount;
    return data;
  }
}

class Teacher {
  int? id;
  String? image;

  Teacher({this.id, this.image});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}