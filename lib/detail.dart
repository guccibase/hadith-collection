import 'dart:convert';
import 'dart:io';

import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahih_bukhari_app/animations/bottomAnimation.dart';
import 'package:sahih_bukhari_app/customWidgets/common_widgets.dart';
import 'package:sahih_bukhari_app/model/ChapterModel.dart';
import 'package:sahih_bukhari_app/model/HadithModel.dart';

class Detail extends StatefulWidget {
  final String id, collectionId, ar_title, en_title;

  const Detail({
    Key key,
    @required this.id,
    @required this.collectionId,
    @required this.ar_title,
    @required this.en_title,
  }) : super(key: key);

  @override
  _DetailState createState() =>
      _DetailState(id, collectionId, ar_title, en_title);
}

class _DetailState extends State<Detail> {
  final String bookId, collectionId, ar_title, en_title;

  _DetailState(this.bookId, this.collectionId, this.ar_title, this.en_title);

  List<ChapterModel> chaptersList = [];
  List<HadithModel> hadithsList = [];
  bool isLoaded = false;

  List<String> collectionList = [
    "",
    "1SahihBukhari.json",
    "2SahihMuslim.json",
    "3AnNasai.json",
    "4AbuDawood.json",
    "5JamiatTirmidhi.json",
    "6IbnMajah.json",
    "7MalikMuwatta.json",
    "8MusnadAhmed.json",
    "9RiyadUsSaliheen.json",
    "10ShamailTirmidhi.json",
    "11AlAdabAlMufrad.json",
    "12BulughAlMaram.json",
    "13Nawawi.json",
    "14QudsiHadith.json"
  ];

  getDetailList() async {
    String jsonItem = await DefaultAssetBundle.of(context).loadString(
        "assets/json_files/${collectionList[int.parse(collectionId)]}");

    var jsonResponse = json.decode(jsonItem);

    HadithListModel itemListModel =
        new HadithListModel.fromJson(jsonResponse, collectionId, bookId);

    setState(() {
      hadithsList = itemListModel.hadithsList;
      isLoaded = true;
    });
  }

  getChapterList() async {
    String jsonItem = await DefaultAssetBundle.of(context)
        .loadString("assets/json_files/Chapter.json");

    var jsonResponse = json.decode(jsonItem);

    ChapterListModel model = new ChapterListModel.fromJson(jsonResponse);

    setState(() {
      chaptersList = model.ChaptersList;
    });
  }

  @override
  void initState() {
    super.initState();

    getChapterList();

    getDetailList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () => {buildPop()},
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Icon(
                        Platform.isAndroid
                            ? Icons.arrow_back
                            : Icons.arrow_back_ios,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[850],
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                child: Text(widget.en_title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                        fontSize: 23)),
              ),
            ),
            Expanded(
                child: isLoaded
                    ? hadithsList.length != 0
                        ? ListView.builder(
                            itemCount: hadithsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return WidgetAnimator(
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible: () {
                                                  if (hadithsList[index]
                                                              .chapID ==
                                                          "0" ||
                                                      hadithsList[index]
                                                          .chapID
                                                          .isEmpty) {
                                                    return false;
                                                  } else {
                                                    return true;
                                                  }
                                                }(),
                                                child: Text(
                                                  "Chapter " +
                                                      hadithsList[index]
                                                          .chapID +
                                                      ". ",
                                                  style: TextStyle(height: 1.3),
                                                ),
                                              ),
                                              Visibility(
                                                visible: () {
                                                  if (hadithsList[index]
                                                              .chapID ==
                                                          "0" ||
                                                      hadithsList[index]
                                                          .chapID
                                                          .isEmpty) {
                                                    return false;
                                                  } else {
                                                    return true;
                                                  }
                                                }(),
                                                child: Expanded(
                                                  child: Text(
                                                    buildGetChapterName(
                                                        hadithsList[index]),
                                                    style: TextStyle(
                                                      height: 1.3,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Card(
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        hadithsList[index]
                                                            .hadithID,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            height: 1.3),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          // textAlign:TextAlign.end,
                                                          hadithsList[index]
                                                              .gradeEn,
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              height: 1.3),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: () {
                                                    return hadithsList[index]
                                                        .narratorEn
                                                        .isNotEmpty;
                                                  }(),
                                                  child: Divider(
                                                    color: Color(0xffee8f8b),
                                                    height: 2.0,
                                                  ),
                                                ),
                                                // here
                                                Visibility(
                                                  visible: () {
                                                    return hadithsList[index]
                                                        .narratorEn
                                                        .isNotEmpty;
                                                  }(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        hadithsList[index]
                                                            .narratorEn,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'AmiriRegular',
                                                            fontSize: 13,
                                                            height: 1.3,
                                                            fontStyle: FontStyle
                                                                .italic)),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: () {
                                                    return hadithsList[index]
                                                        .textAr
                                                        .isNotEmpty;
                                                  }(),
                                                  child: Divider(
                                                    color: Color(0xffee8f8b),
                                                    height: 2.0,
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: () {
                                                    return hadithsList[index]
                                                        .textAr
                                                        .isNotEmpty;
                                                  }(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Container(
                                                        child: ArDescriptionTextWidget(
                                                            text: hadithsList[
                                                                    index]
                                                                .textAr,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontFamily:
                                                                    'Amiri',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  color: Color(0xffee8f8b),
                                                  height: 2.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Container(
                                                        child:
                                                            EnDescriptionTextWidget(
                                                      text: hadithsList[index]
                                                          .textEn,
                                                    )

                                                        // Text(
                                                        //     hadithsList[index]
                                                        //         .textEn,
                                                        //     style: TextStyle(
                                                        //         height: 1.4,
                                                        //         fontFamily:
                                                        //             'Amiri',
                                                        //         fontWeight:
                                                        //             FontWeight
                                                        //                 .w100)),
                                                        ),
                                                  ),
                                                ),
                                                Divider(
                                                  color: Color(0xffee8f8b),
                                                  height: 2.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      hadithsList[index]
                                                          .referenceEn,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        height: 1.3,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                            "Not Yet Available",
                            style: TextStyle(fontSize: 24),
                          ))
                    : Center(
                        child: Text(
                        "Loading...",
                        style: TextStyle(fontSize: 20),
                      )))
          ],
        ),
      ),
    );
  }

  String buildGetChapterName(HadithModel model) {
    for (var j = 0; j < chaptersList.length; j++) {
      if (chaptersList[j].bookID == model.bookID &&
          chaptersList[j].collectionID.toString() == model.collectionID &&
          chaptersList[j].chapID.replaceAll(".0", "") == model.chapID) {
        return chaptersList[j].nameEn != null ? chaptersList[j].nameEn : "";
      }
    }

    return "";
  }

  void buildPop() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}
