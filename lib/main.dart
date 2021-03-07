import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'engine/ui/source_resources.dart';
import 'engine/ui/screen/repository/list/list_repositories_view.dart';
import 'dart:convert';

/*
void shell() async {
  const Map<String, String> _language = {'LANG':'en_GB'};
  var process = await Process.start('git', ["remote", "show", "origin",], workingDirectory: "/directory/repo"
  ,environment: _language);
  process.stdout.transform(utf8.decoder).listen((data) {
    if(data.contains("password")) {
      process.stdin.write("123456");
    }
    print(data);
  });
  process.stderr.transform(utf8.decoder).listen((data) {
    print(data);
  });
  process.exitCode.then((exitCode) {
    print(exitCode);
  });
}
*/

void main() {
  runApp(MainWidget(SelectRepositoryView()));
  //runApp(MainWidget(MyApp()));
  //runApp(new MaterialApp(home: new MyApp(), debugShowCheckedModeBanner: false,),);
  //runApp(AnimatedListSample());

//https://medium.com/@leonar.d/how-to-create-a-flutter-split-view-7e2ac700ea12
  //Git().add().all().call().then((branches) => print(branches));
  //Git().commit().message("commitado pelo app").call().then((branches) => print(branches));
  //Git().push("tiagocasemiro", "password").then((branches) => print(branches));
  //Git().add().all().call().then((value) => print(value));
  //Git().checkout().branch("develop").call().then((value) => print(value));
  //Git().branch().delete("develop").call().then((branches) => print(branches));
  //Git().isGitDirectory().then((branches) => print(branches));
  //Git().log().graph().pretty(Log.historyFormat).call().then((branches) => print(branches));
  //Git().restore().files(['cument_5.txt']).call();

  //credenciais
  //https://stackoverflow.com/questions/35942754/how-to-save-username-and-password-in-git-gitextension

  //context menu
  //https://pub.dev/packages/bot_toast

  //gitclone
  //https://www.atlassian.com/br/git/tutorials/setting-up-a-repository/git-clone

  //Alternatives
  //Seguimented control
  //https://medium.com/flutterpub/segmentedcontrol-in-flutter-643685290adb

  // File
  //https://flutter.dev/docs/cookbook/persistence/reading-writing-files
  //https://pub.dev/packages/material_segmented_control

  //spannable listview
  //https://stackoverflow.com/questions/50530152/how-to-create-expandable-listview-in-flutter
  //https://medium.com/flutter-community/flutter-expansion-collapse-view-fde9c51ac438

  //Flex with listview
  //https://www.youtube.com/watch?v=_rnZaagadyo
  //https://www.youtube.com/watch?v=z5iw2SeFx2M
}

class MainWidget extends StatelessWidget {
  final Widget _page;

  MainWidget(this._page);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Source',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: SourceColors.grey[4],
          accentColor: SourceColors.blue[2],
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: _page,
    );
  }
}


/*
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Vehicle veicle =new Vehicle(
    'Branch local',
    ['RECHARGE-024', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099', 'RECHARGE-084', 'RECHARGE-075', 'RECHARGE-099'],
    Icons.call_merge,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ExpansionTile(
        title:  new ListTile(
          contentPadding: const EdgeInsets.all(4),
          title: Text(veicle.title, style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            color: SourceColors.blue[2],
            fontSize: 12.0,
          ),),
          leading: Image.asset("images/branch-local.png", width: 10, height: 10, fit: BoxFit.scaleDown,),
        ),

        children: <Widget>[
          new Column(
            children: _buildExpandableContent(veicle),
          ),
        ],
      ),
    );
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          contentPadding: const EdgeInsets.all(4),
          title: Text(content, style: new TextStyle(fontSize: 18.0),),
          leading: Padding(child: Image.asset("images/branch-local.png"), padding: const EdgeInsets.all(16),),
        ),
      );

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];
  final IconData icon;

  Vehicle(this.title, this.contents, this.icon);
}*/
