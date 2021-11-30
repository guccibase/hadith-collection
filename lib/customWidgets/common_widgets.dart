import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ArDescriptionTextWidget extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextDirection textDirection;

  ArDescriptionTextWidget(
      {@required this.text, this.style, this.textDirection});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<ArDescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SelectableAutoLinkText(
              firstHalf,
              style: widget.style,
              textDirection: TextDirection.rtl,
              onTap: (url) => launch(url, forceSafariVC: false),
              onLongPress: (url) => Share.share(url),
              linkStyle: TextStyle(color: Colors.yellow),
              highlightedLinkStyle: TextStyle(
                color: Colors.deepOrangeAccent,
                backgroundColor: Colors.deepOrangeAccent.withAlpha(0x33),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SelectableAutoLinkText(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: widget.style,
                  textDirection: TextDirection.rtl,
                  onTap: (url) => launch(url, forceSafariVC: false),
                  onLongPress: (url) => Share.share(url),
                  linkStyle: TextStyle(color: Colors.yellow),
                  highlightedLinkStyle: TextStyle(
                    color: Colors.deepOrangeAccent,
                    backgroundColor: Colors.deepOrangeAccent.withAlpha(0x33),
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "show more" : "show less",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        flag = !flag;
                      });
                    }
                  },
                ),
              ],
            ),
    );
  }
}

class EnDescriptionTextWidget extends StatefulWidget {
  final String text;

  EnDescriptionTextWidget({@required this.text});

  @override
  _EnDescriptionTextWidgetState createState() =>
      new _EnDescriptionTextWidgetState();
}

class _EnDescriptionTextWidgetState extends State<EnDescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SelectableAutoLinkText(
              firstHalf,
              onTap: (url) => launch(url, forceSafariVC: false),
              onLongPress: (url) => Share.share(url),
              linkStyle: TextStyle(color: Colors.yellow),
              highlightedLinkStyle: TextStyle(
                color: Colors.deepOrangeAccent,
                backgroundColor: Colors.deepOrangeAccent.withAlpha(0x33),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SelectableAutoLinkText(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  onTap: (url) => launch(url, forceSafariVC: false),
                  onLongPress: (url) => Share.share(url),
                  linkStyle: TextStyle(color: Colors.yellow),
                  highlightedLinkStyle: TextStyle(
                    color: Colors.deepOrangeAccent,
                    backgroundColor: Colors.deepOrangeAccent.withAlpha(0x33),
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "show more" : "show less",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        flag = !flag;
                      });
                    }
                  },
                ),
              ],
            ),
    );
  }
}

basmalah(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        child: Text(
          'Bismillāhir-Raḥmānir-Raḥīm (بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ)',
          style: TextStyle(
              color: Colors.white70,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

header(String text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
    ),
  );
}

boldPoint(String text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10.0,
    ),
  );
}

description(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: EnDescriptionTextWidget(text: text),
  );
}

Center noLocationDetected(onPressed) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          "Couldn't get current position. Please make sure your "
          "location services are turned on and give location access "
          "to Hadith Collection from your device settings",
          textAlign: TextAlign.center,
        ),
      ),
      MaterialButton(
        onPressed: onPressed,
        child: Text('Retry'),
      )
    ],
  ));
}
