class Course {
  int? id;
  String? name;
  int? month;
  int? term;
  String? marhala;
  String? type;
  String? rate;
  String? teacher;

  Course({
    this.id,
    this.name,
    this.month,
    this.term,
    this.marhala,
    this.type,
    this.rate,
    this.teacher
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int? ?? 0,
      name: json['subject_name'] as String? ?? '',
      month: json['monthly_subscription_price'] as int? ?? 0,
      term: json['term_price'] as int? ?? 0,
      marhala: json['classroom'] as String? ?? '',
      type: json['type'] as String? ?? '',
      rate: '4.3',
      teacher: json['techer']['name'] as String? ?? '',
    );
  }
}