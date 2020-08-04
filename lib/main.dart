import 'package:flutter/material.dart';
import 'package:source_app/engine/domain/use.case/initial_usecase.dart';
import 'engine/shell/git/command/log.dart';
import 'engine/shell/git/git.dart';


void main() {
  runApp(SourceApp());

  //Git().add().all().call().then((branches) => print(branches));
  //Git().commit().message("commitado pelo app").call().then((branches) => print(branches));
  //Git().push("tiagocasemiro", "password").then((branches) => print(branches));
  //Git().add().all().call().then((value) => print(value));
  //Git().checkout().branch("develop").call().then((value) => print(value));
  //Git().branch().delete("develop").call().then((branches) => print(branches));

  //Git().isGitDirectory().then((branches) => print(branches));

  //Git().log().graph().pretty(Log.historyFormat).call().then((branches) => print(branches));

  //Git().restore().files(['cument_5.txt']).call();

  InitialUseCase().startGitApplication();
  Git().log().graph().pretty(Log.historyFormat).call().then((branches) => print(branches));
}

/*Future<void> main() async {
  print('Current directory: ${p.current}');

  if (await GitDir.isGitDir(p.current)) {
    final gitDir = await GitDir.fromExisting(p.current);
    final commitCount = await gitDir.commitCount();
    print('Git commit count: $commitCount');
  } else {
    print('Not a Git directory');
  }
}*/

class SourceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Source',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(
        color: Colors.white,
      ),
    );
  }
}
