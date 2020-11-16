/// Made by Tejas Mehta
/// Made on Tuesday, August 25, 2020
/// File Name: about.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/widgets/bullet_list_text.dart';
import 'package:portfolio/util/route_controller.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:portfolio/widgets/dynamic_padding.dart';

class About extends StatefulWidget {
  static final String route = "about";
  ///CreateState method
  ///Sets the state of the app (rebuilt each time a UI change is needed)
  @override
  State<StatefulWidget> createState() {
    return AboutState();
  }
}

class AboutState extends State<About> with WidgetsBindingObserver {
  ///InitState method
  ///Currently only sets a listener for any light/dark theme changes
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      RouteController.of(context).updateRoute("about");
    });
    WidgetsBinding.instance.addObserver(this);

  }


  ///Dispose method
  ///Currently only removes the observer set in initState for the light/dark theme changes
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ///didChangePlatformBrightness method
  ///Only changes the listener's state to the theme allowing to change the theme while user is on the screen
  @override
  void didChangePlatformBrightness() {
    WidgetsBinding.instance.window.platformBrightness;
  }


  ///Main widget build method
  ///Builds the UI on this screen
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DynamicPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: makeProfilePic(),
              ),
              Padding(padding: const EdgeInsets.all(5)),
              Text("About", style: Theme.of(context).textTheme.headline4,),
              Padding(padding: const EdgeInsets.all(5)),
              Text("Hello! I'm a ${getAge()} year old Software Developer who loves experimenting with various new languages, technologies, and tools. "
                  "I'm currently a high school student in New Jersey looking to expand my horizon of Computer Science knowledge. Aside from development, "
                  "I love hiking outdoors, playing video games and watching new TV shows and movies! If you didn't know, I'm also a huge Star Wars fan!"),
              Padding(padding: const EdgeInsets.all(10)),
              Text("Experience", style: Theme.of(context).textTheme.headline4,),
              Padding(padding: const EdgeInsets.all(5)),
              Text("Flutter & Dart:"),
              BulletListText("Over 2 years, started writing code with Flutter & Dart in 2018 during Flutter's beta phase"),
              BulletListText("Freelance Development utilizing Flutter to build applications for various clients"),
              BulletListText("Experienced in complex skills such as isolate computation for encryption & efficient state management "),
              Padding(padding: const EdgeInsets.all(5)),
              Text("Java/Kotlin & Android:"),
              BulletListText("Over 4 years, where I started writing code in Java consistently in 7th grade"),
              BulletListText("Primarily Java and Android"),
              BulletListText("Worked with various Android apps written with Java, but have no trouble interpreting and utilizing Kotlin"),
              Padding(padding: const EdgeInsets.all(5)),
              Text("Swift/Objective-C & iOS/macOS:"),
              BulletListText("Over 2 years, where I started taking a look at Objective-C code in various Open Source macOS apps"),
              BulletListText("Primarily in swift for macOS development through AppKit"),
              BulletListText("Wrote iOS specific features in Swift within Flutter apps"),
              Padding(padding: const EdgeInsets.all(5)),
              createResumeViewOpen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget createResumeViewOpen() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Resume (",
            style: Theme.of(context).textTheme.bodyText2
          ),
          TextSpan(
            text: "View",
            style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.blue)),
            recognizer: TapGestureRecognizer()
              ..onTap = viewResume,
          ),
          TextSpan(
            text: " / ",
            style: Theme.of(context).textTheme.bodyText2
          ),
          TextSpan(
              text: "Download",
              style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.blue)),
              recognizer: TapGestureRecognizer()
                ..onTap = downloadResume,
          ),
          TextSpan(
            text: ")",
            style: Theme.of(context).textTheme.bodyText2
          ),
        ]
      ),
    );
  }

  void callJS() {
    js.context.callMethod('createAndRedirect', ["price_1HLJr5Ge8QXeWO1XzL92REy5"]);
  }

  int getAge() {
    DateTime now = DateTime.now();
    DateTime birthday = DateTime(2003, 12, 19);
    return (now.difference(birthday).inDays/365).floor();
  }

  Future<void> viewResume() async {
    ByteData fileData = await rootBundle.load("assets/resume.pdf");
    final blob = html.Blob([fileData], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
  }

  Future<void> downloadResume() async {
    ByteData fileData = await rootBundle.load("assets/resume.pdf");
    final blob = html.Blob([fileData], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor =
    html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'Mehta_Tejas-Resume.pdf';
    html.document.body.children.add(anchor);
    anchor.click();
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }



  Widget makeProfilePic() {
    return ClipOval(
      child: Image.asset(
        "assets/profilepic.jpg",
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

}
