import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:sahih_bukhari_app/about_us.dart';
import 'package:sahih_bukhari_app/animations/bottomAnimation.dart';
import 'package:sahih_bukhari_app/customWidgets/flare.dart';
import 'package:sahih_bukhari_app/main.dart';
import 'package:sahih_bukhari_app/model/CollectionModel.dart';
import 'package:sahih_bukhari_app/privacy-policy.dart';
import 'package:share_plus/share_plus.dart';

enum Availability { LOADING, AVAILABLE, UNAVAILABLE }

extension on Availability {
  String stringify() => this.toString().split('.').last;
}

class SelectHadith extends StatefulWidget {
  @override
  _SelectHadithState createState() => _SelectHadithState();
}

class _SelectHadithState extends State<SelectHadith> {
  List<CollectionModel> _searchResult = [];
  List<CollectionModel> _userDetails = [];
  TextEditingController controller = new TextEditingController();
  final InAppReview _inAppReview = InAppReview.instance;
  String _appStoreId = '1563527366';
  String _microsoftStoreId = '';
  Availability _availability = Availability.LOADING;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );

  @override
  void initState() {
    super.initState();

    loadCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          _availability = isAvailable && Platform.isAndroid
              ? Availability.AVAILABLE
              : Availability.UNAVAILABLE;
        });
      } catch (e) {
        setState(() => _availability = Availability.UNAVAILABLE);
      }
    });
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

  void _onShare(BuildContext context) async {
    String appLink = "http://onelink.to/hadithcollection";
    String subject =
        "Assalaamu Alaikum, checkout this Hadith app with English translation. It's ad-free and privacy focused";
    final box = context.findRenderObject() as RenderBox;

    await Share.share(appLink,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white70,
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: Center(
            child: Text(
          'Hadiths',
          style: TextStyle(fontSize: 30),
        )),
        brightness: Brightness.dark,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/icon.png'),
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  leading: Icon(Icons.share_outlined),
                  title: Text('Share app'),
                  onTap: () => _onShare(context),
                ),
                ListTile(
                  leading: Icon(Icons.star_rate_outlined),
                  title: Text('Rate app'),
                  onTap: () => _openStoreListing(),
                ),
                ListTile(
                  leading: Icon(Icons.account_box_outlined),
                  title: Text('About us'),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs())),
                ),
                ListTile(
                  leading: Icon(Icons.share_outlined),
                  title: Text('Privacy Policy'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen())),
                ),
                ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LicensePage(
                          applicationIcon: ImageIcon(
                            AssetImage(
                              'assets/images/icon.png',
                            ),
                            size: 100,
                          ),
                          applicationName: 'Hadith Collection',
                          applicationLegalese: 'UMRA Tech @2021',
                        ),
                      )),
                  title: Text("Third Party Libraries"),
                  leading: Wrap(
                    children: <Widget>[
                      Icon(Icons.library_add_outlined),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).backgroundColor,
        ),
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
