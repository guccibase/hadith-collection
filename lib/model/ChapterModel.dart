class ChapterModel {
  String bookID;
  String chapID;
  int collectionID;
  String nameAr;
  String nameEn;

  ChapterModel(
      {this.bookID, this.chapID, this.collectionID, this.nameAr, this.nameEn});

  ChapterModel.fromJson(Map<String, dynamic> json) {
    bookID = json['BookID'];
    chapID = json['ChapID'];
    collectionID = json['CollectionID'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookID'] = this.bookID;
    data['ChapID'] = this.chapID;
    data['CollectionID'] = this.collectionID;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class ChapterListModel {
  final List<ChapterModel> ChaptersList;

  ChapterListModel({
    this.ChaptersList,
  });

  factory ChapterListModel.fromJson(List<dynamic> parsedJson) {
    List<ChapterModel> list = new List<ChapterModel>();
    list = parsedJson.map((i) => ChapterModel.fromJson(i)).toList();
    return new ChapterListModel(ChaptersList: list);
  }
}
