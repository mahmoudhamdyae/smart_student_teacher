class CommentResponse {
  List<Comment>? comments;

  CommentResponse({this.comments});

  CommentResponse.fromJson(Map<String, dynamic> json) {
    if (json['Courses'] != null) {
      comments = <Comment>[];
      json['Courses'].forEach((v) {
        comments!.add(Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comments != null) {
      data['Courses'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? id;
  String? comment;
  int? videoId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  CommentVideo? video;
  CommentUser? user;

  Comment(
      {this.id,
        this.comment,
        this.videoId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.video,
        this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    videoId = json['video_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    video = json['video'] != null ? CommentVideo.fromJson(json['video']) : null;
    user = json['user'] != null ? CommentUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['video_id'] = videoId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (video != null) {
      data['video'] = video!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class CommentVideo {
  int? id;
  String? name;
  int? tutorialId;
  CommentTutorial? tutorial;

  CommentVideo({this.id, this.name, this.tutorialId, this.tutorial});

  CommentVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tutorialId = json['tutorial_id'];
    tutorial = json['tutorial'] != null
        ? CommentTutorial.fromJson(json['tutorial'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tutorial_id'] = tutorialId;
    if (tutorial != null) {
      data['tutorial'] = tutorial!.toJson();
    }
    return data;
  }
}

class CommentTutorial {
  int? id;
  String? name;
  int? courseId;
  CommentCourse? course;

  CommentTutorial({this.id, this.name, this.courseId, this.course});

  CommentTutorial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseId = json['course_id'];
    course =
    json['course'] != null ? CommentCourse.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['course_id'] = courseId;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class CommentCourse {
  int? id;
  String? subjectName;
  String? classroom;

  CommentCourse({this.id, this.subjectName, this.classroom});

  CommentCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    classroom = json['classroom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['classroom'] = classroom;
    return data;
  }
}

class CommentUser {
  int? id;
  String? name;

  CommentUser({this.id, this.name});

  CommentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}