import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customWidgets/common_widgets.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  basmalah(context),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableAutoLinkText(
                        'As-salāmu ʿalaykum Ummah of Muhammad Rasool Allah sallallaahu alaihi wa sallam!\n\n'
                        'My name is Tahir, the founder of UMRA Tech which is a company that I started with the intention of building free, '
                        'privacy focused Islamic apps.\n'
                        '\n'
                        'What motivated me to start this project was the scandal regarding the most popular '
                        'Islamic app out there and what they did with the data they were collecting from '
                        'Muslims as well as showing inappropriate ads in their app for non-premium users.\n\nInshaAllah I want to give '
                        'Muslims Islamic apps that are free, ad-free and privacy-focused. '
                        'So UMRA Tech and this app i.e Hadith Collection is owned by me, Tahir, not a corporation. '
                        'UMRA Tech and Hadith Collection are still in infant stages and we\'ve got a long way to go. '
                        'I believe success is with Allah alone and with your support we can get these apps to '
                        'reach many muslims around the world.'
                        '\n'
                        '\n'
                        'UMRA Tech stands for Ummat Muhammad Rasool Allah Technologies.\n\n'
                        'Support this project by \n'
                        '1. Making dua for us \n'
                        '2. Reporting bugs/issues to\n'
                        '     • umratechnologies@gmail.com\n\n'
                        '3. Following our social media accounts \n'
                        '     • https://www.instagram.com/umratechnologies/\n'
                        '     • https://twitter.com/umratech\n'
                        '     • https://www.facebook.com/umratech\n\n'
                        '4. Downloading all our apps from\n'
                        '     • https://linktr.ee/Umratech\n\n'
                        '5. Share our apps with other Muslims\n\n'
                        'We pray and hope that Allah will use this app to bring a lot of benefit to you.\n\n'
                        'JazakAllah khair!',
                        onTap: (url) => launch(url, forceSafariVC: false),
                        onLongPress: (url) => Share.share(url),

                        // for use with flutter_linkify: ^5.0.2
                        // onOpen: (link) async {
                        //   if (!Platform.isAndroid) {
                        //     if (await canLaunch(link.url)) {
                        //       await launch(link.url);
                        //     } else {
                        //       throw 'Could not launch $link';
                        //     }
                        //   } else {
                        //     Navigator.of(context).push(
                        //       CupertinoPageRoute(
                        //         builder: (route) =>
                        //             WebInfoView(link.url, link.url),
                        //       ),
                        //     );
                        //   }
                        // },

                        style: TextStyle(color: Colors.white, fontSize: 16),
                        linkStyle: TextStyle(color: Colors.blue),
                        highlightedLinkStyle: TextStyle(
                          color: Colors.deepOrangeAccent,
                          backgroundColor:
                              Colors.deepOrangeAccent.withAlpha(0x33),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
