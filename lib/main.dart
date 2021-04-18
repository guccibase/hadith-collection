import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sahih_bukhari_app/Splash.dart';
import 'package:sahih_bukhari_app/animations/bottomAnimation.dart';
import 'package:sahih_bukhari_app/customWidgets/flare.dart';
import 'package:sahih_bukhari_app/detail.dart';
import 'package:sahih_bukhari_app/model/BookModel.dart';

void main() {
  runApp(MyApp());
}

final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Color(0xff896277),
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    fontFamily: 'AmiriRegular',
    textTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: 'AmiriRegular',
            fontSize: 42,
            fontWeight: FontWeight.w600),
        headline2: TextStyle(
            fontFamily: 'AmiriRegular',
            fontSize: 28,
            fontWeight: FontWeight.w600),
        bodyText1: TextStyle(
            fontFamily: "AmiriRegular",
            fontSize: 18,
            height: 1.3,
            fontWeight: FontWeight.w600),
        caption: TextStyle(fontFamily: "AmiriRegular", fontSize: 14)));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      title: 'Hadith',
      // home: Splash(),
      // home: MyHomePage(),
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String id, en_title;

  const MyHomePage({
    Key key,
    @required this.id,
    @required this.en_title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(id, en_title);
}

class _MyHomePageState extends State<MyHomePage> {
  List<BookModel> _searchResult = [];
  List<BookModel> _userDetails = [];
  TextEditingController controller = new TextEditingController();

  final String bookId, en_title;

  _MyHomePageState(this.bookId, this.en_title);

  @override
  void initState() {
    super.initState();

    loadCategories();
  }

  Future loadCategories() async {
    String jsonPhotos = await DefaultAssetBundle.of(context)
        .loadString("assets/json_files/Book.json");
    final jsonResponse = json.decode(jsonPhotos);

    BookListModel bookList = BookListModel.fromJson(jsonResponse, bookId);

    setState(() {
      _userDetails = bookList.booksList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          en_title,
          style: TextStyle(fontSize: 30),
        )),
        brightness: Brightness.dark,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  color: Theme.of(context).primaryColor,
                  child: _buildSearchBox()),
              Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _buildSearchResults()
                    : _buildListView(),
              ),
            ],
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            flareDuration: Duration(seconds: 17),
            left: 100,
            height: 60,
            width: 60,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            flareDuration: Duration(seconds: 12),
            left: 10,
            height: 25,
            width: 25,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -40,
            left: -100,
            flareDuration: Duration(seconds: 18),
            height: 50,
            width: 50,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            left: -80,
            flareDuration: Duration(seconds: 15),
            height: 50,
            width: 50,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -20,
            left: -120,
            flareDuration: Duration(seconds: 12),
            height: 40,
            width: 40,
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _buildListView() {
    return Container(
      color: Colors.black,
      child: Material(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Divider(
                color: Color(0xffee8f8b),
                height: 2.0,
              ),
            );
          },
          itemCount: _userDetails.length,
          itemBuilder: (context, index) {
            return WidgetAnimator(
              ListTile(
                leading: Text(
                  "${_userDetails[index].bookID}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                title: Text(
                  "${_userDetails[index].nameEn}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () => {
                  FocusScope.of(context).unfocus(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(
                              id: _userDetails[index].bookID,
                              en_title: _userDetails[index].nameEn,
                              ar_title: _userDetails[index].nameEn,
                              collectionId:
                                  _userDetails[index].collectionID.toString(),
                            )),
                  )
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      color: Colors.black,
      child: Material(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Divider(
                color: Color(0xffee8f8b),
                height: 2.0,
              ),
            );
          },
          itemCount: _searchResult.length,
          itemBuilder: (context, index) {
            return WidgetAnimator(
              ListTile(
                leading: Text(
                  "${_searchResult[index].bookID}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                title: Text(
                  "${_searchResult[index].nameEn}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () => {
                  FocusScope.of(context).unfocus(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(
                              id: _searchResult[index].bookID,
                              en_title: _searchResult[index].nameEn,
                              ar_title: _searchResult[index].nameEn,
                              collectionId:
                                  _searchResult[index].collectionID.toString(),
                            )),
                  )
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Icon(Icons.search),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: TextField(
                    obscureText: false,
                    controller: controller,
                    decoration: new InputDecoration(
                      hintText: "Search topic",
                      border: InputBorder.none,
                    ),
                    onChanged: onSearchTextChanged,
                  ),
                ),
              ),
              IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () {
                  controller.clear();
                  onSearchTextChanged('');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.nameEn.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(userDetail);
      }
    });

    setState(() {});
  }
}
