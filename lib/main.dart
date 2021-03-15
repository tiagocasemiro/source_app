import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'engine/ui/source_resources.dart';
import 'engine/ui/screen/repository/list/list_repositories_view.dart';

void main() {

  runApp(MainWidget(SelectRepositoryView()));

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
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
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