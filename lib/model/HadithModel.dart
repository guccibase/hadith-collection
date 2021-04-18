class HadithModel {
  String bookID;
  String chapID;
  String collectionID;
  String hadithID;
  String hadithIDCollection;
  String global; //
  String gradeAr;
  String gradeArDiacless;
  String gradeEn;
  String narratorAr;
  String narratorArDiacless;
  String narratorArend;
  String narratorArendDiacless;
  String narratorEn;
  String narrators;
  String referenceEn;
  String relatedEn;
  String textAr;
  String textArDiacless;
  String textEn;

  HadithModel(
      {this.bookID,
      this.chapID,
      this.collectionID,
      this.hadithID,
      this.hadithIDCollection,
      this.global,
      this.gradeAr,
      this.gradeArDiacless,
      this.gradeEn,
      this.narratorAr,
      this.narratorArDiacless,
      this.narratorArend,
      this.narratorArendDiacless,
      this.narratorEn,
      this.narrators,
      this.referenceEn,
      this.relatedEn,
      this.textAr,
      this.textArDiacless,
      this.textEn});

  HadithModel.fromJson(Map<String, dynamic> json) {
    bookID = json['BookID'].toString();
    chapID = json['ChapID'].toString();
    collectionID = json['CollectionID'].toString();
    hadithID = json['HadithID'].toString();
    hadithIDCollection = json['HadithIDCollection'].toString();
    global = json['global'].toString();
    gradeAr = json['grade_ar'];
    gradeArDiacless = json['grade_ar_diacless'];
    gradeEn = json['grade_en'];
    narratorAr = json['narrator_ar'];
    narratorArDiacless = json['narrator_ar_diacless'];
    narratorArend = json['narrator_arend'];
    narratorArendDiacless = json['narrator_arend_diacless'];
    narratorEn = json['narrator_en'];
    narrators = json['narrators'];
    referenceEn = json['reference_en'];
    relatedEn = json['related_en'];
    textAr = json['text_ar'];
    textArDiacless = json['text_ar_diacless'];
    textEn = json['text_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookID'] = this.bookID;
    data['ChapID'] = this.chapID;
    data['CollectionID'] = this.collectionID;
    data['HadithID'] = this.hadithID;
    data['HadithIDCollection'] = this.hadithIDCollection;
    data['global'] = this.global;
    data['grade_ar'] = this.gradeAr;
    data['grade_ar_diacless'] = this.gradeArDiacless;
    data['grade_en'] = this.gradeEn;
    data['narrator_ar'] = this.narratorAr;
    data['narrator_ar_diacless'] = this.narratorArDiacless;
    data['narrator_arend'] = this.narratorArend;
    data['narrator_arend_diacless'] = this.narratorArendDiacless;
    data['narrator_en'] = this.narratorEn;
    data['narrators'] = this.narrators;
    data['reference_en'] = this.referenceEn;
    data['related_en'] = this.relatedEn;
    data['text_ar'] = this.textAr;
    data['text_ar_diacless'] = this.textArDiacless;
    data['text_en'] = this.textEn;
    return data;
  }
}

class HadithListModel {
  final List<HadithModel> hadithsList;

  HadithListModel({
    this.hadithsList,
  });

  factory HadithListModel.fromJson(
      List<dynamic> parsedJson, String collectionID, String bookId) {
    List<HadithModel> list = new List<HadithModel>();
    // list = parsedJson.map((i) => HadithModel.fromJson(i)).toList();

    parsedJson.forEach((element) {
      if (element["CollectionID"].toString() == collectionID &&
          element["BookID"].toString() == bookId) {
        list.add(HadithModel.fromJson(element));
      }
    });

    return new HadithListModel(hadithsList: list);
  }

  factory HadithListModel.fromFullJson(List<dynamic> parsedJson) {
    List<HadithModel> list = new List<HadithModel>();
    list = parsedJson.map((i) => HadithModel.fromJson(i)).toList();
    return new HadithListModel(hadithsList: list);
  }
}
