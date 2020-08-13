import 'package:flutter/material.dart';
import 'engine/domain/model/git_repository.dart';

import 'engine/domain/use.case/repository_usecase.dart';
import 'engine/ui/source_resources.dart';
import 'engine/ui/view/repository/list/list_repositories_view.dart';


void main() {
  runApp(MainWidget(SelectRepositoryView()));
//https://medium.com/@maffan/how-to-create-a-side-menu-in-flutter-a2df7833fdfb
  //Git().add().all().call().then((branches) => print(branches));
  //Git().commit().message("commitado pelo app").call().then((branches) => print(branches));
  //Git().push("tiagocasemiro", "password").then((branches) => print(branches));
  //Git().add().all().call().then((value) => print(value));
  //Git().checkout().branch("develop").call().then((value) => print(value));
  //Git().branch().delete("develop").call().then((branches) => print(branches));
  //Git().isGitDirectory().then((branches) => print(branches));
  //Git().log().graph().pretty(Log.historyFormat).call().then((branches) => print(branches));
  //Git().restore().files(['cument_5.txt']).call();
  //StartRepositoryUseCase().startGitApplication(workDirectory, username, password).then((value) => print(value));

 // String workDirectory = "/home/tiagocasemiro/Documentos/projetos/pessoal/documentation";

 // RepositoryUseCase().addLocalRepository("Documentation", workDirectory).then((value) => print(value)); // SQLite dont work on desktop

/*  RepositoryUseCase().allLocalRepository().then((List<Repository> repositories) {
    repositories.forEach((element) {
      print(element);
    });
  });*/

  //var repository = Repository("Documentation", workDirectory);

  //RepositoryUseCase().deleteLocalRepository(repository).then((value) => print(value));

  //Alternatives

  // NoSql key value storage
  //https://github.com/tekartik/sembast.dart/blob/master/sembast/doc/open.md
  //https://pub.dev/packages/sembast
  //https://pub.dev/packages/sembast/example

  // File
  //https://flutter.dev/docs/cookbook/persistence/reading-writing-files
}

class MainWidget extends StatelessWidget {
  final Widget _page;

  MainWidget(this._page);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Source',
        theme: ThemeData(
          primaryColor: SourceColors.grey[4],
          accentColor: SourceColors.blue,
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: _page,
    );
  }
}
