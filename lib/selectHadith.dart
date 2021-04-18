import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sahih_bukhari_app/animations/bottomAnimation.dart';
import 'package:sahih_bukhari_app/customWidgets/flare.dart';
import 'package:sahih_bukhari_app/main.dart';
import 'package:sahih_bukhari_app/model/CollectionModel.dart';

class SelectHadith extends StatefulWidget {
  @override
  _SelectHadithState createState() => _SelectHadithState();
}

class _SelectHadithState extends State<SelectHadith> {
  List<CollectionModel> _searchResult = [];
  List<CollectionModel> _userDetails = [];
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    loadCategories();
  }

  Future loadCategories() async {
    String jsonPhotos = await DefaultAssetBundle.of(context)
        .loadString("assets/json_files/Collection.json");
    final jsonResponse = json.decode(jsonPhotos);

    CollectionListModel collectionList =
        CollectionListModel.fromJson(jsonResponse);

    setState(() {
      _userDetails = collectionList.collectionsList;
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
          'Hadiths',
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
                  "${_userDetails[index].collectionID}",
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
                        builder: (context) => MyHomePage(
                              id: _userDetails[index].collectionID.toString(),
                              en_title: _userDetails[index].nameEn,
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
                  "${_searchResult[index].collectionID}",
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
                        builder: (context) => MyHomePage(
                              id: _searchResult[index].collectionID.toString(),
                              en_title: _searchResult[index].nameEn,
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
                      hintText: "Search book",
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
