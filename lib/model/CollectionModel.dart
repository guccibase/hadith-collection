class CollectionModel {
  int collectionID;
  String descEn;
  String nameEn;

  CollectionModel({this.collectionID, this.descEn, this.nameEn});

  CollectionModel.fromJson(Map<String, dynamic> json) {
    collectionID = json['CollectionID'];
    descEn = json['desc_en'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CollectionID'] = this.collectionID;
    data['desc_en'] = this.descEn;
    data['name_en'] = this.nameEn;
    return data;
  }
}

class CollectionListModel {
  final List<CollectionModel> collectionsList;

  CollectionListModel({
    this.collectionsList,
  });

  factory CollectionListModel.fromJson(List<dynamic> parsedJson) {
    List<CollectionModel> list = new List<CollectionModel>();
    list = parsedJson.map((i) => CollectionModel.fromJson(i)).toList();
    return new CollectionListModel(collectionsList: list);
  }
}
