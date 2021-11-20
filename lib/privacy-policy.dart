import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customWidgets/common_widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static final String id = 'PrivacyPolicyScreen';

  policyPoints(
      {String headerText,
      String boldPointText,
      String descriptionText,
      BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header(headerText, context),
        boldPoint(boldPointText, context),
        description(descriptionText),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                basmalah(context),
                policyPoints(
                  headerText: 'PRIVACY NOTICE',
                  boldPointText: 'Last updated July 27, 2021',
                  descriptionText: privacyNotice,
                  context: context,
                ),
                policyPoints(
                  headerText: '1. WHAT INFORMATION DO WE COLLECT?',
                  boldPointText: 'We do not collect any information from you',
                  descriptionText: informationWeCollect,
                  context: context,
                ),
                policyPoints(
                  headerText: '2. WILL YOUR INFORMATION BE SHARED WITH ANYONE?',
                  boldPointText:
                      'We do not collect, store or share any of your information.',
                  descriptionText: informationShared,
                  context: context,
                ),
                policyPoints(
                  headerText:
                      '3. IS YOUR INFORMATION TRANSFERRED INTERNATIONALLY?',
                  boldPointText:
                      ' We do not collect, store nor transfer your information anywhere',
                  descriptionText: informationTransferred,
                  context: context,
                ),
                policyPoints(
                  headerText: '4. HOW LONG DO WE KEEP YOUR INFORMATION?',
                  boldPointText: 'We do not keep your information',
                  descriptionText: howLongKeepInfo,
                  context: context,
                ),
                policyPoints(
                  headerText: '5. HOW DO WE KEEP YOUR INFORMATION SAFE?',
                  boldPointText: 'We do not keep your information',
                  descriptionText: howKeepInfoSafe,
                  context: context,
                ),
                policyPoints(
                  headerText: '6. DO WE COLLECT INFORMATION FROM MINORS?',
                  boldPointText:
                      'We do not knowingly collect data from anyone including minors.',
                  descriptionText: infoFromMinors,
                  context: context,
                ),
                policyPoints(
                  headerText: '7. WHAT ARE YOUR PRIVACY RIGHTS?',
                  boldPointText:
                      'You may revoke app permisions and uninstall the app at anytime',
                  descriptionText: privacyRights,
                  context: context,
                ),
                policyPoints(
                  headerText: '8. CONTROLS FOR DO-NOT-TRACK FEATURES',
                  boldPointText: '',
                  descriptionText: doNotTrack,
                  context: context,
                ),
                policyPoints(
                  headerText:
                      '9. DO CALIFORNIA RESIDENTS HAVE SPECIFIC PRIVACY RIGHTS?',
                  boldPointText:
                      'Yes, if you are a resident of California, you are granted specific rights regarding access to your personal information.',
                  descriptionText: caliRights,
                  context: context,
                ),
                policyPoints(
                  headerText: '10. DO WE MAKE UPDATES TO THIS NOTICE?',
                  boldPointText:
                      'Yes, we will update this notice as necessary to stay compliant with relevant laws.',
                  descriptionText: noticeUpdate,
                  context: context,
                ),
                policyPoints(
                    headerText: '11. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?',
                    boldPointText:
                        'If you have questions or comments about this notice, you may email us at info@umratech.com or contact us through the app store',
                    context: context,
                    descriptionText: '.....'),
                policyPoints(
                    context: context,
                    headerText:
                        '12. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?',
                    boldPointText:
                        'You have the right to revoke apps permission to get access to your location',
                    descriptionText: '.....'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String privacyNotice =
    'Thank you for downloading Hadith Collection app, an app from UMRA Tech (“Company”, “we”, “us”, or “our”). '
    'We are committed to protecting your personal information and your right to privacy. '
    'If you have any questions or concerns about this privacy notice, or our practices with '
    'regards to our apps access, please email us .When you use our mobile application, '
    'as the case may be (the "App") and more generally, use any of our services (the "Services", '
    'which include the App), we appreciate that you are trusting us with access to your location. '
    'We take your privacy very seriously. In this privacy notice, we seek to explain to you in the'
    ' clearest way possible what our app does, what access it has and what rights you have in '
    'relation to it. We hope you take some time to read through it carefully, as it is important. '
    'If there are any terms in this privacy notice that you do not agree with, please discontinue '
    'use of our app immediately. This privacy notice applies to all functions of our app. '
    'Please read this privacy notice carefully as it will help you understand what our app '
    'does with your location data.';

String informationWeCollect =
    'If you use our App, we do not collect any of your information. '
    'The app (Hadith Collection) will only ask for permission to access your '
    'location data which will be used to accurately get and display the current '
    'Halal locations and Mosques in your area. We do not collect or keep your '
    'location data anywhere. It stays in your device. If you wish to not grant '
    'it access you can always deny to give it access and uninstall the app '
    'or you can grant it access only while the app is in use. If you wish '
    'to change the access or permissions, " you may do so in your device’s '
    'settings.The access is primarily needed to show and maintain " '
    'accurate locations near you';

String informationShared =
    'We do not collect, store or share any of your information.';

String informationTransferred =
    'We do not collect, store , share or transfer any of your information.';

String howLongKeepInfo =
    'We do not collect, keep, share or transfer any of your information.';

String howKeepInfoSafe =
    'We do not collect, keep, share or transfer any of your information.';

String infoFromMinors =
    'We do not collect, keep, share or transfer any information from minors. '
    'By using the App, you represent that you are at least 18 or that you are '
    'the parent or guardian of such a minor and consent to such minor dependent’s use of the App.';

String privacyRights =
    'If you are resident in the European Economic Area and you believe we are unlawfully'
    ' processing your personal information, you also have the right to complain to your'
    ' local data protection supervisory authority. You can find their contact details '
    'here: http://ec.europa.eu/justice/data-protect ion/bodies/authorities/index_en.htm. '
    'If you are resident in Switzerland, the contact details for the data protection '
    'authorities are available here: https://www.edoeb.admin.ch/edoeb/en/home.html. '
    'If you have questions or comments about your privacy rights, you may email us. '
    'If you would at any time like to revoke access to your location or uninstall our'
    ' app, you can do so in your phone settings and uninstall the app.';

String doNotTrack =
    'Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track (“DNT”)'
    ' feature or setting you can activate to signal your privacy preference not to have data about your online browsing '
    'activities monitored and collected. At this stage, no uniform technology standard for recognizing and implementing DNT'
    ' signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically'
    ' communicates your choice not to be tracked online. If a standard for online tracking is adopted that we must follow in the future,'
    ' we will inform you about that practice in a revised version of this privacy notice.';

String caliRights = 'We assure you that we do not collect, store, '
    'share or transfer any of your information but California Civil'
    ' Code Section 1798.83, also known as the “Shine The Light” law, '
    'permits our users who are California residents to request and '
    'obtain from us, once a year and free of charge, information about'
    ' categories of personal information(if any) we disclosed to third'
    ' parties for direct marketing purposes and the names and addresses '
    'of all third parties with which we shared personal information in '
    'the immediately preceding calendar year.If you are a Californian '
    'resident and would like to make such a request, please submit your '
    'request in writing to us using our email';

String noticeUpdate = 'We may update this privacy notice from time to time. '
    'The updated version will be indicated by an updated '
    '“Revised” date and the updated version will be effective '
    'as soon as it is accessible. If we make material changes '
    'to this privacy notice, we may notify you either by '
    'prominently posting a notice of such changes or by directly'
    ' sending you a notification. We encourage you to review this '
    'privacy notice frequently to be informed of how we are protecting your information.';
