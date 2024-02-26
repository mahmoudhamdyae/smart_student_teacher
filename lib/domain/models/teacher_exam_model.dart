class TeacherExamModel {
  List<TeacherExam>? teacherExam;
  List<TeacherBank>? teacherBank;

  TeacherExamModel({this.teacherExam, this.teacherBank});

  TeacherExamModel.fromJson(Map<String, dynamic> json) {
    if (json['teacherExam'] != null) {
      teacherExam = <TeacherExam>[];
      json['teacherExam'].forEach((v) {
        teacherExam!.add(TeacherExam.fromJson(v));
      });
    }
    if (json['teacherBank'] != null) {
      teacherBank = <TeacherBank>[];
      json['teacherBank'].forEach((v) {
        teacherBank!.add(TeacherBank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teacherExam != null) {
      data['teacherExam'] = teacherExam!.map((v) => v.toJson()).toList();
    }
    if (teacherBank != null) {
      data['teacherBank'] = teacherBank!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherExam {
  int? id;
  int? teacherId;
  int? courseId;
  String? previousTest;
  String? solvedTest;
  String? unsolvedTest;
  String? shortOne;
  String? shortTwo;
  String? finalReview;
  String? termType;
  String? createdAt;
  String? updatedAt;
  TeacherCourse? course;

  TeacherExam(
      {this.id,
        this.teacherId,
        this.courseId,
        this.previousTest,
        this.solvedTest,
        this.unsolvedTest,
        this.shortOne,
        this.shortTwo,
        this.finalReview,
        this.termType,
        this.createdAt,
        this.updatedAt,
        this.course});

  TeacherExam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    courseId = json['course_id'];
    previousTest = json['previous_test'];
    solvedTest = json['solved_test'];
    unsolvedTest = json['unsolved_test'];
    shortOne = json['short_one'];
    shortTwo = json['short_two'];
    finalReview = json['final_review'];
    termType = json['term_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    course =
    json['course'] != null ? TeacherCourse.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['course_id'] = courseId;
    data['previous_test'] = previousTest;
    data['solved_test'] = solvedTest;
    data['unsolved_test'] = unsolvedTest;
    data['short_one'] = shortOne;
    data['short_two'] = shortTwo;
    data['final_review'] = finalReview;
    data['term_type'] = termType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class TeacherCourse {
  int? id;
  String? subjectName;
  String? classroom;

  TeacherCourse({this.id, this.subjectName, this.classroom});

  TeacherCourse.fromJson(Map<String, dynamic> json) {
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

class TeacherBank {
  int? id;
  int? teacherId;
  int? courseId;
  String? solvedBank;
  String? unsolvedBank;
  String? bookTest;
  String? termType;
  String? createdAt;
  String? updatedAt;
  TeacherCourse? course;

  TeacherBank(
      {this.id,
        this.teacherId,
        this.courseId,
        this.solvedBank,
        this.unsolvedBank,
        this.bookTest,
        this.termType,
        this.createdAt,
        this.updatedAt,
        this.course});

  TeacherBank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    courseId = json['course_id'];
    solvedBank = json['solved_bank'];
    unsolvedBank = json['unsolved_bank'];
    bookTest = json['book_test'];
    termType = json['term_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    course =
    json['course'] != null ? TeacherCourse.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['course_id'] = courseId;
    data['solved_bank'] = solvedBank;
    data['unsolved_bank'] = unsolvedBank;
    data['book_test'] = bookTest;
    data['term_type'] = termType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}