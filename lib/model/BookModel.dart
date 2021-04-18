class BookModel {
  String bookID;
  int collectionID;
  int hadithCount;
  int hadithEnd;
  int hadithStart;
  String nameEn;
  String nameshortEn;

  BookModel(
      {this.bookID,
      this.collectionID,
      this.hadithCount,
      this.hadithEnd,
      this.hadithStart,
      this.nameEn,
      this.nameshortEn});

  BookModel.fromJson(Map<String, dynamic> json) {
    bookID = json['BookID'];
    collectionID = json['CollectionID'];
    hadithCount = json['hadith_count'];
    hadithEnd = json['hadith_end'];
    hadithStart = json['hadith_start'];
    nameEn = json['name_en'];
    nameshortEn = json['nameshort_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookID'] = this.bookID;
    data['CollectionID'] = this.collectionID;
    data['hadith_count'] = this.hadithCount;
    data['hadith_end'] = this.hadithEnd;
    data['hadith_start'] = this.hadithStart;
    data['name_en'] = this.nameEn;
    data['nameshort_en'] = this.nameshortEn;
    return data;
  }
}

class BookListModel {
  final List<BookModel> booksList;

  BookListModel({
    this.booksList,
  });

  factory BookListModel.fromJson(List<dynamic> parsedJson, String bookId) {
    List<BookModel> list = new List<BookModel>();
    //list = parsedJson.map((i) => BookModel.fromJson(i)).toList();

    parsedJson.forEach((element) {
      if (element["CollectionID"].toString() == bookId) {
        list.add(BookModel.fromJson(element));
      }
    });
    return new BookListModel(booksList: list);
  }
}
