class BooksResponse {
  List<Book>? books;
  List<BooksProfit>? booksProfit;

  BooksResponse({this.books, this.booksProfit});

  BooksResponse.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = <Book>[];
      json['books'].forEach((v) {
        books!.add(Book.fromJson(v));
      });
    }
    if (json['books_profit'] != null) {
      booksProfit = <BooksProfit>[];
      json['books_profit'].forEach((v) {
        booksProfit!.add(BooksProfit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    if (booksProfit != null) {
      data['books_profit'] = booksProfit!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Book {
  int? id;
  String? name;
  int? techerId;
  String? stage;
  String? classroom;
  int? quantity;
  double? teacherRatio;
  int? bookPrice;
  String? termType;
  int? active;
  String? pdf;
  String? createdAt;
  String? updatedAt;

  Book(
      {this.id,
        this.name,
        this.techerId,
        this.stage,
        this.classroom,
        this.quantity,
        this.teacherRatio,
        this.bookPrice,
        this.termType,
        this.active,
        this.pdf,
        this.createdAt,
        this.updatedAt});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    techerId = json['techer_id'];
    stage = json['stage'];
    classroom = json['classroom'];
    quantity = json['quantity'];
    teacherRatio = json['Teacher_ratio'];
    bookPrice = json['book_price'];
    termType = json['term_type'];
    active = json['active'];
    pdf = json['pdf'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['techer_id'] = techerId;
    data['stage'] = stage;
    data['classroom'] = classroom;
    data['quantity'] = quantity;
    data['Teacher_ratio'] = teacherRatio;
    data['book_price'] = bookPrice;
    data['term_type'] = termType;
    data['active'] = active;
    data['pdf'] = pdf;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BooksProfit {
  int? id;
  String? name;
  double? teacherRatio;
  int? bookPrice;
  String? classroom;
  String? totalQuantity;
  double? totalProfit;

  BooksProfit(
      {this.id,
        this.name,
        this.teacherRatio,
        this.bookPrice,
        this.classroom,
        this.totalQuantity,
        this.totalProfit});

  BooksProfit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    teacherRatio = json['Teacher_ratio'];
    bookPrice = json['book_price'];
    classroom = json['classroom'];
    totalQuantity = json['total_quantity'];
    totalProfit = json['total_profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['Teacher_ratio'] = teacherRatio;
    data['book_price'] = bookPrice;
    data['classroom'] = classroom;
    data['total_quantity'] = totalQuantity;
    data['total_profit'] = totalProfit;
    return data;
  }
}