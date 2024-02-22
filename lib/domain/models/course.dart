class Course {
  int? id;
  String? name;
  int? month;
  int? term;
  String? marhala;
  String? type;
  int? userCount;

  Course({
    this.id,
    this.name,
    this.month,
    this.term,
    this.marhala,
    this.type,
    this.userCount
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int? ?? 0,
      name: json['subject_name'] as String? ?? '',
      month: json['monthly_subscription_price'] as int? ?? 0,
      term: json['term_price'] as int? ?? 0,
      marhala: json['classroom'] as String? ?? '',
      type: json['type'] as String? ?? '',
      userCount: json['user_count'] as int? ?? 0,
    );
  }
}